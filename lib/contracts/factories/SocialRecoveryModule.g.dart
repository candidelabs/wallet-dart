// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"masterCopy","type":"address"}],"name":"ChangedMasterCopy","type":"event"},{"inputs":[],"name":"NAME","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"VERSION","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"friend","type":"address"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"addFriendWithThreshold","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_masterCopy","type":"address"}],"name":"changeMasterCopy","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"prevOwner","type":"address"},{"internalType":"address","name":"oldOwner","type":"address"},{"internalType":"address","name":"newOwner","type":"address"},{"internalType":"bytes[]","name":"signatures","type":"bytes[]"}],"name":"confirmAndRecoverAccess","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"dataHash","type":"bytes32"}],"name":"confirmTransaction","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"friends","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes","name":"data","type":"bytes"}],"name":"getDataHash","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"pure","type":"function"},{"inputs":[],"name":"getFriends","outputs":[{"internalType":"address[]","name":"","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"},{"internalType":"address","name":"","type":"address"}],"name":"isConfirmed","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"dataHash","type":"bytes32"}],"name":"isConfirmedByRequiredFriends","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"name":"isExecuted","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"isFriend","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"manager","outputs":[{"internalType":"contract ModuleManager","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"prevOwner","type":"address"},{"internalType":"address","name":"oldOwner","type":"address"},{"internalType":"address","name":"newOwner","type":"address"}],"name":"recoverAccess","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"friendIndex","type":"uint256"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"removeFriend","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address[]","name":"_friends","type":"address[]"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"setup","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"threshold","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]',
    'SocialRecoveryModule');

class SocialRecoveryModule extends _i1.GeneratedContract {

