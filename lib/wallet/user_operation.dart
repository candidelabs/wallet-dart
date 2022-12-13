import 'dart:typed_data';

import 'package:wallet_dart/contracts/entrypoint.dart';
import 'package:wallet_dart/utils/abi_utils.dart';
import 'package:wallet_dart/wallet/abi_encoders.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class UserOperation {
  //
  static const defaultGas = 215000;
  static const _defaultMaxFee = 50000000000; // 50 Gwei
  static const initNonce = 0;
  static const nullCode = "0x";
  //
  EthereumAddress sender;
  int nonce;
  String initCode;
  String callData;
  int callGas;
  int verificationGas;
  int preVerificationGas;
  int maxFeePerGas;
  int maxPriorityFeePerGas;
  EthereumAddress paymaster;
  String paymasterData;
  String signature;
  String moduleManagerSalt;

  UserOperation(
      {required this.sender,
      required this.nonce,
      required this.initCode,
      required this.callData,
      required this.callGas,
      required this.verificationGas,
      required this.preVerificationGas,
      required this.maxFeePerGas,
      required this.maxPriorityFeePerGas,
      required this.paymaster,
      required this.paymasterData,
      required this.signature,
      required this.moduleManagerSalt
      });

  UserOperation.fromJson(Map<String, dynamic> json)
      : sender = EthereumAddress.fromHex(json['sender']),
        nonce = json['nonce'],
        initCode = json['initCode'],
        callData = json['callData'],
        callGas = json['callGas'],
        verificationGas = json['verificationGas'],
        preVerificationGas = json['preVerificationGas'],
        maxFeePerGas = json['maxFeePerGas'],
        maxPriorityFeePerGas = json['maxPriorityFeePerGas'],
        paymaster = EthereumAddress.fromHex(json['paymaster']),
        paymasterData = json['paymasterData'],
        signature = json['signature'],
        moduleManagerSalt = json['moduleManagerSalt'];

  Map<String, dynamic> toJson() => {
    'sender': sender.hexEip55,
    'nonce': nonce,
    'initCode': initCode,
    'callData': callData,
    'callGas': callGas,
    'verificationGas': verificationGas,
    'preVerificationGas': preVerificationGas,
    'maxFeePerGas': maxFeePerGas,
    'maxPriorityFeePerGas': maxPriorityFeePerGas,
    'paymaster': paymaster.hexEip55,
    'paymasterData': paymasterData,
    'signature': signature,
    'moduleManagerSalt': moduleManagerSalt,
  };

  List<dynamic> toList({bool hexRepresentation = false}) => [
    hexRepresentation ? sender.hexEip55 : sender,
    hexRepresentation ? nonce.toString() : BigInt.from(nonce),
    hexRepresentation ? initCode : hexToBytes(initCode),
    hexRepresentation ? callData : hexToBytes(callData),
    hexRepresentation ? callGas.toString() : BigInt.from(callGas),
    hexRepresentation ? verificationGas.toString() : BigInt.from(verificationGas),
    hexRepresentation ? preVerificationGas.toString() : BigInt.from(preVerificationGas),
    hexRepresentation ? maxFeePerGas.toString() : BigInt.from(maxFeePerGas),
    hexRepresentation ? maxPriorityFeePerGas.toString() : BigInt.from(maxPriorityFeePerGas),
    hexRepresentation ? paymaster.hexEip55 : paymaster,
    hexRepresentation ? paymasterData : hexToBytes(paymasterData),
    hexRepresentation ? signature : hexToBytes(signature)
  ];

  static UserOperation get({
    EthereumAddress? sender,
    int? nonce,
    String? initCode,
    String? callData,
    int? callGas,
    int? verificationGas,
    int? preVerificationGas,
    int? maxFeePerGas,
    int? maxPriorityFeePerGas,
    EthereumAddress? paymaster,
    String? paymasterData,
    String? signature,
    String? moduleManagerSalt,
  }){
    return UserOperation(
      sender: sender ?? EthereumAddress(Uint8List(EthereumAddress.addressByteLength)),
      nonce: nonce ?? initNonce,
      initCode: initCode ?? nullCode,
      callData: callData ?? nullCode,
      callGas: callGas ?? defaultGas,
      verificationGas: verificationGas ?? defaultGas,
      preVerificationGas: preVerificationGas ?? defaultGas,
      maxFeePerGas: maxFeePerGas ?? _defaultMaxFee,
      maxPriorityFeePerGas: maxPriorityFeePerGas ?? _defaultMaxFee,
      paymaster: paymaster ?? EthereumAddress(Uint8List(EthereumAddress.addressByteLength)),
      paymasterData: paymasterData ?? nullCode,
      signature: signature ?? nullCode,
      moduleManagerSalt: moduleManagerSalt ?? nullCode,
    );
  }

  Uint8List pack(){
    List<dynamic> params = this.toList();
    var abiEncoded = AbiEncoders.requestIdCoder.functions.first.encodeCall([params]).sublist(4);
    var abiEncodedHex = bytesToHex(abiEncoded);
    abiEncodedHex = abiEncodedHex.substring(64, abiEncodedHex.length - 64);
    return hexToBytes(abiEncodedHex);
  }

  Future<Uint8List> requestId(EthereumAddress entryPoint, BigInt chainId) async {
    return keccak256(encodeAbi(["bytes32", "address", "uint256"], [keccak256(pack()), entryPoint, chainId]));
  }

  Future<void> sign(Credentials credentials, BigInt chainId, {Uint8List? overrideRequestId}) async {
    var _requestId = await requestId(CEntrypoint.address, chainId);
    signature = bytesToHex(
      await credentials.signPersonalMessage(
        overrideRequestId ?? _requestId,
      ),
    include0x: true);
  }

}