import 'dart:convert';
import 'dart:math';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/scrypt.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:wallet_dart/contracts/gnosis_safe_proxy_facotry.dart';
import 'package:wallet_dart/wallet/encode_function_data.dart';
import 'package:wallet_dart/wallet/account.dart';
import 'package:wallet_dart/wallet/encrypted_signer.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/src/utils/length_tracking_byte_sink.dart';
import 'package:web3dart/web3dart.dart';

class AccountHelpers {

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

  static Future<bool> reEncryptSigner(EncryptedSigner encryptedSigner, String newPassword, {EthPrivateKey? credentials, String? password}) async{
    Uint8List privateKeyBytes;
    String base64Salt = base64Encode(hexToBytes(encryptedSigner.salt));
    if (credentials != null){
      privateKeyBytes = credentials.privateKey;
    }else{
      if (password == null) return false;
      var _credentials = await decryptSigner(encryptedSigner, password);
      if (_credentials == null) return false;
      privateKeyBytes = (_credentials as EthPrivateKey).privateKey;
    }
    String newPasswordKey = await _generatePasswordKeyThread(newPassword, base64Salt);
    AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: newPasswordKey);
    encryptedSigner.encryptedPrivateKey = aesCrypt.cbc.encrypt(
        inp: bytesToHex(privateKeyBytes, include0x: true),
        iv: base64Salt
    ).toString();
    return true;
  }

  static Future<Credentials?> decryptSigner(EncryptedSigner encryptedSigner, String password) async {
    try {
      String base64Salt = base64Encode(hexToBytes(encryptedSigner.salt));
      String passwordKey = await _generatePasswordKeyThread(password, base64Salt);
      AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: passwordKey);
      String privateKey = aesCrypt.cbc.decrypt(enc: encryptedSigner.encryptedPrivateKey, iv: base64Salt);
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

  static Future<Account> createRecovery({
    required int chainId,
    required String name,
    required EthereumAddress address,
    required String salt,
    required List<String> signersIds,
  }) async{
    return Account(
      chainId: chainId,
      name: name,
      address: address,
      salt: salt,
      signersIds: signersIds,
    );
  }

  static Future<EncryptedSigner> createEncryptedSigner({required String salt, required String password}) async{
    String base64Salt = base64Encode(hexToBytes(salt));
    String passwordKey = await _generatePasswordKeyThread(password, base64Salt);
    AesCrypt aesCrypt = AesCrypt(padding: PaddingAES.pkcs7, key: passwordKey);
    var secureRandom = Random.secure();
    EthPrivateKey signer = EthPrivateKey.createRandom(secureRandom);
    return EncryptedSigner(
      salt: salt,
      encryptedPrivateKey: aesCrypt.cbc.encrypt(
        inp: bytesToHex(signer.privateKey, include0x: true),
        iv: base64Salt
      ).toString(),
      publicAddress: signer.address
    );
  }

  static Future<Account> createAccount({
    required int chainId,
    required String name,
    required String salt,
    required List<String> signersIds,
    required List<EthereumAddress> signers,
    required EthereumAddress factory,
    required EthereumAddress singleton,
    required EthereumAddress entrypoint,
    required EthereumAddress fallbackHandler,
    required Web3Client client,
  }) async{
    return Account(
      chainId: chainId,
      name: name,
      address: EthereumAddress.fromHex(
        await getAccountAddress(
          client,
          factory,
          singleton,
          entrypoint,
          fallbackHandler,
          signers,
          BigInt.parse(salt, radix: 16),
        )
      ),
      salt: salt,
      signersIds: signersIds,
      factory: factory,
      singleton: singleton,
      fallback: fallbackHandler,
      entrypoint: entrypoint,
    );
  }

  static Future<String> getAccountAddress(Web3Client client, EthereumAddress factory, EthereumAddress singleton, EthereumAddress entryPoint, EthereumAddress fallbackHandler, List<EthereumAddress> signers, BigInt saltNonce) async {
    Uint8List initializer = hexToBytes(EncodeFunctionData.setupWithEntrypoint(
        signers,
        BigInt.one,
        EthereumAddress.fromHex("0x0000000000000000000000000000000000000000"),
        Uint8List(0),
        fallbackHandler,
        EthereumAddress.fromHex("0x0000000000000000000000000000000000000000"),
        BigInt.zero,
        EthereumAddress.fromHex("0x0000000000000000000000000000000000000000"),
        entryPoint
    ));
    //
    Uint8List proxyBytecode = await IGnosisSafeProxyFactory.interface(address: factory, client: client).proxyCreationCode();
    //
    Uint8List salt = keccak256(AbiUtil.solidityPack(["bytes32", "uint256"], [keccak256(initializer), saltNonce]));
    Uint8List deploymentData = AbiUtil.solidityPack(["bytes", "uint256"], [proxyBytecode, BigInt.parse(singleton.hexNo0x, radix: 16)]);
    return _AccountHelperUtils.getCreate2Address(
      factory,
      salt,
      keccak256(deploymentData),
    );
  }

  static Uint8List getInitCode(EthereumAddress singleton, EthereumAddress entryPoint, EthereumAddress fallbackHandler, List<EthereumAddress> signers, BigInt saltNonce){
    Uint8List initializer = hexToBytes(EncodeFunctionData.setupWithEntrypoint(
        signers,
        BigInt.one,
        EthereumAddress.fromHex("0x0000000000000000000000000000000000000000"),
        Uint8List(0),
        fallbackHandler,
        EthereumAddress.fromHex("0x0000000000000000000000000000000000000000"),
        BigInt.zero,
        EthereumAddress.fromHex("0x0000000000000000000000000000000000000000"),
        entryPoint
    ));
    return hexToBytes(EncodeFunctionData.createProxyWithNonce(singleton, initializer, saltNonce));
  }

}


class _AccountHelperUtils {

  static getCreate2Address(EthereumAddress from, Uint8List salt, Uint8List initCodeHash){
    Uint8List ff = hexToBytes("0xff");
    String address = _getChecksumAddress(from.hex);
    LengthTrackingByteSink sink = LengthTrackingByteSink();
    //
    sink.add(ff);
    sink.add(hexToBytes(address));
    sink.add(salt);
    sink.add(initCodeHash);
    var sinkBytes = sink.asBytes();
    sink.close();
    //
    return _getChecksumAddress(bytesToHex(keccak256(sinkBytes), include0x: true).substring(12*2)); // equivalent to hexDataSlice in ethers (12 bytes * 2 (bytes length in hex))
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