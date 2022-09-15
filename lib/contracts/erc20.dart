import 'dart:typed_data';

import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/factories/ERC20.g.dart';
import 'package:web3dart/web3dart.dart';

class CERC20 {
  static ERC20 interface = ERC20(address: EthereumAddress(Uint8List(20)), client: Constants.web3client);
}