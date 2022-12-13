import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/scrypt.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/entrypoint.dart';
import 'package:wallet_dart/contracts/factories/EIP4337Manager.g.dart';
import 'package:wallet_dart/contracts/factories/SafeProxy.g.dart';
import 'package:wallet_dart/contracts/factories/SocialRecoveryModule.g.dart';
import 'package:wallet_dart/utils/abi_utils.dart';
import 'package:wallet_dart/wallet/user_operation.dart';
import 'package:wallet_dart/wallet/wallet_instance.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/src/utils/length_tracking_byte_sink.dart';
import 'package:web3dart/web3dart.dart';

class WalletHelpers {

  static Future<String> _generatePasswordKey(Map args) async{
    final Scrypt scrypt = Scrypt();
    scrypt.init(ScryptParameters(16384, 8, 1, 32, base64Decode(args["salt"])));
    var passwordBytes = utf8.encode(args["password"]) as Uint8List;
    var keyBytes = scrypt.process(passwordBytes);
    return base64.encode(keyBytes);
  }

  static Future<String> _generatePasswordKeyThread(String password, String salt) async{
    var key = await compute(_generatePasswordKey, {'password': password, 'salt': salt});
    return key;
  }

  static Future<WalletInstance?> reEncryptSigner(WalletInstance wallet, String newPassword, String salt, {EthPrivateKey? credentials, String? password}) async{
    WalletInstance newInstance = WalletInstance.fromJson(wallet.toJson());
    Uint8List privateKeyBytes;
    if (credentials != null){
      privateKeyBytes = credentials.privateKey;
    }else{
      if (password == null) return null;
      var _credentials = await decryptSigner(wallet, password, salt);
      if (_credentials == null) return null;
      privateKeyBytes = (_credentials as EthPrivateKey).privateKey;
    }
    String newPasswordKey = await _generatePasswordKeyThread(newPassword, salt);
    AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: newPasswordKey);
    newInstance.encryptedSigner = aesCrypt.cbc.encrypt(
        inp: bytesToHex(privateKeyBytes, include0x: true),
        iv: salt
    ).toString();
    return newInstance;
  }

  static Future<Credentials?> decryptSigner(WalletInstance wallet, String password, String salt) async {
    try {
      String passwordKey = await _generatePasswordKeyThread(password, salt);
      AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: passwordKey);
      String privateKey = aesCrypt.cbc.decrypt(enc: wallet.encryptedSigner, iv: salt);
      var privateKeyBytes = hexToBytes(privateKey);
      if (privateKeyBytes.length > 32){
        int trim = privateKeyBytes.length - 32;
        privateKeyBytes = privateKeyBytes.sublist(trim);
      }
      return EthPrivateKey(privateKeyBytes);
    } catch (e) {
      return null;
    }
  }

  static Future<WalletInstance> createRecovery(String walletAddress, String moduleManagerAddress, String socialRecoveryAddress, String password, String salt) async{
    var rng = Random.secure();
    EthPrivateKey signer = EthPrivateKey.createRandom(rng);
    //
    String passwordKey = await _generatePasswordKeyThread(password, salt);
    AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: passwordKey);
    //
    EthereumAddress initOwner = await signer.extractAddress();
    //
    return WalletInstance(
      walletAddress: EthereumAddress.fromHex(walletAddress),
      moduleManager: EthereumAddress.fromHex(moduleManagerAddress),
      socialRecovery: EthereumAddress.fromHex(socialRecoveryAddress),
      initOwner: initOwner.hex,
      initGuardians: [],
      salt: salt,
      encryptedSigner: aesCrypt.cbc.encrypt(
        inp: bytesToHex(signer.privateKey, include0x: true),
        iv: salt
      ).toString(),
    );
  }

  static Future<WalletInstance> createRandom(String password, String salt, [List<EthereumAddress> initGuardians = const []]) async{
    var rng = Random.secure();
    EthPrivateKey signer = EthPrivateKey.createRandom(rng);
    //
    String passwordKey = await _generatePasswordKeyThread(password, salt);
    AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: passwordKey);
    //
    EthereumAddress initOwner = await signer.extractAddress();
    //
    EthereumAddress moduleManager = EthereumAddress.fromHex(getWalletManagerAddress(salt));
    EthereumAddress socialRecovery = EthereumAddress.fromHex(getSocialRecoveryAddress(salt));
    //
    return WalletInstance(
      walletAddress: EthereumAddress.fromHex(
        getWalletAddress(initOwner, moduleManager)
      ),
      moduleManager: moduleManager,
      socialRecovery: socialRecovery,
      initOwner: initOwner.hexEip55,
      initGuardians: initGuardians,
      salt: salt,
      encryptedSigner: aesCrypt.cbc.encrypt(
        inp: bytesToHex(signer.privateKey, include0x: true),
        iv: salt
      ).toString(),
    );
  }

  static String getWalletAddress(EthereumAddress initOwner, EthereumAddress moduleManager){
    return _WalletHelperUtils.getCreate2Address(
      Constants.singletonFactoryAddress,
      hexToBytes(bytesToHex(String.fromCharCode(UserOperation.initNonce).codeUnits, include0x: true, forcePadLength: 64)),
      keccak256(getInitCode(initOwner, moduleManager)),
    );
  }

  static String getWalletManagerAddress(String _salt){
    Uint8List salt = keccak256(Uint8List.fromList("${_salt}_moduleManager".codeUnits));
    return _WalletHelperUtils.getCreate2Address(
      Constants.singletonFactoryAddress,
      salt,
      keccak256(getManagerInitCode()),
    );
  }

  static String getSocialRecoveryAddress(String _salt){
    Uint8List salt = keccak256(Uint8List.fromList("${_salt}_socialRecovery".codeUnits));
    return _WalletHelperUtils.getCreate2Address(
      Constants.singletonFactoryAddress,
      salt,
      keccak256(getSocialRecoveryInitCode()),
    );
  }

  static Uint8List getInitCode(EthereumAddress initOwner, EthereumAddress moduleManager){
    EthereumAddress gnosisSafeSingleton = EthereumAddress.fromHex("0x3E5c63644E683549055b9Be8653de26E0B4CD36E");
    //
    var walletProxyArgsEncoded = encodeAbi(
        ['address', 'address', 'address'],
        [gnosisSafeSingleton, moduleManager, initOwner]);
    //
    LengthTrackingByteSink sink = LengthTrackingByteSink();
    sink.add(SafeProxy.byteCode);
    sink.add(walletProxyArgsEncoded);
    return sink.asBytes();
  }

  static Uint8List getManagerInitCode(){
    var managerArgsEncoded = encodeAbi(
        ['address'],
        [CEntrypoint.address]);
    //
    LengthTrackingByteSink sink = LengthTrackingByteSink();
    sink.add(EIP4337Manager.byteCode);
    sink.add(managerArgsEncoded);
    return sink.asBytes();
  }

  static Uint8List getSocialRecoveryInitCode(){
    LengthTrackingByteSink sink = LengthTrackingByteSink();
    sink.add(SocialRecoveryModule.byteCode);
    return sink.asBytes();
  }
}


