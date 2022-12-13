import 'dart:typed_data';

import 'package:web3dart/web3dart.dart';
import 'package:web3dart/src/utils/length_tracking_byte_sink.dart';

Uint8List encodeAbi(List<String> types, List<dynamic> values){
  List<AbiType> abiTypes = [];
  LengthTrackingByteSink result = LengthTrackingByteSink();
  for (String type in types){
    var abiType = parseAbiType(type);
    abiTypes.add(abiType);
  }
  TupleType(abiTypes).encode(values, result);
  return result.asBytes();
}

List<dynamic> decodeAbi(List<String> types, Uint8List value){
  List<AbiType> abiTypes = [];
  for (String type in types){
    var abiType = parseAbiType(type);
    abiTypes.add(abiType);
  }
  final parsedData = TupleType(abiTypes).decode(value.buffer, 0);
  return parsedData.data;
}