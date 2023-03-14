import 'dart:typed_data';

import 'package:wallet_dart/contracts/entrypoint.dart';
import 'package:wallet_dart/utils/abi_utils.dart';
import 'package:wallet_dart/wallet/abi_encoders.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class UserOperation {
  //
  static BigInt _defaultGas = BigInt.from(215000);
  static BigInt _defaultMaxFee = BigInt.from(50000000000); // 50 Gwei
  static const initNonce = 0;
  static const nullCode = "0x";
  //
  EthereumAddress sender;
  int nonce;
  String initCode;
  String callData;
  BigInt callGasLimit;
  BigInt verificationGasLimit;
  BigInt preVerificationGas;
  BigInt maxFeePerGas;
  BigInt maxPriorityFeePerGas;
  String paymasterAndData;
  String signature;

  UserOperation(
      {required this.sender,
      required this.nonce,
      required this.initCode,
      required this.callData,
      required this.callGasLimit,
      required this.verificationGasLimit,
      required this.preVerificationGas,
      required this.maxFeePerGas,
      required this.maxPriorityFeePerGas,
      required this.paymasterAndData,
      required this.signature,
      });

  UserOperation.fromJson(Map<String, dynamic> json)
      : sender = EthereumAddress.fromHex(json['sender']),
        nonce = json['nonce'],
        initCode = json['initCode'],
        callData = json['callData'],
        callGasLimit = json['callGasLimit'],
        verificationGasLimit = json['verificationGasLimit'],
        preVerificationGas = json['preVerificationGas'],
        maxFeePerGas = json['maxFeePerGas'],
        maxPriorityFeePerGas = json['maxPriorityFeePerGas'],
        paymasterAndData = json['paymasterAndData'],
        signature = json['signature'];

  Map<String, dynamic> toJson() => {
    'sender': sender.hexEip55,
    'nonce': nonce,
    'initCode': initCode,
    'callData': callData,
    'callGasLimit': callGasLimit,
    'verificationGasLimit': verificationGasLimit,
    'preVerificationGas': preVerificationGas,
    'maxFeePerGas': maxFeePerGas,
    'maxPriorityFeePerGas': maxPriorityFeePerGas,
    'paymasterAndData': paymasterAndData,
    'signature': signature,
  };

  List<dynamic> toList({bool hexRepresentation = false}) => [
    hexRepresentation ? sender.hexEip55 : sender,
    hexRepresentation ? nonce.toString() : BigInt.from(nonce),
    hexRepresentation ? initCode : hexToBytes(initCode),
    hexRepresentation ? callData : hexToBytes(callData),
    hexRepresentation ? callGasLimit.toString() : callGasLimit,
    hexRepresentation ? verificationGasLimit.toString() : verificationGasLimit,
    hexRepresentation ? preVerificationGas.toString() : preVerificationGas,
    hexRepresentation ? maxFeePerGas.toString() : maxFeePerGas,
    hexRepresentation ? maxPriorityFeePerGas.toString() : maxPriorityFeePerGas,
    hexRepresentation ? paymasterAndData : hexToBytes(paymasterAndData),
    hexRepresentation ? signature : hexToBytes(signature)
  ];

  static UserOperation get({
    EthereumAddress? sender,
    int? nonce,
    String? initCode,
    String? callData,
    BigInt? callGasLimit,
    BigInt? verificationGas,
    BigInt? preVerificationGas,
    BigInt? maxFeePerGas,
    BigInt? maxPriorityFeePerGas,
    EthereumAddress? paymaster,
    String? paymasterAndData,
    String? signature,
  }){
    return UserOperation(
      sender: sender ?? EthereumAddress(Uint8List(EthereumAddress.addressByteLength)),
      nonce: nonce ?? initNonce,
      initCode: initCode ?? nullCode,
      callData: callData ?? nullCode,
      callGasLimit: callGasLimit ?? _defaultGas,
      verificationGasLimit: verificationGas ?? _defaultGas,
      preVerificationGas: preVerificationGas ?? _defaultGas,
      maxFeePerGas: maxFeePerGas ?? _defaultMaxFee,
      maxPriorityFeePerGas: maxPriorityFeePerGas ?? _defaultMaxFee,
      paymasterAndData: paymasterAndData ?? nullCode,
      signature: signature ?? nullCode,
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

  Future<void> sign(Credentials credentials, EthereumAddress entrypoint, BigInt chainId, {Uint8List? overrideRequestId}) async {
    var _requestId = await requestId(entrypoint, chainId);
    signature = bytesToHex(
      credentials.signPersonalMessageToUint8List(
        overrideRequestId ?? _requestId,
      ),
    include0x: true);
  }

}