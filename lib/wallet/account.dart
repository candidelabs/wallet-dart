import 'package:web3dart/web3dart.dart';

class Account {
  String version;
  int chainId;
  EthereumAddress address;
  List<String> signersIds;
  String name;
  String salt;
  String? recoveryId;
  EthereumAddress? socialRecoveryModule;
  EthereumAddress? factory;
  EthereumAddress? singleton;
  EthereumAddress? fallback;
  EthereumAddress? entrypoint;

  Account(
      {required this.version,
      required this.chainId,
      required this.address,
      required this.signersIds,
      required this.name,
      required this.salt,
      this.recoveryId,
      this.socialRecoveryModule,
      this.factory,
      this.singleton,
      this.fallback,
      this.entrypoint});

  Account.fromJson(Map json)
      : version = json['version'] ?? "0.0.0",
        chainId = json['chainId'],
        name = json['name'],
        address = EthereumAddress.fromHex(json['address']),
        signersIds = json['signersIds'],
        salt = json['salt'],
        recoveryId = json['recoveryId'],
        socialRecoveryModule = json['socialRecoveryModule'] != null ? EthereumAddress.fromHex(json['socialRecoveryModule']) : null,
        factory = json['factory'] != null ? EthereumAddress.fromHex(json['factory']) : null,
        singleton = json['singleton'] != null ? EthereumAddress.fromHex(json['singleton']) : null,
        fallback = json['fallback'] != null ? EthereumAddress.fromHex(json['fallback']) : null,
        entrypoint = json['entrypoint'] != null ? EthereumAddress.fromHex(json['entrypoint']) : null;

  Map<String, dynamic> toJson() => {
    'version': version,
    'chainId': chainId,
    'name': name,
    'address': address.hexEip55,
    'signersIds': signersIds,
    'salt': salt,
    'recoveryId': recoveryId,
    'socialRecoveryModule': socialRecoveryModule?.hexEip55,
    'factory': factory?.hexEip55,
    'singleton': singleton?.hexEip55,
    'fallback': fallback?.hexEip55,
    'entrypoint': entrypoint?.hexEip55,
  };

  bool operator == (Object other) => other is Account && address.hex == other.address.hex && chainId == other.chainId;

  int get hashCode => Object.hash(address.hex, chainId);

}