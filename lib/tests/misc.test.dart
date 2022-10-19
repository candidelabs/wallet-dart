import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:test/test.dart';
import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/factories/EIP4337Manager.g.dart';
import 'package:wallet_dart/contracts/factories/EntryPoint.g.dart';
import 'package:wallet_dart/contracts/factories/SocialRecoveryModule.g.dart';
import 'package:wallet_dart/contracts/wallet.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/src/utils/typed_data.dart';
import 'package:wallet_dart/wallet/UserOperation.dart';
import 'package:wallet_dart/wallet/encode_function_data.dart';
import 'package:wallet_dart/wallet/wallet_helpers.dart';
import 'package:wallet_dart/wallet/wallet_instance.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

String jsonData = '''
[{"inputs":[{"internalType":"address","name":"_create2factory","type":"address"},{"internalType":"uint256","name":"_paymasterStake","type":"uint256"},{"internalType":"uint32","name":"_unstakeDelaySec","type":"uint32"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"uint256","name":"opIndex","type":"uint256"},{"internalType":"address","name":"paymaster","type":"address"},{"internalType":"string","name":"reason","type":"string"}],"name":"FailedOp","type":"error"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"uint256","name":"totalDeposit","type":"uint256"}],"name":"Deposited","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"uint256","name":"totalStaked","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"withdrawTime","type":"uint256"}],"name":"StakeLocked","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"uint256","name":"withdrawTime","type":"uint256"}],"name":"StakeUnlocked","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"address","name":"withdrawAddress","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"StakeWithdrawn","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"requestId","type":"bytes32"},{"indexed":true,"internalType":"address","name":"sender","type":"address"},{"indexed":true,"internalType":"address","name":"paymaster","type":"address"},{"indexed":false,"internalType":"uint256","name":"nonce","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"actualGasCost","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"actualGasPrice","type":"uint256"},{"indexed":false,"internalType":"bool","name":"success","type":"bool"}],"name":"UserOperationEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"bytes32","name":"requestId","type":"bytes32"},{"indexed":true,"internalType":"address","name":"sender","type":"address"},{"indexed":false,"internalType":"uint256","name":"nonce","type":"uint256"},{"indexed":false,"internalType":"bytes","name":"revertReason","type":"bytes"}],"name":"UserOperationRevertReason","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"account","type":"address"},{"indexed":false,"internalType":"address","name":"withdrawAddress","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"Withdrawn","type":"event"},{"inputs":[{"internalType":"uint32","name":"_unstakeDelaySec","type":"uint32"}],"name":"addStake","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"create2factory","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"depositTo","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"deposits","outputs":[{"internalType":"uint112","name":"deposit","type":"uint112"},{"internalType":"bool","name":"staked","type":"bool"},{"internalType":"uint112","name":"stake","type":"uint112"},{"internalType":"uint32","name":"unstakeDelaySec","type":"uint32"},{"internalType":"uint64","name":"withdrawTime","type":"uint64"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"getDepositInfo","outputs":[{"components":[{"internalType":"uint112","name":"deposit","type":"uint112"},{"internalType":"bool","name":"staked","type":"bool"},{"internalType":"uint112","name":"stake","type":"uint112"},{"internalType":"uint32","name":"unstakeDelaySec","type":"uint32"},{"internalType":"uint64","name":"withdrawTime","type":"uint64"}],"internalType":"struct StakeManager.DepositInfo","name":"info","type":"tuple"}],"stateMutability":"view","type":"function"},{"inputs":[{"components":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"uint256","name":"nonce","type":"uint256"},{"internalType":"bytes","name":"initCode","type":"bytes"},{"internalType":"bytes","name":"callData","type":"bytes"},{"internalType":"uint256","name":"callGas","type":"uint256"},{"internalType":"uint256","name":"verificationGas","type":"uint256"},{"internalType":"uint256","name":"preVerificationGas","type":"uint256"},{"internalType":"uint256","name":"maxFeePerGas","type":"uint256"},{"internalType":"uint256","name":"maxPriorityFeePerGas","type":"uint256"},{"internalType":"address","name":"paymaster","type":"address"},{"internalType":"bytes","name":"paymasterData","type":"bytes"},{"internalType":"bytes","name":"signature","type":"bytes"}],"internalType":"struct UserOperation","name":"userOp","type":"tuple"}],"name":"getRequestId","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes","name":"initCode","type":"bytes"},{"internalType":"uint256","name":"salt","type":"uint256"}],"name":"getSenderAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"sender","type":"address"}],"name":"getSenderStorage","outputs":[{"internalType":"uint256[]","name":"senderStorageCells","type":"uint256[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"components":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"uint256","name":"nonce","type":"uint256"},{"internalType":"bytes","name":"initCode","type":"bytes"},{"internalType":"bytes","name":"callData","type":"bytes"},{"internalType":"uint256","name":"callGas","type":"uint256"},{"internalType":"uint256","name":"verificationGas","type":"uint256"},{"internalType":"uint256","name":"preVerificationGas","type":"uint256"},{"internalType":"uint256","name":"maxFeePerGas","type":"uint256"},{"internalType":"uint256","name":"maxPriorityFeePerGas","type":"uint256"},{"internalType":"address","name":"paymaster","type":"address"},{"internalType":"bytes","name":"paymasterData","type":"bytes"},{"internalType":"bytes","name":"signature","type":"bytes"}],"internalType":"struct UserOperation[]","name":"ops","type":"tuple[]"},{"internalType":"address payable","name":"beneficiary","type":"address"}],"name":"handleOps","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"components":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"uint256","name":"nonce","type":"uint256"},{"internalType":"bytes","name":"initCode","type":"bytes"},{"internalType":"bytes","name":"callData","type":"bytes"},{"internalType":"uint256","name":"callGas","type":"uint256"},{"internalType":"uint256","name":"verificationGas","type":"uint256"},{"internalType":"uint256","name":"preVerificationGas","type":"uint256"},{"internalType":"uint256","name":"maxFeePerGas","type":"uint256"},{"internalType":"uint256","name":"maxPriorityFeePerGas","type":"uint256"},{"internalType":"address","name":"paymaster","type":"address"},{"internalType":"bytes","name":"paymasterData","type":"bytes"},{"internalType":"bytes","name":"signature","type":"bytes"}],"internalType":"struct UserOperation","name":"op","type":"tuple"},{"components":[{"internalType":"bytes32","name":"requestId","type":"bytes32"},{"internalType":"uint256","name":"prefund","type":"uint256"},{"internalType":"enum EntryPoint.PaymentMode","name":"paymentMode","type":"uint8"},{"internalType":"uint256","name":"contextOffset","type":"uint256"},{"internalType":"uint256","name":"preOpGas","type":"uint256"}],"internalType":"struct EntryPoint.UserOpInfo","name":"opInfo","type":"tuple"},{"internalType":"bytes","name":"context","type":"bytes"}],"name":"innerHandleOp","outputs":[{"internalType":"uint256","name":"actualGasCost","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"paymasterStake","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"components":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"uint256","name":"nonce","type":"uint256"},{"internalType":"bytes","name":"initCode","type":"bytes"},{"internalType":"bytes","name":"callData","type":"bytes"},{"internalType":"uint256","name":"callGas","type":"uint256"},{"internalType":"uint256","name":"verificationGas","type":"uint256"},{"internalType":"uint256","name":"preVerificationGas","type":"uint256"},{"internalType":"uint256","name":"maxFeePerGas","type":"uint256"},{"internalType":"uint256","name":"maxPriorityFeePerGas","type":"uint256"},{"internalType":"address","name":"paymaster","type":"address"},{"internalType":"bytes","name":"paymasterData","type":"bytes"},{"internalType":"bytes","name":"signature","type":"bytes"}],"internalType":"struct UserOperation","name":"userOp","type":"tuple"}],"name":"simulateValidation","outputs":[{"internalType":"uint256","name":"preOpGas","type":"uint256"},{"internalType":"uint256","name":"prefund","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"unlockStake","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"unstakeDelaySec","outputs":[{"internalType":"uint32","name":"","type":"uint32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address payable","name":"withdrawAddress","type":"address"}],"name":"withdrawStake","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"withdrawAddress","type":"address"},{"internalType":"uint256","name":"withdrawAmount","type":"uint256"}],"name":"withdrawTo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"}]
''';

