// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"contract IGuardianStorage","name":"_guardianStorage","type":"address"},{"internalType":"uint256","name":"_recoveryPeriod","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"wallet","type":"address"},{"indexed":true,"internalType":"address","name":"guardian","type":"address"},{"indexed":false,"internalType":"uint256","name":"threshold","type":"uint256"}],"name":"GuardianAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"wallet","type":"address"},{"indexed":true,"internalType":"address","name":"guardian","type":"address"},{"indexed":false,"internalType":"uint256","name":"threshold","type":"uint256"}],"name":"GuardianRevoked","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"wallet","type":"address"},{"indexed":false,"internalType":"uint256","name":"nonce","type":"uint256"}],"name":"RecoveryCanceled","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"wallet","type":"address"},{"indexed":true,"internalType":"address[]","name":"newOwners","type":"address[]"},{"indexed":false,"internalType":"uint256","name":"newThreshold","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"nonce","type":"uint256"},{"indexed":false,"internalType":"uint64","name":"executeAfter","type":"uint64"},{"indexed":false,"internalType":"uint256","name":"guardiansApprovalCount","type":"uint256"}],"name":"RecoveryExecuted","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"wallet","type":"address"},{"indexed":true,"internalType":"address[]","name":"newOwners","type":"address[]"},{"indexed":false,"internalType":"uint256","name":"newThreshold","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"nonce","type":"uint256"}],"name":"RecoveryFinalized","type":"event"},{"inputs":[],"name":"NAME","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"VERSION","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address","name":"_guardian","type":"address"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"addGuardianWithThreshold","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"}],"name":"cancelRecovery","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"changeThreshold","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address[]","name":"_newOwners","type":"address[]"},{"internalType":"uint256","name":"_newThreshold","type":"uint256"},{"internalType":"bool","name":"_execute","type":"bool"}],"name":"confirmRecovery","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"domainSeparator","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address[]","name":"_newOwners","type":"address[]"},{"internalType":"uint256","name":"_newThreshold","type":"uint256"},{"internalType":"uint256","name":"_nonce","type":"uint256"}],"name":"encodeRecoveryData","outputs":[{"internalType":"bytes","name":"","type":"bytes"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address[]","name":"_newOwners","type":"address[]"},{"internalType":"uint256","name":"_newThreshold","type":"uint256"}],"name":"executeRecovery","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"}],"name":"finalizeRecovery","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getChainId","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"}],"name":"getGuardians","outputs":[{"internalType":"address[]","name":"_guardians","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address[]","name":"_newOwners","type":"address[]"},{"internalType":"uint256","name":"_newThreshold","type":"uint256"}],"name":"getRecoveryApprovals","outputs":[{"internalType":"uint256","name":"approvalCount","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address[]","name":"_newOwners","type":"address[]"},{"internalType":"uint256","name":"_newThreshold","type":"uint256"},{"internalType":"uint256","name":"_nonce","type":"uint256"}],"name":"getRecoveryHash","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"}],"name":"getRecoveryRequest","outputs":[{"components":[{"internalType":"uint256","name":"guardiansApprovalCount","type":"uint256"},{"internalType":"uint256","name":"newThreshold","type":"uint256"},{"internalType":"uint64","name":"executeAfter","type":"uint64"},{"internalType":"address[]","name":"newOwners","type":"address[]"}],"internalType":"struct SocialRecoveryModule.RecoveryRequest","name":"request","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"}],"name":"guardiansCount","outputs":[{"internalType":"uint256","name":"_count","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address","name":"_guardian","type":"address"},{"internalType":"address[]","name":"_newOwners","type":"address[]"},{"internalType":"uint256","name":"_newThreshold","type":"uint256"}],"name":"hasGuardianApproved","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address","name":"_guardian","type":"address"}],"name":"isGuardian","outputs":[{"internalType":"bool","name":"_isGuardian","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address[]","name":"_newOwners","type":"address[]"},{"internalType":"uint256","name":"_newThreshold","type":"uint256"},{"components":[{"internalType":"address","name":"signer","type":"address"},{"internalType":"bytes","name":"signature","type":"bytes"}],"internalType":"struct SocialRecoveryModule.SignatureData[]","name":"_signatures","type":"tuple[]"},{"internalType":"bool","name":"_execute","type":"bool"}],"name":"multiConfirmRecovery","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"}],"name":"nonce","outputs":[{"internalType":"uint256","name":"_nonce","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"},{"internalType":"address","name":"_prevGuardian","type":"address"},{"internalType":"address","name":"_guardian","type":"address"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"revokeGuardianWithThreshold","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_wallet","type":"address"}],"name":"threshold","outputs":[{"internalType":"uint256","name":"_threshold","type":"uint256"}],"stateMutability":"view","type":"function"}]',
  'SocialRecoveryModule',
);

