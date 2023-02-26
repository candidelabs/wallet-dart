import 'dart:typed_data';

import 'package:wallet_dart/contracts/factories/EntryPoint.g.dart';
import 'package:web3dart/web3dart.dart';

class IEntrypoint {
  static EntryPoint interface({EthereumAddress? address, required Web3Client client}) =>
      EntryPoint(address: address ?? EthereumAddress(Uint8List(20)), client: client);
}
