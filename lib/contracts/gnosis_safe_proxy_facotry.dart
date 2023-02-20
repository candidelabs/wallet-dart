import 'package:wallet_dart/contracts/factories/GnosisSafeProxyFactory.g.dart';
import 'package:web3dart/web3dart.dart';

class IGnosisSafeProxyFactory {
  static EthereumAddress address = EthereumAddress.fromHex("0xa6B71E26C5e0845f74c812102Ca7114b6a896AB2");

  static GnosisSafeProxyFactory interface({EthereumAddress? address, required Web3Client client}) =>
      GnosisSafeProxyFactory(address: address ?? IGnosisSafeProxyFactory.address, client: client);

}