  static _i2.Uint8List byteCode = hexToBytes("0x608060405234801561001057600080fd5b50611b2e806100206000396000f3fe608060405234801561001057600080fd5b50600436106101165760003560e01c80639ca89d0d116100a2578063ce14682811610071578063ce146828146102ab578063e52cb36a146102be578063eb4041f1146102e1578063ef77ff66146102f4578063ffa1ad741461030757600080fd5b80639ca89d0d1461020f578063a3f4df7e14610222578063ae68b05614610264578063b79ffaff1461027d57600080fd5b80634ab88427116100e95780634ab884271461019057806368125a1b146101a357806377231eaa146101d657806379716e43146101e95780637de7edef146101fc57600080fd5b806319609ddf1461011b5780631f8f72701461013057806342cde4e81461014e578063481c6a7514610165575b600080fd5b61012e6101293660046114b9565b61032d565b005b6101386106cd565b604051610145919061155e565b60405180910390f35b61015760025481565b604051908152602001610145565b600154610178906001600160a01b031681565b6040516001600160a01b039091168152602001610145565b61012e61019e3660046115f2565b61072f565b6101c66101b13660046116a5565b60046020526000908152604090205460ff1681565b6040519015158152602001610145565b61012e6101e43660046116c7565b6108f8565b61012e6101f736600461170a565b610afc565b61012e61020a3660046116a5565b610b80565b6101c661021d36600461170a565b610c9a565b61025760405180604001604052806016815260200175536f6369616c205265636f76657279204d6f64756c6560501b81525081565b6040516101459190611770565b610157610272366004611783565b805160209091012090565b6101c661028b366004611818565b600660209081526000928352604080842090915290825290205460ff1681565b6101786102b936600461170a565b610d3a565b6101c66102cc36600461170a565b60056020526000908152604090205460ff1681565b61012e6102ef366004611844565b610d64565b61012e61030236600461186e565b610e9c565b61025760405180604001604052806007815260200166302e312e305f6d60c81b81525081565b3360009081526004602052604090205460ff166103655760405162461bcd60e51b815260040161035c90611890565b60405180910390fd5b6040516001600160a01b03808716602483015280861660448301528416606482015260009060840160408051601f198184030181529190526020810180516001600160e01b031663e318b52b60e01b17815281519020909150610415816040517f19457468657265756d205369676e6564204d6573736167653a0a3332000000006020820152603c8101829052600090605c01604051602081830303815290604052805190602001209050919050565b60008181526005602052604090205490915060ff16156104475760405162461bcd60e51b815260040161035c906118d5565b600354831180159061045b57506002548310155b6104a75760405162461bcd60e51b815260206004820152601a60248201527f57726f6e67206e756d626572206f66207369676e617475726573000000000000604482015260640161035c565b60005b838110156105e65760006105188686848181106104c9576104c961190c565b90506020028101906104db9190611922565b8080601f016020809104026020016040519081016040528093929190818152602001838380828437600092019190915250879392505061103e9050565b6001600160a01b03811660009081526004602052604090205490915060ff168015610566575060008381526006602090815260408083206001600160a01b038516845290915290205460ff16155b6105a75760405162461bcd60e51b8152602060048201526012602482015271496e76616c696465205369676e617475726560701b604482015260640161035c565b60008381526006602090815260408083206001600160a01b03909416835292905220805460ff19166001179055806105de8161197f565b9150506104aa565b50600081815260056020526040808220805460ff1916600190811790915554905163468721a760e01b81526001600160a01b039091169163468721a791610635918491879082906004016119b0565b6020604051808303816000875af1158015610654573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906106789190611a06565b6106c45760405162461bcd60e51b815260206004820152601a60248201527f436f756c64206e6f742065786563757465207265636f76657279000000000000604482015260640161035c565b50505050505050565b6060600380548060200260200160405190810160405280929190818152602001828054801561072557602002820191906000526020600020905b81546001600160a01b03168152600190910190602001808311610707575b5050505050905090565b81518111156107505760405162461bcd60e51b815260040161035c90611a28565b60018110156107a15760405162461bcd60e51b815260206004820152601b60248201527f4174206c65617374203120667269656e64732072657175697265640000000000604482015260640161035c565b6107a9611062565b60005b82518110156108dd5760008382815181106107c9576107c961190c565b6020026020010151905060006001600160a01b0316816001600160a01b031614156108365760405162461bcd60e51b815260206004820152601f60248201527f496e76616c696420667269656e6420616464726573732070726f766964656400604482015260640161035c565b6001600160a01b03811660009081526004602052604090205460ff16156108a95760405162461bcd60e51b815260206004820152602160248201527f4475706c696361746520667269656e6420616464726573732070726f766964656044820152601960fa1b606482015260840161035c565b6001600160a01b03166000908152600460205260409020805460ff19166001179055806108d58161197f565b9150506107ac565b5081516108f1906003906020850190611423565b5060025550565b3360009081526004602052604090205460ff166109275760405162461bcd60e51b815260040161035c90611890565b6040516001600160a01b03808516602483015280841660448301528216606482015260009060840160408051601f198184030181529190526020810180516001600160e01b031663e318b52b60e01b1781528151902090915060009060008181526005602052604090205490915060ff16156109b55760405162461bcd60e51b815260040161035c906118d5565b6109be81610c9a565b610a185760405162461bcd60e51b815260206004820152602560248201527f5265636f7665727920686173206e6f7420656e6f75676820636f6e6669726d6160448201526474696f6e7360d81b606482015260840161035c565b600081815260056020526040808220805460ff1916600190811790915554905163468721a760e01b81526001600160a01b039091169163468721a791610a66918491879082906004016119b0565b6020604051808303816000875af1158015610a85573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610aa99190611a06565b610af55760405162461bcd60e51b815260206004820152601a60248201527f436f756c64206e6f742065786563757465207265636f76657279000000000000604482015260640161035c565b5050505050565b3360009081526004602052604090205460ff16610b2b5760405162461bcd60e51b815260040161035c90611890565b60008181526005602052604090205460ff1615610b5a5760405162461bcd60e51b815260040161035c906118d5565b60009081526006602090815260408083203384529091529020805460ff19166001179055565b333014610be45760405162461bcd60e51b815260206004820152602c60248201527f4d6574686f642063616e206f6e6c792062652063616c6c65642066726f6d207460448201526b1a1a5cc818dbdb9d1c9858dd60a21b606482015260840161035c565b6001600160a01b038116610c465760405162461bcd60e51b8152602060048201526024808201527f496e76616c6964206d617374657220636f707920616464726573732070726f766044820152631a59195960e21b606482015260840161035c565b600080546001600160a01b0319166001600160a01b0383169081179091556040519081527f75e41bc35ff1bf14d81d1d2f649c0084a0f974f9289c803ec9898eeec4c8d0b89060200160405180910390a150565b60008060005b600354811015610d305760008481526006602052604081206003805491929184908110610ccf57610ccf61190c565b60009182526020808320909101546001600160a01b0316835282019290925260400190205460ff1615610d0a5781610d068161197f565b9250505b600254821415610d1e575060019392505050565b80610d288161197f565b915050610ca0565b5060009392505050565b60038181548110610d4a57600080fd5b6000918252602090912001546001600160a01b0316905081565b6001546001600160a01b03163314610d8e5760405162461bcd60e51b815260040161035c90611a6d565b6001600160a01b03821615801590610dbf57506001600160a01b03821660009081526004602052604090205460ff16155b610e045760405162461bcd60e51b8152602060048201526016602482015275125b9d985b1a591948199c9a595b99081d1bc818591960521b604482015260640161035c565b6003805460018082019092557fc2575a0e9e593c00f959f8c92f12db2869c3395a3b0502d05e2516446f71f85b0180546001600160a01b0319166001600160a01b0385169081179091556000908152600460205260409020805460ff191690911790556002548114610e9857600354811115610e925760405162461bcd60e51b815260040161035c90611a28565b60028190555b5050565b6001546001600160a01b03163314610ec65760405162461bcd60e51b815260040161035c90611a6d565b6003548190610ed790600190611ab3565b1015610ef55760405162461bcd60e51b815260040161035c90611a28565b6003548210610f3e5760405162461bcd60e51b8152602060048201526015602482015274092dcecc2d8d2c8ca40cce4d2cadcc840d2dcc8caf605b1b604482015260640161035c565b60006004600060038581548110610f5757610f5761190c565b6000918252602080832091909101546001600160a01b031683528201929092526040019020805460ff191691151591909117905560038054610f9b90600190611ab3565b81548110610fab57610fab61190c565b600091825260209091200154600380546001600160a01b039092169184908110610fd757610fd761190c565b9060005260206000200160006101000a8154816001600160a01b0302191690836001600160a01b03160217905550600380548061101657611016611aca565b600082815260209020810160001990810180546001600160a01b031916905501905560025550565b600080600061104d85856110cf565b9150915061105a8161113f565b509392505050565b6001546001600160a01b0316156110bb5760405162461bcd60e51b815260206004820152601c60248201527f4d616e616765722068617320616c7265616479206265656e2073657400000000604482015260640161035c565b600180546001600160a01b03191633179055565b6000808251604114156111065760208301516040840151606085015160001a6110fa878285856112fd565b94509450505050611138565b82516040141561113057602083015160408401516111258683836113ea565b935093505050611138565b506000905060025b9250929050565b60008160048111156111535761115361199a565b141561115c5750565b60018160048111156111705761117061199a565b14156111be5760405162461bcd60e51b815260206004820152601860248201527f45434453413a20696e76616c6964207369676e61747572650000000000000000604482015260640161035c565b60028160048111156111d2576111d261199a565b14156112205760405162461bcd60e51b815260206004820152601f60248201527f45434453413a20696e76616c6964207369676e6174757265206c656e67746800604482015260640161035c565b60038160048111156112345761123461199a565b141561128d5760405162461bcd60e51b815260206004820152602260248201527f45434453413a20696e76616c6964207369676e6174757265202773272076616c604482015261756560f01b606482015260840161035c565b60048160048111156112a1576112a161199a565b14156112fa5760405162461bcd60e51b815260206004820152602260248201527f45434453413a20696e76616c6964207369676e6174757265202776272076616c604482015261756560f01b606482015260840161035c565b50565b6000807f7fffffffffffffffffffffffffffffff5d576e7357a4501ddfe92f46681b20a083111561133457506000905060036113e1565b8460ff16601b1415801561134c57508460ff16601c14155b1561135d57506000905060046113e1565b6040805160008082526020820180845289905260ff881692820192909252606081018690526080810185905260019060a0016020604051602081039080840390855afa1580156113b1573d6000803e3d6000fd5b5050604051601f1901519150506001600160a01b0381166113da576000600192509250506113e1565b9150600090505b94509492505050565b6000806001600160ff1b0383168161140760ff86901c601b611ae0565b9050611415878288856112fd565b935093505050935093915050565b828054828255906000526020600020908101928215611478579160200282015b8281111561147857825182546001600160a01b0319166001600160a01b03909116178255602090920191600190910190611443565b50611484929150611488565b5090565b5b808211156114845760008155600101611489565b80356001600160a01b03811681146114b457600080fd5b919050565b6000806000806000608086880312156114d157600080fd5b6114da8661149d565b94506114e86020870161149d565b93506114f66040870161149d565b9250606086013567ffffffffffffffff8082111561151357600080fd5b818801915088601f83011261152757600080fd5b81358181111561153657600080fd5b8960208260051b850101111561154b57600080fd5b9699959850939650602001949392505050565b6020808252825182820181905260009190848201906040850190845b8181101561159f5783516001600160a01b03168352928401929184019160010161157a565b50909695505050505050565b634e487b7160e01b600052604160045260246000fd5b604051601f8201601f1916810167ffffffffffffffff811182821017156115ea576115ea6115ab565b604052919050565b6000806040838503121561160557600080fd5b823567ffffffffffffffff8082111561161d57600080fd5b818501915085601f83011261163157600080fd5b8135602082821115611645576116456115ab565b8160051b92506116568184016115c1565b828152928401810192818101908985111561167057600080fd5b948201945b84861015611695576116868661149d565b82529482019490820190611675565b9997909101359750505050505050565b6000602082840312156116b757600080fd5b6116c08261149d565b9392505050565b6000806000606084860312156116dc57600080fd5b6116e58461149d565b92506116f36020850161149d565b91506117016040850161149d565b90509250925092565b60006020828403121561171c57600080fd5b5035919050565b6000815180845260005b818110156117495760208185018101518683018201520161172d565b8181111561175b576000602083870101525b50601f01601f19169290920160200192915050565b6020815260006116c06020830184611723565b6000602080838503121561179657600080fd5b823567ffffffffffffffff808211156117ae57600080fd5b818501915085601f8301126117c257600080fd5b8135818111156117d4576117d46115ab565b6117e6601f8201601f191685016115c1565b915080825286848285010111156117fc57600080fd5b8084840185840137600090820190930192909252509392505050565b6000806040838503121561182b57600080fd5b8235915061183b6020840161149d565b90509250929050565b6000806040838503121561185757600080fd5b6118608361149d565b946020939093013593505050565b6000806040838503121561188157600080fd5b50508035926020909101359150565b60208082526025908201527f4d6574686f642063616e206f6e6c792062652063616c6c6564206279206120666040820152641c9a595b9960da1b606082015260800190565b60208082526019908201527f5265636f7665727920616c726561647920657865637574656400000000000000604082015260600190565b634e487b7160e01b600052603260045260246000fd5b6000808335601e1984360301811261193957600080fd5b83018035915067ffffffffffffffff82111561195457600080fd5b60200191503681900382131561113857600080fd5b634e487b7160e01b600052601160045260246000fd5b600060001982141561199357611993611969565b5060010190565b634e487b7160e01b600052602160045260246000fd5b60018060a01b03851681528360208201526080604082015260006119d76080830185611723565b9050600283106119f757634e487b7160e01b600052602160045260246000fd5b82606083015295945050505050565b600060208284031215611a1857600080fd5b815180151581146116c057600080fd5b60208082526025908201527f5468726573686f6c642063616e6e6f742065786365656420667269656e64732060408201526418dbdd5b9d60da1b606082015260800190565b60208082526026908201527f4d6574686f642063616e206f6e6c792062652063616c6c65642066726f6d206d60408201526530b730b3b2b960d11b606082015260800190565b600082821015611ac557611ac5611969565b500390565b634e487b7160e01b600052603160045260246000fd5b60008219821115611af357611af3611969565b50019056fea2646970667358221220ae241364c73a1a5a17b53083f9ed79dbffc12f6f8a4b21c7a61bc93a9d478eb964736f6c634300080c0033");

