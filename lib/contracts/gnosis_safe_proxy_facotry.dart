import 'dart:typed_data';

import 'package:wallet_dart/contracts/factories/GnosisSafeProxyFactory.g.dart';
import 'package:web3dart/web3dart.dart';

class IGnosisSafeProxyFactory {
  static GnosisSafeProxyFactory interface({EthereumAddress? address, required Web3Client client}) =>
      GnosisSafeProxyFactory(address: address ?? EthereumAddress(Uint8List(20)), client: client);

}