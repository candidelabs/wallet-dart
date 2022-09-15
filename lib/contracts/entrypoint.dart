import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/factories/EntryPoint.g.dart';
import 'package:web3dart/web3dart.dart';

class CEntrypoint {
  static EthereumAddress address = EthereumAddress.fromHex("0x6D59643f668d67D4E80a14CB65be02264D3c5aDB");

  static EntryPoint interface = EntryPoint(address: address, client: Constants.web3client);

}
