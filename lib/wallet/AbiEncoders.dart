import 'package:web3dart/web3dart.dart';

class AbiEncoders {
  /*static ContractAbi ownerSignMessage = ContractAbi.fromJson("""[
    {
      "inputs": [
        { "name": "1", "type": "uint8" },
        { 
          "components": [
              {
                  "name": "signer",
                  "type": "address"
              },
              {
                  "name": "signature",
                  "type": "bytes"
              }
          ],
          "name": "2",
          "type": "tuple[]"
        }
      ],
      "name": "",
      "type": "function"
    }
    ]""", "");*/

  static ContractAbi ownerSignMessage = ContractAbi.fromJson("""[
    {
      "inputs": [
        { "name": "1", "type": "uint8" },
        { 
          "components": [
              {
                  "name": "signer",
                  "type": "address"
              },
              {
                  "name": "signature",
                  "type": "bytes"
              }
          ],
          "name": "2",
          "type": "tuple[]"
        }
      ],
      "name": "",
      "type": "function"
    }
    ]""", "");

  static ContractAbi requestIdCoder = ContractAbi.fromJson("""[
    {
      "inputs": [
        { "name": "1", "type": "bytes32" },
        { "name": "2", "type": "address" },
        { "name": "3", "type": "uint" }
      ],
      "name": "",
      "type": "function"
    }
    ]""", "");
}