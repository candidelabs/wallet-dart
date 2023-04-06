import 'dart:typed_data';

import 'package:wallet_dart/utils/abi_utils.dart';
import 'package:wallet_dart/wallet/abi_encoders.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class UserOperation {
  //
  static BigInt _defaultGas = BigInt.from(215000);
  static BigInt _defaultMaxFee = BigInt.from(50000000000); // 50 Gwei
  static BigInt _initNonce = BigInt.zero;
  static const _nullCode = "0x";
  //
  EthereumAddress sender;
  BigInt nonce;
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
        nonce = BigInt.parse(json['nonce'].replaceAll("0x", ""), radix: 16),
        initCode = json['initCode'],
        callData = json['callData'],
        callGasLimit = BigInt.parse(json['callGasLimit'].replaceAll("0x", ""), radix: 16),
        verificationGasLimit = BigInt.parse(json['verificationGasLimit'].replaceAll("0x", ""), radix: 16),
        preVerificationGas = BigInt.parse(json['preVerificationGas'].replaceAll("0x", ""), radix: 16),
        maxFeePerGas = BigInt.parse(json['maxFeePerGas'].replaceAll("0x", ""), radix: 16),
        maxPriorityFeePerGas = BigInt.parse(json['maxPriorityFeePerGas'].replaceAll("0x", ""), radix: 16),
        paymasterAndData = json['paymasterAndData'],
        signature = json['signature'];

  Map<String, dynamic> toJson() => {
    'sender': sender.hexEip55,
    'nonce': "0x"+nonce.toRadixString(16),
    'initCode': initCode,
    'callData': callData,
    'callGasLimit': "0x"+callGasLimit.toRadixString(16),
    'verificationGasLimit': "0x"+verificationGasLimit.toRadixString(16),
    'preVerificationGas': "0x"+preVerificationGas.toRadixString(16),
    'maxFeePerGas': "0x"+maxFeePerGas.toRadixString(16),
    'maxPriorityFeePerGas': "0x"+maxPriorityFeePerGas.toRadixString(16),
    'paymasterAndData': paymasterAndData,
    'signature': signature,
  };

  List<dynamic> toList({bool hexRepresentation = false}) => [
    hexRepresentation ? sender.hexEip55 : sender,
    hexRepresentation ? "0x"+nonce.toRadixString(16) : nonce,
    hexRepresentation ? initCode : hexToBytes(initCode),
    hexRepresentation ? callData : hexToBytes(callData),
    hexRepresentation ? "0x"+callGasLimit.toRadixString(16) : callGasLimit,
    hexRepresentation ? "0x"+verificationGasLimit.toRadixString(16) : verificationGasLimit,
    hexRepresentation ? "0x"+preVerificationGas.toRadixString(16) : preVerificationGas,
    hexRepresentation ? "0x"+maxFeePerGas.toRadixString(16) : maxFeePerGas,
    hexRepresentation ? "0x"+maxPriorityFeePerGas.toRadixString(16) : maxPriorityFeePerGas,
    hexRepresentation ? paymasterAndData : hexToBytes(paymasterAndData),
    hexRepresentation ? signature : hexToBytes(signature)
  ];

  static UserOperation get({
    EthereumAddress? sender,
    BigInt? nonce,
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
      nonce: nonce ?? _initNonce,
      initCode: initCode ?? _nullCode,
      callData: callData ?? _nullCode,
      callGasLimit: callGasLimit ?? _defaultGas,
      verificationGasLimit: verificationGas ?? _defaultGas,
      preVerificationGas: preVerificationGas ?? _defaultGas,
      maxFeePerGas: maxFeePerGas ?? _defaultMaxFee,
      maxPriorityFeePerGas: maxPriorityFeePerGas ?? _defaultMaxFee,
      paymasterAndData: paymasterAndData ?? _nullCode,
      signature: signature ?? _nullCode,
    );
  }

  Uint8List pack(){
    List<dynamic> params = this.toList();
    var abiEncoded = AbiEncoders.requestIdCoder.functions.first.encodeCall([params]).sublist(4);
    var abiEncodedHex = bytesToHex(abiEncoded);
    abiEncodedHex = abiEncodedHex.substring(64, abiEncodedHex.length - 64);
    return hexToBytes(abiEncodedHex);
  }

  Uint8List getHash(EthereumAddress entryPoint, BigInt chainId) {
    return keccak256(encodeAbi(["bytes32", "address", "uint256"], [keccak256(pack()), entryPoint, chainId]));
  }

  Future<void> sign(Credentials credentials, EthereumAddress entrypoint, BigInt chainId) async {
    var _userOpHash = getHash(entrypoint, chainId);
    signature = bytesToHex(
      credentials.signPersonalMessageToUint8List(
        _userOpHash,
      ),
    include0x: true);
  }

}