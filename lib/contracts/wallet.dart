import 'dart:typed_data';

import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/factories/Wallet.g.dart' as w;
import 'package:wallet_dart/contracts/factories/WalletProxy.g.dart';
import 'package:web3dart/web3dart.dart';

class CWallet {
  static EthereumAddress address = EthereumAddress.fromHex("0x4f7459eFf03cD8C19B5a442d7c9b675A05f66fbf");

  static w.Wallet interface = w.Wallet(address: address, client: Constants.web3client);
  static WalletProxy proxyInterface = WalletProxy(address: EthereumAddress(Uint8List(20)), client: Constants.web3client);
  static w.Wallet customInterface(EthereumAddress address) => w.Wallet(address: address, client: Constants.web3client);
}