import 'dart:convert';

import 'package:web3dart/web3dart.dart';

class WalletInstance {
  EthereumAddress walletAddress;
  String initImplementation;
  String initOwner;
  List<EthereumAddress> initGuardians;
  String salt;
  String encryptedSigner;

  WalletInstance(
      {required this.walletAddress,
      required this.initImplementation,
      required this.initOwner,
      required this.initGuardians,
      required this.salt,
      required this.encryptedSigner});

  WalletInstance.fromJson(Map<String, dynamic> json)
      : walletAddress = EthereumAddress.fromHex(json['walletAddress']),
        initImplementation = json['initImplementation'],
        initOwner = json['initOwner'],
        initGuardians = List<EthereumAddress>.from(json['initGuardians'].map((e) => EthereumAddress.fromHex(e))),
        salt = json['salt'],
        encryptedSigner = json['encryptedSigner'];

  Map<String, dynamic> toJson() => {
    'walletAddress': walletAddress.hex,
    'initImplementation': initImplementation,
    'initOwner': initOwner,
    'initGuardians': initGuardians.map((e) => e.hex).toList(),
    'salt': salt,
    'encryptedSigner': encryptedSigner,
  };

}