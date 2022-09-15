import 'dart:math';
import 'dart:typed_data';

import 'package:encryptor/encryptor.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/factories/WalletProxy.g.dart';
import 'package:wallet_dart/contracts/wallet.dart';
import 'package:wallet_dart/wallet/UserOperation.dart';
import 'package:wallet_dart/wallet/wallet_instance.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/src/utils/length_tracking_byte_sink.dart';
import 'package:web3dart/web3dart.dart';

class WalletHelpers {
  static String _generatePasswordKey(String password, String salt){
    PassCrypt scrypt = PassCrypt.scrypt(cpu: 16384, mem: 8, par: 1);
    return scrypt.hash(salt: salt, inp: password, len: 32);
  }

  static Credentials? decryptSigner(WalletInstance wallet, String password, String salt){
    try {
      String passwordKey = _generatePasswordKey(password, salt);
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

  static Future<WalletInstance> createRecovery(String walletAddress, String password, String salt) async{
    var rng = Random.secure();
    EthPrivateKey signer = EthPrivateKey.createRandom(rng);
    //
    String passwordKey = _generatePasswordKey(password, salt);
    AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: passwordKey);
    //
    EthereumAddress initOwner = await signer.extractAddress();
    //
    return WalletInstance(
      walletAddress: EthereumAddress.fromHex(walletAddress),
      initImplementation: CWallet.address.hex,
      initOwner: initOwner.hex,
      initGuardians: [],
      salt: salt,
      encryptedSigner: aesCrypt.cbc.encrypt(
        inp: bytesToHex(signer.privateKey, include0x: true),
        iv: salt
      ).toString(),
    );
  }

  static Future<WalletInstance> createRandom(String password, String salt) async{
    var rng = Random.secure();
    EthPrivateKey signer = EthPrivateKey.createRandom(rng);
    //
    String passwordKey = _generatePasswordKey(password, salt);
    AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: passwordKey);
    //
    EthereumAddress initOwner = await signer.extractAddress();
    //
    return WalletInstance(
      walletAddress: EthereumAddress.fromHex(getWalletAddress(initOwner, [])),
      initImplementation: CWallet.address.hex,
      initOwner: initOwner.hex,
      initGuardians: [],
      salt: salt,
      encryptedSigner: aesCrypt.cbc.encrypt(
        inp: bytesToHex(signer.privateKey, include0x: true),
        iv: salt
      ).toString(),
    );
  }

  static String getWalletAddress(EthereumAddress initOwner, List<EthereumAddress> initGuardians){
    return _WalletHelperUtils.getCreate2Address(
      Constants.singletonFactoryAddress,
      hexToBytes(bytesToHex(String.fromCharCode(UserOperation.initNonce).codeUnits, include0x: true, forcePadLength: 64)),
      keccak256(getInitCode(initOwner, initGuardians)),
    );
  }

  static Uint8List getInitCode(EthereumAddress initOwner, List<EthereumAddress> initGuardians){
    var walletFunctionData = CWallet.interface.self.function("initialize").encodeCall([initOwner, []]);
    //
    var deployFunction = CWallet.proxyInterface.self.functions.where((element) => element.name == "").first;
    var deployCodeFull = deployFunction.encodeCall([CWallet.address, walletFunctionData]);
    var deployCode = deployCodeFull.sublist(4);
    //
    LengthTrackingByteSink sink = LengthTrackingByteSink();
    sink.add(WalletProxy.byteCode);
    sink.add(deployCode);
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