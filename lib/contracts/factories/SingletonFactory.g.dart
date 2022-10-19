// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"inputs":[{"internalType":"bytes","name":"_initCode","type":"bytes"},{"internalType":"bytes32","name":"_salt","type":"bytes32"}],"name":"deploy","outputs":[{"internalType":"address payable","name":"createdContract","type":"address"}],"stateMutability":"nonpayable","type":"function"}]',
    'SingletonFactory');

class SingletonFactory extends _i1.GeneratedContract {
  SingletonFactory(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> deploy(_i2.Uint8List _initCode, _i2.Uint8List _salt,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, '4af63f02'));
    final params = [_initCode, _salt];
    return write(credentials, transaction, function, params);
  }
}
