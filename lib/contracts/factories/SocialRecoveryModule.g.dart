// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"masterCopy","type":"address"}],"name":"ChangedMasterCopy","type":"event"},{"inputs":[],"name":"NAME","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"VERSION","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"friend","type":"address"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"addFriendWithThreshold","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_masterCopy","type":"address"}],"name":"changeMasterCopy","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"prevOwner","type":"address"},{"internalType":"address","name":"oldOwner","type":"address"},{"internalType":"address","name":"newOwner","type":"address"},{"internalType":"bytes[]","name":"signatures","type":"bytes[]"}],"name":"confirmAndRecoverAccess","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"dataHash","type":"bytes32"}],"name":"confirmTransaction","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"friends","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"friendsCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes","name":"data","type":"bytes"}],"name":"getDataHash","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"pure","type":"function"},{"inputs":[],"name":"getFriends","outputs":[{"internalType":"address[]","name":"","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"},{"internalType":"address","name":"","type":"address"}],"name":"isConfirmed","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"dataHash","type":"bytes32"}],"name":"isConfirmedByRequiredFriends","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"name":"isExecuted","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"isFriend","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"manager","outputs":[{"internalType":"contract ModuleManager","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"prevOwner","type":"address"},{"internalType":"address","name":"oldOwner","type":"address"},{"internalType":"address","name":"newOwner","type":"address"}],"name":"recoverAccess","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"friendIndex","type":"uint256"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"removeFriend","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address[]","name":"_friends","type":"address[]"},{"internalType":"uint256","name":"_threshold","type":"uint256"}],"name":"setup","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"threshold","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]',
    'SocialRecoveryModule');

class SocialRecoveryModule extends _i1.GeneratedContract {

