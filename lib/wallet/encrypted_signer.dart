import 'package:web3dart/web3dart.dart';

class EncryptedSigner {
  String version;
  String salt;
  String encryptedPrivateKey;
  EthereumAddress publicAddress;

  EncryptedSigner({
    required this.version,
    required this.salt,
    required this.encryptedPrivateKey,
    required this.publicAddress
  });

  EncryptedSigner.fromJson(Map json)
      : version = json['version'] ?? "0.0.0",
        salt = json['salt'],
        encryptedPrivateKey = json['encryptedPrivateKey'],
        publicAddress = EthereumAddress.fromHex(json['publicAddress']);

  Map<String, dynamic> toJson() => {
    'version': version,
    'salt': salt,
    'encryptedPrivateKey': encryptedPrivateKey,
    'publicAddress': publicAddress.hexEip55,
  };
}