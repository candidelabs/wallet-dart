import 'dart:typed_data';

import 'package:wallet_dart/contracts/factories/CandideWallet.g.dart';
import 'package:web3dart/web3dart.dart';

class IAccount {
  static CandideWallet interface({EthereumAddress? address, required Web3Client client}) =>
      CandideWallet(address: address ?? EthereumAddress(Uint8List(20)), client: client);
}