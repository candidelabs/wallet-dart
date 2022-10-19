import 'dart:typed_data';

import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/factories/EIP4337Manager.g.dart' as w;
import 'package:wallet_dart/contracts/factories/SafeProxy.g.dart';
import 'package:wallet_dart/contracts/factories/SocialRecoveryModule.g.dart';
import 'package:web3dart/web3dart.dart';

class CWallet {
  static EthereumAddress address = EthereumAddress.fromHex("0x4f7459eFf03cD8C19B5a442d7c9b675A05f66fbf"); // todo edit

  static w.EIP4337Manager interface = w.EIP4337Manager(address: address, client: Constants.web3client);
  static SafeProxy proxyInterface = SafeProxy(address: EthereumAddress(Uint8List(20)), client: Constants.web3client);
  static w.EIP4337Manager customInterface(EthereumAddress address, {Web3Client? client}) => w.EIP4337Manager(address: address, client: client ?? Constants.web3client);
  static SocialRecoveryModule recoveryInterface(EthereumAddress address, {Web3Client? client}) => SocialRecoveryModule(address: address, client: client ?? Constants.web3client);
}