import 'dart:convert';
import 'dart:typed_data';

import 'package:wallet_dart/wallet/user_operation.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/src/utils/length_tracking_byte_sink.dart';

var _regexBytes = RegExp(r"^(bytes)([0-9]+)$");
var _regexNumber = RegExp(r"^(u?int)([0-9]*)$");

class Message {
  static userOperation(UserOperation op){
    return keccak256(
        solidityPack(
            [
              "address",
              "uint256",
              "bytes32",
              "bytes32",
              "uint256",
              "uint256",
              "uint256",
              "uint256",
              "uint256",
              "address",
              "bytes32",
            ],
            [
              op.sender,
              op.nonce,
              bytesToHex(keccak256(hexToBytes(op.initCode)), include0x: true),
              bytesToHex(keccak256(hexToBytes(op.callData)), include0x: true),
              op.callGas,
              op.verificationGas,
              op.preVerificationGas,
              op.maxFeePerGas,
              op.maxPriorityFeePerGas,
              op.paymaster,
              bytesToHex(keccak256(hexToBytes(op.paymasterData)), include0x: true),
            ]
        )
    );
  }


  static Uint8List solidityPack(List<String> types, List<dynamic> values){
    if (values.length != types.length){
      throw ArgumentError("wrong number of values; expected ${ types.length }");
    }

    LengthTrackingByteSink sink = LengthTrackingByteSink();

    for (int i=0; i<values.length; i++){
      var x = _pack(types[i], values[i]);
      sink.add(x);
    }
    return sink.asBytes();
  }



  static Uint8List _pack(String type, dynamic value){
    if (type == "address"){
      if (value is EthereumAddress){
        return value.addressBytes;
      }
    }
    if (type == "string"){
      return Uint8List.fromList(utf8.encode(value));
    }
    //
    var _numMatch = _regexNumber.allMatches(type);
    if (_numMatch.isNotEmpty) {
      var size = int.parse(_numMatch.length > 1 ? _numMatch.elementAt(2).input : "256");
      if ((size % 8 != 0) || size == 0 || size > 256) {
        throw ArgumentError("invalid number type");
      }
      
      BigInt _value = BigInt.from(value).toUnsigned(size);
      Uint8List result = Uint8List(size~/8);
      Uint8List list = intToBytes(_value);
      result.setAll(size~/8 - list.length, list);

      return result;
    }
    /*var _bytesMatch = _regexBytes.allMatches(type);
    if (_bytesMatch.isNotEmpty) {
      print(_bytesMatch.toList().map((e) => e.groupNames.toList()));
      var size = int.parse(_bytesMatch.length > 1 ? _bytesMatch.elementAt(2).input : "32");
      print(_bytesMatch);
      print(_bytesMatch.length);

      if (size == 0 || size > 32) {
        throw ArgumentError("invalid bytes type");
      }
      if (value is String){
        value = hexToBytes(value);
      }
      Uint8List bytesValue = value;
      if (bytesValue.length != size) {
        throw ArgumentError("invalid value for $type");
      }
      return value;
    }*/

    if (value is Uint8List){
      return value;
    }

    if (value is String){
      return hexToBytes(value);
    }

    return Uint8List(0);
  }


}