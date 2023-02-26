import 'dart:typed_data';

import 'package:wallet_dart/contracts/factories/MultiSendCallOnly.g.dart';
import 'package:web3dart/web3dart.dart';

class IMultiSendCallOnly {
  static MultiSendCallOnly interface({EthereumAddress? address, required Web3Client client}) =>
      MultiSendCallOnly(address: address ?? EthereumAddress(Uint8List(20)), client: client);

}