Uint8List randomBytes(int length, {bool secure = false}) {
  assert(length > 0);

  final random = secure ? Random.secure() : Random();
  final ret = Uint8List(length);

  for (var i = 0; i < length; i++) {
    ret[i] = random.nextInt(256);
  }
  return ret;
}

Future<String> requestPaymasterSignature(UserOperation op) async {
  var response = await http.post(
      Uri.parse("http://127.0.0.1:8000/jsonrpc/"),
      body: jsonEncode({
        "jsonrpc": "2.0",
        "id": 1,
        "method": "eth_paymaster",
        "params": [
          op.toJson()
        ]
      })
  );
  return jsonDecode(response.body)["result"];
}

Future<void> sendToBundler(List<UserOperation> ops) async {
  await http.post(
    Uri.parse("http://127.0.0.1:8000/jsonrpc/"),
    body: jsonEncode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "eth_sendUserOperation",
      "params": [
        ops.map((e) => e.toJson()).toList()
      ]
    })
  );
}

var _wallet = '{"walletAddress":"0x0865b3CB8c8FB45547554c7b77A744d1Cce1a056","moduleManager":"0xf75833DD2F93c093A34c3bb49f204C0784244a3C","socialRecovery":"0x289243805dEf32b2b88b7cf9923F877873950031","initOwner":"0x95f9d01eD1133e04615CF460aEB675e9f0B73Ed7","initGuardians":[],"salt":"8sFp8X0Zx3EQJGVrvttLBg==","encryptedSigner":"VwxGoozf3xYa144pGU6V+ztAy3w973vUTRN91GbNKRJNGVgsPPXYStLE4WvWp4qACPH0TrNU5TfbXHa6jDMb69/Tuyx2OsexnlZgBqWn9dE="}';
var _moduleManager = EthereumAddress.fromHex("0x8186edc2B753b9F9efC75d911A0333C240CA9A37");
var bundler = EthPrivateKey.fromHex("0xf83b9a1891aac5fc768e9e42aaea05426d279ebe250b903624e1a9492fba0ca6");

