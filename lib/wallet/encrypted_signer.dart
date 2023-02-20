import 'package:web3dart/web3dart.dart';

class EncryptedSigner {
  String salt;
  String encryptedPrivateKey;
  EthereumAddress publicAddress;

  EncryptedSigner({
    required this.salt,
    required this.encryptedPrivateKey,
    required this.publicAddress
  });

  EncryptedSigner.fromJson(Map json)
      : salt = json['salt'],
        encryptedPrivateKey = json['encryptedPrivateKey'],
        publicAddress = EthereumAddress.fromHex(json['publicAddress']);

  Map<String, dynamic> toJson() => {
    'salt': salt,
    'encryptedPrivateKey': encryptedPrivateKey,
    'publicAddress': publicAddress.hexEip55,
  };
}