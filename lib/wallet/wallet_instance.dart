import 'package:web3dart/web3dart.dart';

class WalletInstance {
  EthereumAddress walletAddress;
  EthereumAddress moduleManager;
  EthereumAddress socialRecovery;
  String initOwner;
  List<EthereumAddress> initGuardians;
  String salt;
  String encryptedSigner;

  WalletInstance(
      {required this.walletAddress,
      required this.moduleManager,
      required this.socialRecovery,
      required this.initOwner,
      required this.initGuardians,
      required this.salt,
      required this.encryptedSigner});

  WalletInstance.fromJson(Map<String, dynamic> json)
      : walletAddress = EthereumAddress.fromHex(json['walletAddress']),
        moduleManager = EthereumAddress.fromHex(json['moduleManager']),
        socialRecovery = EthereumAddress.fromHex(json['socialRecovery']),
        initOwner = json['initOwner'],
        initGuardians = List<EthereumAddress>.from(json['initGuardians'].map((e) => EthereumAddress.fromHex(e))),
        salt = json['salt'],
        encryptedSigner = json['encryptedSigner'];

  Map<String, dynamic> toJson() => {
    'walletAddress': walletAddress.hexEip55,
    'moduleManager': moduleManager.hexEip55,
    'socialRecovery': socialRecovery.hexEip55,
    'initOwner': initOwner,
    'initGuardians': initGuardians.map((e) => e.hex).toList(),
    'salt': salt,
    'encryptedSigner': encryptedSigner,
  };

}