  SocialRecoveryModule(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<String> NAME({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, 'a3f4df7e'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as String);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<String> VERSION({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'ffa1ad74'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as String);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addFriendWithThreshold(
      _i1.EthereumAddress friend, BigInt _threshold,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, 'eb4041f1'));
    final params = [friend, _threshold];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> changeMasterCopy(_i1.EthereumAddress _masterCopy,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '7de7edef'));
    final params = [_masterCopy];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> confirmAndRecoverAccess(
      _i1.EthereumAddress prevOwner,
      _i1.EthereumAddress oldOwner,
      _i1.EthereumAddress newOwner,
      List<_i2.Uint8List> signatures,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '19609ddf'));
    final params = [prevOwner, oldOwner, newOwner, signatures];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> confirmTransaction(_i2.Uint8List dataHash,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '79716e43'));
    final params = [dataHash];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> friends(BigInt $param8,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, 'ce146828'));
    final params = [$param8];
    final response = await read(function, params, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> getDataHash(_i2.Uint8List data,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, 'ae68b056'));
    final params = [data];
    final response = await read(function, params, atBlock);
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<_i1.EthereumAddress>> getFriends({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '1f8f7270'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<_i1.EthereumAddress>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isConfirmed(_i2.Uint8List $param10, _i1.EthereumAddress $param11,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, 'b79ffaff'));
    final params = [$param10, $param11];
    final response = await read(function, params, atBlock);
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isConfirmedByRequiredFriends(_i2.Uint8List dataHash,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '9ca89d0d'));
    final params = [dataHash];
    final response = await read(function, params, atBlock);
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isExecuted(_i2.Uint8List $param13,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, 'e52cb36a'));
    final params = [$param13];
    final response = await read(function, params, atBlock);
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isFriend(_i1.EthereumAddress $param14,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, '68125a1b'));
    final params = [$param14];
    final response = await read(function, params, atBlock);
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> manager({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '481c6a75'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> recoverAccess(_i1.EthereumAddress prevOwner,
      _i1.EthereumAddress oldOwner, _i1.EthereumAddress newOwner,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '77231eaa'));
    final params = [prevOwner, oldOwner, newOwner];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> removeFriend(BigInt friendIndex, BigInt _threshold,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, 'ef77ff66'));
    final params = [friendIndex, _threshold];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setup(List<_i1.EthereumAddress> _friends, BigInt _threshold,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '4ab88427'));
    final params = [_friends, _threshold];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> threshold({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, '42cde4e8'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// Returns a live stream of all ChangedMasterCopy events emitted by this contract.
  Stream<ChangedMasterCopy> changedMasterCopyEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('ChangedMasterCopy');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return ChangedMasterCopy(decoded);
    });
  }
}

class ChangedMasterCopy {
  ChangedMasterCopy(List<dynamic> response)
      : masterCopy = (response[0] as _i1.EthereumAddress);

  final _i1.EthereumAddress masterCopy;
}
