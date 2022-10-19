import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/factories/EntryPoint.g.dart';
import 'package:web3dart/web3dart.dart';

class CEntrypoint {
  static EthereumAddress address = EthereumAddress.fromHex("0x602aB3881Ff3Fa8dA60a8F44Cf633e91bA1FdB69");

  static EntryPoint interface = EntryPoint(address: address, client: Constants.web3client);

}
