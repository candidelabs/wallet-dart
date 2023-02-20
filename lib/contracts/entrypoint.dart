import 'package:wallet_dart/contracts/factories/EntryPoint.g.dart';
import 'package:web3dart/web3dart.dart';

class IEntrypoint {
  static EthereumAddress address = EthereumAddress.fromHex("0xC1c7Ff116Acd223426a50De4d4Bb7117D0c387Ff");

  static EntryPoint interface({EthereumAddress? address, required Web3Client client}) =>
      EntryPoint(address: address ?? IEntrypoint.address, client: client);
}