class SocialRecoveryModule extends _i1.GeneratedContract {
  SocialRecoveryModule({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<String> NAME({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'a3f4df7e'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as String);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<String> VERSION({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, 'ffa1ad74'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as String);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addGuardianWithThreshold(
    _i1.EthereumAddress _wallet,
    _i1.EthereumAddress _guardian,
    BigInt _threshold, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '9b890b70'));
    final params = [
      _wallet,
      _guardian,
      _threshold,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> cancelRecovery(
    _i1.EthereumAddress _wallet, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'c90db447'));
    final params = [_wallet];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> changeThreshold(
    _i1.EthereumAddress _wallet,
    BigInt _threshold, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '57cfebbc'));
    final params = [
      _wallet,
      _threshold,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> confirmRecovery(
    _i1.EthereumAddress _wallet,
    List<_i1.EthereumAddress> _newOwners,
    BigInt _newThreshold,
    bool _execute, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '064e2d0e'));
    final params = [
      _wallet,
      _newOwners,
      _newThreshold,
      _execute,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> domainSeparator({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, 'f698da25'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> encodeRecoveryData(
    _i1.EthereumAddress _wallet,
    List<_i1.EthereumAddress> _newOwners,
    BigInt _newThreshold,
    BigInt _nonce, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '1e01c4f0'));
    final params = [
      _wallet,
      _newOwners,
      _newThreshold,
      _nonce,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> executeRecovery(
    _i1.EthereumAddress _wallet,
    List<_i1.EthereumAddress> _newOwners,
    BigInt _newThreshold, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, 'b1f85f69'));
    final params = [
      _wallet,
      _newOwners,
      _newThreshold,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> finalizeRecovery(
    _i1.EthereumAddress _wallet, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '315a7af3'));
    final params = [_wallet];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getChainId({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, '3408e470'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<_i1.EthereumAddress>> getGuardians(
    _i1.EthereumAddress _wallet, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, 'f18858ab'));
    final params = [_wallet];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<_i1.EthereumAddress>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getRecoveryApprovals(
    _i1.EthereumAddress _wallet,
    List<_i1.EthereumAddress> _newOwners,
    BigInt _newThreshold, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '6c6595ca'));
    final params = [
      _wallet,
      _newOwners,
      _newThreshold,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> getRecoveryHash(
    _i1.EthereumAddress _wallet,
    List<_i1.EthereumAddress> _newOwners,
    BigInt _newThreshold,
    BigInt _nonce, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '5f19df08'));
    final params = [
      _wallet,
      _newOwners,
      _newThreshold,
      _nonce,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRecoveryRequest(
    _i1.EthereumAddress _wallet, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '4f9a28b9'));
    final params = [_wallet];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> guardiansCount(
    _i1.EthereumAddress _wallet, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, 'c026e7ee'));
    final params = [_wallet];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> hasGuardianApproved(
    _i1.EthereumAddress _wallet,
    _i1.EthereumAddress _guardian,
    List<_i1.EthereumAddress> _newOwners,
    BigInt _newThreshold, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, '37d82c36'));
    final params = [
      _wallet,
      _guardian,
      _newOwners,
      _newThreshold,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isGuardian(
    _i1.EthereumAddress _wallet,
    _i1.EthereumAddress _guardian, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, 'd4ee9734'));
    final params = [
      _wallet,
      _guardian,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as bool);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> multiConfirmRecovery(
    _i1.EthereumAddress _wallet,
    List<_i1.EthereumAddress> _newOwners,
    BigInt _newThreshold,
    List<dynamic> _signatures,
    bool _execute, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, '0728e1e7'));
    final params = [
      _wallet,
      _newOwners,
      _newThreshold,
      _signatures,
      _execute,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> nonce(
    _i1.EthereumAddress _wallet, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, '70ae92d2'));
    final params = [_wallet];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> revokeGuardianWithThreshold(
    _i1.EthereumAddress _wallet,
    _i1.EthereumAddress _prevGuardian,
    _i1.EthereumAddress _guardian,
    BigInt _threshold, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, '1a0487a0'));
    final params = [
      _wallet,
      _prevGuardian,
      _guardian,
      _threshold,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> threshold(
    _i1.EthereumAddress _wallet, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[22];
    assert(checkSignature(function, 'c86ec2bf'));
    final params = [_wallet];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// Returns a live stream of all GuardianAdded events emitted by this contract.
  Stream<GuardianAdded> guardianAddedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('GuardianAdded');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return GuardianAdded(decoded);
    });
  }

  /// Returns a live stream of all GuardianRevoked events emitted by this contract.
  Stream<GuardianRevoked> guardianRevokedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('GuardianRevoked');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return GuardianRevoked(decoded);
    });
  }

  /// Returns a live stream of all RecoveryCanceled events emitted by this contract.
  Stream<RecoveryCanceled> recoveryCanceledEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('RecoveryCanceled');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return RecoveryCanceled(decoded);
    });
  }

  /// Returns a live stream of all RecoveryExecuted events emitted by this contract.
  Stream<RecoveryExecuted> recoveryExecutedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('RecoveryExecuted');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return RecoveryExecuted(decoded);
    });
  }

  /// Returns a live stream of all RecoveryFinalized events emitted by this contract.
  Stream<RecoveryFinalized> recoveryFinalizedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('RecoveryFinalized');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return RecoveryFinalized(decoded);
    });
  }
}

