import 'dart:typed_data';

import 'package:wallet_dart/contracts/factories/ERC20.g.dart';
import 'package:web3dart/web3dart.dart';

class IERC20 {
  static ERC20 interface({EthereumAddress? address, required Web3Client client}) =>
      ERC20(address: address ?? EthereumAddress(Uint8List(20)), client: client);
}