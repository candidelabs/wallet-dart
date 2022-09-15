import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Constants {
  static Web3Client web3client = Web3Client("https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161", Client());
  static BigInt defaultUnlockDelaySeconds = BigInt.from(172800);
  static EthereumAddress singletonFactoryAddress = EthereumAddress.fromHex("0xce0042B868300000d44A59004Da54A005ffdcf9f");

}