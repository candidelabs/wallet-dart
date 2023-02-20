import 'package:wallet_dart/contracts/factories/CandideWallet.g.dart';
import 'package:web3dart/web3dart.dart';

class IAccount {
  static EthereumAddress address = EthereumAddress.fromHex("0x3E5c63644E683549055b9Be8653de26E0B4CD36E");

  static CandideWallet interface({EthereumAddress? address, required Web3Client client}) =>
      CandideWallet(address: address ?? IAccount.address, client: client);
}