class _WalletHelperUtils {

  static getCreate2Address(EthereumAddress from, Uint8List salt, Uint8List initCodeHash){
    Uint8List ff = hexToBytes("0xff");
    String address = _getChecksumAddress(from.hex);
    LengthTrackingByteSink sink = LengthTrackingByteSink();
    //
    sink.add(ff);
    sink.add(hexToBytes(address));
    sink.add(salt);
    sink.add(initCodeHash);
    //
    return _getChecksumAddress(bytesToHex(keccak256(sink.asBytes()), include0x: true).substring(12*2)); // equivalent to hexDataSlice in ethers (12 bytes * 2 (bytes length in hex))
  }

  static String _getChecksumAddress(String address){
    address = address.toLowerCase();
    var chars = address.substring(2).split("");
    var expanded = Uint8List(40);
    for (int i = 0; i < 40; i++) {
      expanded[i] = chars[i].codeUnitAt(0);
    }
    var hashed = keccak256(expanded);
    for (int i = 0; i < 40; i += 2) {
      if ((hashed[i >> 1] >> 4) >= 8) {
        chars[i] = chars[i].toUpperCase();
      }
      if ((hashed[i >> 1] & 0x0f) >= 8) {
        chars[i + 1] = chars[i + 1].toUpperCase();
      }
    }
    return "0x" + chars.join("");
  }
}