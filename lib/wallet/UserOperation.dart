import 'dart:typed_data';

import 'package:magic_sdk/magic_sdk.dart';
import 'package:wallet_dart/wallet/AbiEncoders.dart';
import 'package:wallet_dart/wallet/Message.dart';
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
      required this.signature
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
        signature = json['signature'];

  Map<String, dynamic> toJson() => {
    'sender': sender.hex,
    'nonce': nonce,
    'initCode': initCode,
    'callData': callData,
    'callGas': callGas,
    'verificationGas': verificationGas,
    'preVerificationGas': preVerificationGas,
    'maxFeePerGas': maxFeePerGas,
    'maxPriorityFeePerGas': maxPriorityFeePerGas,
    'paymaster': paymaster.hex,
    'paymasterData': paymasterData,
    'signature': signature,
  };

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
      signature: signature ?? nullCode
    );
  }

  Future<Uint8List> requestId(EthereumAddress entryPoint, BigInt chainId) async {
    return keccak256(
        AbiEncoders.requestIdCoder.functions.first.encodeCall([
          Message.userOperation(this),
          entryPoint,
          chainId
        ]).sublist(4)
    );
  }

  Future<void> sign(Credentials credentials, BigInt chainId) async {
    var walletSignatureValues = [
      {
        "signer": await credentials.extractAddress(),
        "signature": await credentials.signPersonalMessage(
          await requestId(EthereumAddress.fromHex("0x6D59643f668d67D4E80a14CB65be02264D3c5aDB"), chainId),
        ),
      },
    ];
    signature = bytesToHex(
      AbiEncoders.ownerSignMessage.functions.first.encodeCall([
        BigInt.zero,
        [
          [
            walletSignatureValues[0]["signer"],
            walletSignatureValues[0]["signature"],
          ]
        ]
      ]).sublist(4),
      include0x: true
    );
  }


  Future<void> signAsGuardian(Credentials credentials, BigInt chainId, {bool isMagicLink=false}) async { // todo this only support 1 guardian signature, multi-guardian is still to do
    var requestIdPayload = await requestId(EthereumAddress.fromHex("0x6D59643f668d67D4E80a14CB65be02264D3c5aDB"), chainId);
    var walletSignatureValues = [
      {
        "signer": await credentials.extractAddress(),
        "signature": !isMagicLink ? await credentials.signPersonalMessage(
          requestIdPayload,
        ) : hexToBytes(await (credentials as MagicCredential).personalSign(
          payload: requestIdPayload
        )),
      },
    ];
    signature = bytesToHex(
      AbiEncoders.ownerSignMessage.functions.first.encodeCall([
        BigInt.one,
        [
          [
            walletSignatureValues[0]["signer"],
            walletSignatureValues[0]["signature"],
          ]
        ]
      ]).sublist(4),
      include0x: true
    );
  }

}