import "package:web3dart/web3dart.dart";

class AbiEncoders {

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
        {
          "components": [
            { "type": "address", "name": "sender" },
            { "type": "uint256", "name": "nonce" },
            { "type": "bytes", "name": "initCode" },
            { "type": "bytes", "name": "callData" },
            { "type": "uint256", "name": "callGasLimit" },
            { "type": "uint256", "name": "verificationGasLimit" },
            { "type": "uint256", "name": "preVerificationGas" },
            { "type": "uint256", "name": "maxFeePerGas" },
            { "type": "uint256", "name": "maxPriorityFeePerGas" },
            { "type": "address", "name": "paymasterAndData" },
            { "type": "bytes", "name": "paymasterData" },
            { "type": "bytes", "name": "signature" }
          ],
          "name": "userOp",
          "type": "tuple"
        }
      ],
      "name": "",
      "type": "function"
    }
    ]""", "");
}