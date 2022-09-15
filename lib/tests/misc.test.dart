import 'package:wallet_dart/wallet/wallet_helpers.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:test/test.dart';

void main(){
  test('-', () {
    var initCode = bytesToHex(WalletHelpers.getInitCode(EthereumAddress.fromHex("0xc26976587aed81a811c7d5e1084e8fd0da178ad7"), []), include0x: true);
    print(initCode);


    expect(1, 1);
  });
}