class GuardianAdded {
  GuardianAdded(List<dynamic> response)
      : wallet = (response[0] as _i1.EthereumAddress),
        guardian = (response[1] as _i1.EthereumAddress),
        threshold = (response[2] as BigInt);

  final _i1.EthereumAddress wallet;

  final _i1.EthereumAddress guardian;

  final BigInt threshold;
}

class GuardianRevoked {
  GuardianRevoked(List<dynamic> response)
      : wallet = (response[0] as _i1.EthereumAddress),
        guardian = (response[1] as _i1.EthereumAddress),
        threshold = (response[2] as BigInt);

  final _i1.EthereumAddress wallet;

  final _i1.EthereumAddress guardian;

  final BigInt threshold;
}

class RecoveryCanceled {
  RecoveryCanceled(List<dynamic> response)
      : wallet = (response[0] as _i1.EthereumAddress),
        nonce = (response[1] as BigInt);

  final _i1.EthereumAddress wallet;

  final BigInt nonce;
}

class RecoveryExecuted {
  RecoveryExecuted(List<dynamic> response)
      : wallet = (response[0] as _i1.EthereumAddress),
        newOwners = (response[1] as List<dynamic>).cast<_i1.EthereumAddress>(),
        newThreshold = (response[2] as BigInt),
        nonce = (response[3] as BigInt),
        executeAfter = (response[4] as BigInt),
        guardiansApprovalCount = (response[5] as BigInt);

  final _i1.EthereumAddress wallet;

  final List<_i1.EthereumAddress> newOwners;

  final BigInt newThreshold;

  final BigInt nonce;

  final BigInt executeAfter;

  final BigInt guardiansApprovalCount;
}

class RecoveryFinalized {
  RecoveryFinalized(List<dynamic> response)
      : wallet = (response[0] as _i1.EthereumAddress),
        newOwners = (response[1] as List<dynamic>).cast<_i1.EthereumAddress>(),
        newThreshold = (response[2] as BigInt),
        nonce = (response[3] as BigInt);

  final _i1.EthereumAddress wallet;

  final List<_i1.EthereumAddress> newOwners;

  final BigInt newThreshold;

  final BigInt nonce;
}