void main(){
  test("create2Manager", () async {
    var wallet = WalletInstance.fromJson(jsonDecode(_wallet));
    //var walletCredentials = WalletHelpers.decryptSigner(wallet, "0025Gg!", wallet.salt);
    print(wallet.toJson());
    //
    //print(EIP4337Manager(address: Constants.singletonFactoryAddress, client: Constants.web3client).self.constructors.map((e) => e.name));
    print(bytesToHex(WalletHelpers.getManagerInitCode(), include0x: true));
    //var address = WalletHelpers.getSocialRecoveryAddress(wallet.salt, suffix: "_socialRecoveryTestBrownie3");
    //print(address);
    //
    /*var randomSalt = randomBytes(32, secure: true);
    print(bytesToHex(randomSalt, include0x: true));
    print(WalletHelpers.getWalletManagerAddress(randomSalt));*/
    //
    expect(1, 1);
  });

  test("matchingRequestIds", () async {
    //
    UserOperation userOp = UserOperation.get(
      sender: EthereumAddress.fromHex("0xdbd510f9EBB7A81209FcCD12A56f6c6354AA8caB"),
      nonce: 5,
      initCode: '0x63616e646964652069732074686520626573742077616c6c657420746861742063616e20657869737420696e207468652063757272656e742067656e65726174696f6e206f662077616c6c657473',
      callData: "0xaabb",
      verificationGas: 10,
      preVerificationGas: 9,
      maxFeePerGas: 8,
      maxPriorityFeePerGas: 7,
      paymaster: EthereumAddress.fromHex("0x0000000000000000000000000000000000000000"),
      paymasterData: "0x63616e646964652069732074686520626573742077616c6c657420746861742063616e20657869737420696e207468652063757272656e742067656e65726174696f6e206f662077616c6c657473",
      signature: '0x'
    );
    //
    print(jsonEncode(userOp.toJson()));
    print(jsonEncode(userOp.toList(hexRepresentation: true)));
    //
    var hash = await userOp.requestId(EthereumAddress.fromHex("0x602aB3881Ff3Fa8dA60a8F44Cf633e91bA1FdB69"), BigInt.from(5));
    //
    var entryPointContract = DeployedContract(ContractAbi.fromJson(jsonData, "EntryPoint"), EthereumAddress.fromHex("0x602aB3881Ff3Fa8dA60a8F44Cf633e91bA1FdB69"));
    var result = await Constants.brownieClient.call(contract: entryPointContract, function: entryPointContract.function("getRequestId"), params: [userOp.toList()]);
    var epHash = result[0];
    //
    print(bytesToHex(hash, include0x: true));
    print(bytesToHex(epHash, include0x: true));
    //
    expect(hash, epHash);
  });

  test('createWallet', () async {
    var _tempWallet = await WalletHelpers.createRandom("StrongPass1@", "Ewgy2h6bcV3Fh1Sk9WPj4g==", [EthereumAddress.fromHex("0xdbd510f9ebb7a81209fccd12a56f6c6354aa8cab"),EthereumAddress.fromHex("0xffcc60e7dbf2c9accdb0b8caa699d7b50086c807")]);
    print(jsonEncode(_tempWallet.toJson()));
    return;
  });
  test('deployWallet', () async {
    //
    var wallet = WalletInstance.fromJson(jsonDecode(_wallet));
    var walletCredentials = WalletHelpers.decryptSigner(wallet, "StrongPass1@", "Ewgy2h6bcV3Fh1Sk9WPj4g==");
    //
    var initCode = WalletHelpers.getInitCode(EthereumAddress.fromHex(wallet.initOwner), wallet.moduleManager);
    var entryPoint = EntryPoint(
      address: EthereumAddress.fromHex("0x602aB3881Ff3Fa8dA60a8F44Cf633e91bA1FdB69"),
      client: Constants.brownieClient,
      chainId: 5
    );
    //
    var op = UserOperation.get(
      sender: wallet.walletAddress,
      nonce: 0,
      initCode: bytesToHex(initCode, include0x: true),
      callData: EncodeFunctionData.execTransactionFromModule(EthereumAddress.fromHex("0x29a05fBb41C60eB0dAD1ACba22444A803300feE3"), BigInt.from(15000), hexToBytes(UserOperation.nullCode)),
      callGas: 2150000,
      verificationGas: 645000,
      preVerificationGas: 21000,
      maxFeePerGas: 1,
      maxPriorityFeePerGas: 1,
    );
    //
    var localRequestId = await op.requestId(EthereumAddress.fromHex("0x602aB3881Ff3Fa8dA60a8F44Cf633e91bA1FdB69"), BigInt.from(5));
    print("Request ID: ${bytesToHex(localRequestId, include0x: true)}");
    //
    var signature = await walletCredentials!.signPersonalMessage(localRequestId);
    op.signature = bytesToHex(signature, include0x: true);
    //
    var _bundlerAddress = await bundler.extractAddress();
    print("Bundler address: ${_bundlerAddress.hexEip55}");
    //
    List<dynamic> ops = [];
    ops.add(op.toList());
    try{
      print("Relaying...");
      await sendToBundler([op]);
      //await entryPoint.handleOps(ops, _bundlerAddress, credentials: bundler);
    } on RPCError catch (e, t){
      print(e.errorCode);
      print(e.message);
      print(e.data);
    }
    //
    expect(1, 1);
  });
  test('sendEther', () async {
    //return;
    //
    var wallet = WalletInstance.fromJson(jsonDecode(_wallet));
    var walletCredentials = WalletHelpers.decryptSigner(wallet, "StrongPass1@", "Ewgy2h6bcV3Fh1Sk9WPj4g==");
    //
    var entryPoint = EntryPoint(
        address: EthereumAddress.fromHex("0x602aB3881Ff3Fa8dA60a8F44Cf633e91bA1FdB69"),
        client: Constants.brownieClient,
        chainId: 5
    );
    var walletInterface = CWallet.customInterface(wallet.walletAddress, client: Constants.brownieClient);
    //
    List<dynamic> params = [
      EthereumAddress.fromHex("0xaffE306fCd58241B63D383AD04957C9E34Bc33c9"),
      BigInt.from(5),
      hexToBytes("0x"),
      BigInt.zero,
      BigInt.from(215000),
      BigInt.from(215000),
      BigInt.from(100000),
      EthereumAddress.fromHex("0x03F1B4380995Fbf41652F75a38c9F74aD8aD73F5"),
      await bundler.extractAddress(),
    ];
    //
    var nonce = (await walletInterface.nonce()).toInt();
    //
    Uint8List hash = await walletInterface.getTransactionHash(
      params[0],
      params[1],
      params[2],
      params[3],
      params[4],
      params[5],
      params[6],
      params[7],
      params[8],
      BigInt.from(nonce+1),
    );
    var privateKey = (walletCredentials as EthPrivateKey).privateKey;
    //
    var op = UserOperation.get(
      sender: wallet.walletAddress,
      nonce: nonce,
      callData: EncodeFunctionData.execTransaction(
        params[0],
        params[1],
        params[2],
        params[3],
        params[4],
        params[5],
        params[6],
        params[7],
        params[8],
        hexToBytes(EthSigUtil.signMessage(
          privateKeyInBytes: privateKey,
          message: hash,
        )),
      ),
      callGas: 2150000,
      verificationGas: 645000,
      preVerificationGas: 21000,
      maxFeePerGas: 1,
      maxPriorityFeePerGas: 1,
      paymaster: EthereumAddress.fromHex("0x45D2Ef453E652B78E2ccE403083668a3804EC4B1"),
      paymasterData: "0x",
    );
    //
    op.paymasterData = await requestPaymasterSignature(op);
    //
    //var localRequestId = await op.requestId(EthereumAddress.fromHex("0x602aB3881Ff3Fa8dA60a8F44Cf633e91bA1FdB69"), BigInt.from(5));
    var localRequestId = hexToBytes("0x99d215eb8de7c059fc7bec8c80dc83820cb95a1fad94fa3823b5474c844d04e7");
    var signature = await walletCredentials.signPersonalMessage(localRequestId);
    op.signature = bytesToHex(signature, include0x: true);
    //
    print(bytesToHex(localRequestId, include0x: true));
    print(jsonEncode(op.toJson()));
    print(jsonEncode(op.toList(hexRepresentation: true)));
    return;
    //
    /*var op2 = UserOperation.get(
      sender: wallet.walletAddress,
      nonce: (await CWallet.customInterface(wallet.walletAddress, client: Constants.brownieClient).nonce()).toInt(),
      callData: EncodeFunctionData.execTransactionFromModule(EthereumAddress.fromHex("0x29a05fBb41C60eB0dAD1ACba22444A803300feE3"), BigInt.from(15000), hexToBytes(UserOperation.nullCode)),
      callGas: 2150000,
      verificationGas: 645000,
      preVerificationGas: 21000,
      maxFeePerGas: 1,
      maxPriorityFeePerGas: 1,
    );
    var localRequestId2 = await op2.requestId(EthereumAddress.fromHex("0x602aB3881Ff3Fa8dA60a8F44Cf633e91bA1FdB69"), BigInt.from(5));
    var signature2 = await walletCredentials.signPersonalMessage(localRequestId2);
    op2.signature = bytesToHex(signature2, include0x: true);*/
    //
    List<UserOperation> bundlerOps = [];
    bundlerOps.add(op);
    //bundlerOps.add(op2);
    //
    List<dynamic> ops = [];
    ops.add(op.toList());
    //ops.add(op2.toList());
    //
    try{
      print("Relaying...");
      await sendToBundler(bundlerOps);
      print("done!");
      //await entryPoint.handleOps(ops, (await bundler.extractAddress()), credentials: bundler);
    } on RPCError catch (e, t){
      print(e.errorCode);
      print(e.message);
      print(e.data);
    }
    //
    expect(1, 1);
  });
}