  static _i2.Uint8List byteCode = hexToBytes("0x608060405234801561001057600080fd5b50611c11806100206000396000f3fe608060405234801561001057600080fd5b50600436106101215760003560e01c80639ca89d0d116100ad578063e52cb36a11610071578063e52cb36a146102c9578063e555134f146102ec578063eb4041f1146102f5578063ef77ff6614610308578063ffa1ad741461031b57600080fd5b80639ca89d0d1461021a578063a3f4df7e1461022d578063ae68b0561461026f578063b79ffaff14610288578063ce146828146102b657600080fd5b80634ab88427116100f45780634ab884271461019b57806368125a1b146101ae57806377231eaa146101e157806379716e43146101f45780637de7edef1461020757600080fd5b806319609ddf146101265780631f8f72701461013b57806342cde4e814610159578063481c6a7514610170575b600080fd5b610139610134366004611585565b610341565b005b610143610693565b604051610150919061162a565b60405180910390f35b61016260025481565b604051908152602001610150565b600154610183906001600160a01b031681565b6040516001600160a01b039091168152602001610150565b6101396101a93660046116be565b61075e565b6101d16101bc366004611771565b60056020526000908152604090205460ff1681565b6040519015158152602001610150565b6101396101ef366004611793565b610942565b6101396102023660046117d6565b610b4c565b610139610215366004611771565b610bd0565b6101d16102283660046117d6565b610cea565b61026260405180604001604052806016815260200175536f6369616c205265636f76657279204d6f64756c6560501b81525081565b604051610150919061183c565b61016261027d36600461184f565b805160209091012090565b6101d16102963660046118e4565b600760209081526000928352604080842090915290825290205460ff1681565b6101836102c43660046117d6565b610d8a565b6101d16102d73660046117d6565b60066020526000908152604090205460ff1681565b61016260045481565b610139610303366004611910565b610db4565b61013961031636600461193a565b610f01565b61026260405180604001604052806007815260200166302e312e305f6d60c81b81525081565b3360009081526005602052604090205460ff166103795760405162461bcd60e51b81526004016103709061195c565b60405180910390fd5b6040516001600160a01b03808716602483015280861660448301528416606482015260009060840160408051601f198184030181529190526020810180516001600160e01b031663e318b52b60e01b178152815190209091506103db816110b7565b60008181526006602052604090205490915060ff161561040d5760405162461bcd60e51b8152600401610370906119a1565b600354831180159061042157506002548310155b61046d5760405162461bcd60e51b815260206004820152601a60248201527f57726f6e67206e756d626572206f66207369676e6174757265730000000000006044820152606401610370565b60005b838110156105ac5760006104de86868481811061048f5761048f6119d8565b90506020028101906104a191906119ee565b8080601f016020809104026020016040519081016040528093929190818152602001838380828437600092019190915250879392505061110a9050565b6001600160a01b03811660009081526005602052604090205490915060ff16801561052c575060008381526007602090815260408083206001600160a01b038516845290915290205460ff16155b61056d5760405162461bcd60e51b8152602060048201526012602482015271496e76616c696465205369676e617475726560701b6044820152606401610370565b60008381526007602090815260408083206001600160a01b03909416835292905220805460ff19166001179055806105a481611a4b565b915050610470565b50600081815260066020526040808220805460ff1916600190811790915554905163468721a760e01b81526001600160a01b039091169163468721a7916105fb91849187908290600401611a7c565b6020604051808303816000875af115801561061a573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061063e9190611ad2565b61068a5760405162461bcd60e51b815260206004820152601a60248201527f436f756c64206e6f742065786563757465207265636f766572790000000000006044820152606401610370565b50505050505050565b6060600060045467ffffffffffffffff8111156106b2576106b2611677565b6040519080825280602002602001820160405280156106db578160200160208202803683370190505b50905060005b60045481101561075857600381815481106106fe576106fe6119d8565b9060005260206000200160009054906101000a90046001600160a01b031682828151811061072e5761072e6119d8565b6001600160a01b03909216602092830291909101909101528061075081611a4b565b9150506106e1565b50919050565b815181111561077f5760405162461bcd60e51b815260040161037090611af4565b60018110156107d05760405162461bcd60e51b815260206004820152601b60248201527f4174206c65617374203120667269656e647320726571756972656400000000006044820152606401610370565b6107d861112e565b600060048190555b82518110156109275760008382815181106107fd576107fd6119d8565b6020026020010151905060006001600160a01b0316816001600160a01b0316141561086a5760405162461bcd60e51b815260206004820152601f60248201527f496e76616c696420667269656e6420616464726573732070726f7669646564006044820152606401610370565b6001600160a01b03811660009081526005602052604090205460ff16156108dd5760405162461bcd60e51b815260206004820152602160248201527f4475706c696361746520667269656e6420616464726573732070726f766964656044820152601960fa1b6064820152608401610370565b6001600160a01b0381166000908152600560205260408120805460ff19166001179055600480549161090e83611a4b565b919050555050808061091f90611a4b565b9150506107e0565b50815161093b9060039060208501906114ef565b5060025550565b3360009081526005602052604090205460ff166109715760405162461bcd60e51b81526004016103709061195c565b6040516001600160a01b03808516602483015280841660448301528216606482015260009060840160408051601f198184030181529190526020810180516001600160e01b031663e318b52b60e01b178152815190209091506109d3816110b7565b60008181526006602052604090205490915060ff1615610a055760405162461bcd60e51b8152600401610370906119a1565b610a0e81610cea565b610a685760405162461bcd60e51b815260206004820152602560248201527f5265636f7665727920686173206e6f7420656e6f75676820636f6e6669726d6160448201526474696f6e7360d81b6064820152608401610370565b600081815260066020526040808220805460ff1916600190811790915554905163468721a760e01b81526001600160a01b039091169163468721a791610ab691849187908290600401611a7c565b6020604051808303816000875af1158015610ad5573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610af99190611ad2565b610b455760405162461bcd60e51b815260206004820152601a60248201527f436f756c64206e6f742065786563757465207265636f766572790000000000006044820152606401610370565b5050505050565b3360009081526005602052604090205460ff16610b7b5760405162461bcd60e51b81526004016103709061195c565b60008181526006602052604090205460ff1615610baa5760405162461bcd60e51b8152600401610370906119a1565b60009081526007602090815260408083203384529091529020805460ff19166001179055565b333014610c345760405162461bcd60e51b815260206004820152602c60248201527f4d6574686f642063616e206f6e6c792062652063616c6c65642066726f6d207460448201526b1a1a5cc818dbdb9d1c9858dd60a21b6064820152608401610370565b6001600160a01b038116610c965760405162461bcd60e51b8152602060048201526024808201527f496e76616c6964206d617374657220636f707920616464726573732070726f766044820152631a59195960e21b6064820152608401610370565b600080546001600160a01b0319166001600160a01b0383169081179091556040519081527f75e41bc35ff1bf14d81d1d2f649c0084a0f974f9289c803ec9898eeec4c8d0b89060200160405180910390a150565b60008060005b600354811015610d805760008481526007602052604081206003805491929184908110610d1f57610d1f6119d8565b60009182526020808320909101546001600160a01b0316835282019290925260400190205460ff1615610d5a5781610d5681611a4b565b9250505b600254821415610d6e575060019392505050565b80610d7881611a4b565b915050610cf0565b5060009392505050565b60038181548110610d9a57600080fd5b6000918252602090912001546001600160a01b0316905081565b6001546001600160a01b03163314610dde5760405162461bcd60e51b815260040161037090611b39565b6001600160a01b03821615801590610e0f57506001600160a01b03821660009081526005602052604090205460ff16155b610e545760405162461bcd60e51b8152602060048201526016602482015275125b9d985b1a591948199c9a595b99081d1bc818591960521b6044820152606401610370565b60048054906000610e6483611a4b565b90915550506003805460018082019092557fc2575a0e9e593c00f959f8c92f12db2869c3395a3b0502d05e2516446f71f85b0180546001600160a01b0319166001600160a01b0385169081179091556000908152600560205260409020805460ff191690911790556002548114610efd57600354811115610ef75760405162461bcd60e51b815260040161037090611af4565b60028190555b5050565b6001546001600160a01b03163314610f2b5760405162461bcd60e51b815260040161037090611b39565b6003548190610f3c90600190611b7f565b1015610f5a5760405162461bcd60e51b815260040161037090611af4565b6003548210610fa35760405162461bcd60e51b8152602060048201526015602482015274092dcecc2d8d2c8ca40cce4d2cadcc840d2dcc8caf605b1b6044820152606401610370565b60006005600060038581548110610fbc57610fbc6119d8565b6000918252602080832091909101546001600160a01b031683528201929092526040018120805460ff1916921515929092179091556004805491610fff83611b96565b90915550506003805461101490600190611b7f565b81548110611024576110246119d8565b600091825260209091200154600380546001600160a01b039092169184908110611050576110506119d8565b9060005260206000200160006101000a8154816001600160a01b0302191690836001600160a01b03160217905550600380548061108f5761108f611bad565b600082815260209020810160001990810180546001600160a01b031916905501905560025550565b6040517f19457468657265756d205369676e6564204d6573736167653a0a3332000000006020820152603c8101829052600090605c01604051602081830303815290604052805190602001209050919050565b6000806000611119858561119b565b915091506111268161120b565b509392505050565b6001546001600160a01b0316156111875760405162461bcd60e51b815260206004820152601c60248201527f4d616e616765722068617320616c7265616479206265656e20736574000000006044820152606401610370565b600180546001600160a01b03191633179055565b6000808251604114156111d25760208301516040840151606085015160001a6111c6878285856113c9565b94509450505050611204565b8251604014156111fc57602083015160408401516111f18683836114b6565b935093505050611204565b506000905060025b9250929050565b600081600481111561121f5761121f611a66565b14156112285750565b600181600481111561123c5761123c611a66565b141561128a5760405162461bcd60e51b815260206004820152601860248201527f45434453413a20696e76616c6964207369676e617475726500000000000000006044820152606401610370565b600281600481111561129e5761129e611a66565b14156112ec5760405162461bcd60e51b815260206004820152601f60248201527f45434453413a20696e76616c6964207369676e6174757265206c656e677468006044820152606401610370565b600381600481111561130057611300611a66565b14156113595760405162461bcd60e51b815260206004820152602260248201527f45434453413a20696e76616c6964207369676e6174757265202773272076616c604482015261756560f01b6064820152608401610370565b600481600481111561136d5761136d611a66565b14156113c65760405162461bcd60e51b815260206004820152602260248201527f45434453413a20696e76616c6964207369676e6174757265202776272076616c604482015261756560f01b6064820152608401610370565b50565b6000807f7fffffffffffffffffffffffffffffff5d576e7357a4501ddfe92f46681b20a083111561140057506000905060036114ad565b8460ff16601b1415801561141857508460ff16601c14155b1561142957506000905060046114ad565b6040805160008082526020820180845289905260ff881692820192909252606081018690526080810185905260019060a0016020604051602081039080840390855afa15801561147d573d6000803e3d6000fd5b5050604051601f1901519150506001600160a01b0381166114a6576000600192509250506114ad565b9150600090505b94509492505050565b6000806001600160ff1b038316816114d360ff86901c601b611bc3565b90506114e1878288856113c9565b935093505050935093915050565b828054828255906000526020600020908101928215611544579160200282015b8281111561154457825182546001600160a01b0319166001600160a01b0390911617825560209092019160019091019061150f565b50611550929150611554565b5090565b5b808211156115505760008155600101611555565b80356001600160a01b038116811461158057600080fd5b919050565b60008060008060006080868803121561159d57600080fd5b6115a686611569565b94506115b460208701611569565b93506115c260408701611569565b9250606086013567ffffffffffffffff808211156115df57600080fd5b818801915088601f8301126115f357600080fd5b81358181111561160257600080fd5b8960208260051b850101111561161757600080fd5b9699959850939650602001949392505050565b6020808252825182820181905260009190848201906040850190845b8181101561166b5783516001600160a01b031683529284019291840191600101611646565b50909695505050505050565b634e487b7160e01b600052604160045260246000fd5b604051601f8201601f1916810167ffffffffffffffff811182821017156116b6576116b6611677565b604052919050565b600080604083850312156116d157600080fd5b823567ffffffffffffffff808211156116e957600080fd5b818501915085601f8301126116fd57600080fd5b813560208282111561171157611711611677565b8160051b925061172281840161168d565b828152928401810192818101908985111561173c57600080fd5b948201945b848610156117615761175286611569565b82529482019490820190611741565b9997909101359750505050505050565b60006020828403121561178357600080fd5b61178c82611569565b9392505050565b6000806000606084860312156117a857600080fd5b6117b184611569565b92506117bf60208501611569565b91506117cd60408501611569565b90509250925092565b6000602082840312156117e857600080fd5b5035919050565b6000815180845260005b81811015611815576020818501810151868301820152016117f9565b81811115611827576000602083870101525b50601f01601f19169290920160200192915050565b60208152600061178c60208301846117ef565b6000602080838503121561186257600080fd5b823567ffffffffffffffff8082111561187a57600080fd5b818501915085601f83011261188e57600080fd5b8135818111156118a0576118a0611677565b6118b2601f8201601f1916850161168d565b915080825286848285010111156118c857600080fd5b8084840185840137600090820190930192909252509392505050565b600080604083850312156118f757600080fd5b8235915061190760208401611569565b90509250929050565b6000806040838503121561192357600080fd5b61192c83611569565b946020939093013593505050565b6000806040838503121561194d57600080fd5b50508035926020909101359150565b60208082526025908201527f4d6574686f642063616e206f6e6c792062652063616c6c6564206279206120666040820152641c9a595b9960da1b606082015260800190565b60208082526019908201527f5265636f7665727920616c726561647920657865637574656400000000000000604082015260600190565b634e487b7160e01b600052603260045260246000fd5b6000808335601e19843603018112611a0557600080fd5b83018035915067ffffffffffffffff821115611a2057600080fd5b60200191503681900382131561120457600080fd5b634e487b7160e01b600052601160045260246000fd5b6000600019821415611a5f57611a5f611a35565b5060010190565b634e487b7160e01b600052602160045260246000fd5b60018060a01b0385168152836020820152608060408201526000611aa360808301856117ef565b905060028310611ac357634e487b7160e01b600052602160045260246000fd5b82606083015295945050505050565b600060208284031215611ae457600080fd5b8151801515811461178c57600080fd5b60208082526025908201527f5468726573686f6c642063616e6e6f742065786365656420667269656e64732060408201526418dbdd5b9d60da1b606082015260800190565b60208082526026908201527f4d6574686f642063616e206f6e6c792062652063616c6c65642066726f6d206d60408201526530b730b3b2b960d11b606082015260800190565b600082821015611b9157611b91611a35565b500390565b600081611ba557611ba5611a35565b506000190190565b634e487b7160e01b600052603160045260246000fd5b60008219821115611bd657611bd6611a35565b50019056fea2646970667358221220b0cb6eb9f854fac39ae60b3b37cc9dd8431a19b179e5b0eda39573a636f91f4564736f6c634300080c0033");

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
  Future<BigInt> friendsCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, 'e555134f'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i2.Uint8List> getDataHash(_i2.Uint8List data,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, 'ae68b056'));
    final params = [data];
    final response = await read(function, params, atBlock);
    return (response[0] as _i2.Uint8List);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<_i1.EthereumAddress>> getFriends({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[9];
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
    final function = self.abi.functions[10];
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
    final function = self.abi.functions[11];
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
    final function = self.abi.functions[12];
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
    final function = self.abi.functions[13];
    assert(checkSignature(function, '68125a1b'));
    final params = [$param14];
    final response = await read(function, params, atBlock);
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> manager({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[14];
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
    final function = self.abi.functions[15];
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
    final function = self.abi.functions[16];
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
    final function = self.abi.functions[17];
    assert(checkSignature(function, '4ab88427'));
    final params = [_friends, _threshold];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> threshold({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[18];
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
