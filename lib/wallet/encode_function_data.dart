import 'dart:typed_data';

import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/entrypoint.dart';
import 'package:wallet_dart/contracts/erc20.dart';
import 'package:wallet_dart/contracts/factories/EIP4337Manager.g.dart';
import 'package:wallet_dart/contracts/factories/SingletonFactory.g.dart';
import 'package:wallet_dart/contracts/wallet.dart';
import 'package:wallet_dart/utils/abi_utils.dart';
import 'package:wallet_dart/wallet/message.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class EncodeFunctionData {

  static erc20Approve(EthereumAddress spender, BigInt value){
    return bytesToHex(CERC20.interface.self.function("approve").encodeCall([spender, value]), include0x: true);
  }

  static String erc20Transfer(EthereumAddress to, BigInt value){
    return bytesToHex(CERC20.interface.self.function("transfer").encodeCall([to, value]), include0x: true);
  }
  
  static executeUserOp(EthereumAddress to, BigInt value, Uint8List data){
    return bytesToHex(CWallet.interface.self.function("executeUserOp").encodeCall([
      to,
      value,
      data
    ]), include0x: true);
  }

  static multiSend(Uint8List transactions){
    return bytesToHex(CWallet.multiSendCallOnlyInterface.self.function("multiSend").encodeCall([transactions]), include0x: true);
  }

  static execTransactionFromModule(EthereumAddress to, BigInt value, Uint8List data, BigInt operation){
    return bytesToHex(CWallet.interface.self.function("execTransactionFromModule").encodeCall([
      to,
      value,
      data,
      operation
    ]), include0x: true);
  }

  static getTransactionHash(
    EthereumAddress to,
    BigInt value,
    Uint8List data,
    BigInt operation,
    BigInt safeTxGas,
    BigInt baseGas,
    BigInt gasPrice,
    EthereumAddress gasToken,
    EthereumAddress refundReceiver,
    BigInt _nonce,
    {required EthereumAddress address} // EIP4337 Manager
  ){
    Uint8List safeTxHash =
    keccak256(
        encodeAbi(
          [
            "bytes32",
            "address",
            "uint256",
            "bytes32",
            "uint8",
            "uint256",
            "uint256",
            "uint256",
            "address",
            "address",
            "uint256",
          ],
          [
            hexToBytes("0xbb8310d486368db6bd6f849402fdd73ad53d316b5a4b2644ad6efe0f941286d8"),
            to,
            value,
            keccak256(data),
            operation,
            safeTxGas,
            baseGas,
            gasPrice,
            gasToken,
            refundReceiver,
            _nonce
          ]
      )
    );
    return keccak256(Message.solidityPack(
      [
        "bytes1",
        "bytes1",
        "bytes32",
        "bytes32",
      ],
      [
        Uint8List.fromList([0x19]),
        Uint8List.fromList([0x01]),
        domainSeparator(address),
        safeTxHash
      ]
    ));
  }

  static final Uint8List DOMAIN_SEPARATOR_TYPEHASH = hexToBytes("0x47e79534a245952e8b16893a336b85a3d9ea9fa8c573f3d803afb92a79469218");

  static Uint8List domainSeparator(EthereumAddress address) {
    return keccak256(
      encodeAbi(
        ["bytes32", "uint256", "address"],
        [DOMAIN_SEPARATOR_TYPEHASH, BigInt.from(5), address]
      )
    );
  }

  static execTransaction(
      EthereumAddress to,
      BigInt value,
      Uint8List data,
      BigInt operation,
      BigInt safeTxGas,
      BigInt baseGas,
      BigInt gasPrice,
      EthereumAddress tokenAddress,
      EthereumAddress refundReceiver,
      Uint8List signature,
      {EIP4337Manager? walletInterface}
    ){
    return bytesToHex(
      (walletInterface ?? CWallet.interface).self.function("execTransaction").encodeCall([
        to,
        value,
        data,
        operation,
        safeTxGas,
        baseGas,
        gasPrice,
        tokenAddress,
        refundReceiver,
        signature
      ]),
      include0x: true
    );
  }
  
  static initialize(EthereumAddress owner, List<EthereumAddress> guardians){
    return bytesToHex(
      CWallet.interface.self.function("initialize").encodeCall([owner, guardians]),
      include0x: true
    );
  }

  static transferOwner(EthereumAddress newOwner){
    return bytesToHex(
        CWallet.interface.self.function("transferOwner").encodeCall([newOwner]),
        include0x: true
    );
  }

  static create2Deploy(Uint8List initCode, Uint8List salt){
    return bytesToHex(
        SingletonFactory(address: Constants.singletonFactoryAddress, client: Constants.web3client).self.function("deploy").encodeCall([initCode, salt]),
        include0x: true
    );
  }

  static enableModule(EthereumAddress moduleAddress){
    return bytesToHex(
        CWallet.interface.self.function("enableModule").encodeCall([moduleAddress]),
        include0x: true
    );
  }

  static setupSocialRecoveryModule(EthereumAddress guardian, BigInt threshold){
    return bytesToHex(
        CWallet.recoveryInterface(Constants.zeroAddress).self.function("setup").encodeCall([[guardian], threshold]),
        include0x: true
    );
  }

  static grantGuardian(EthereumAddress guardian, BigInt threshold){
    return bytesToHex(
      CWallet.recoveryInterface(Constants.zeroAddress).self.function("addFriendWithThreshold").encodeCall([guardian, threshold]),
      include0x: true
    );
  }

  static revokeGuardian(BigInt guardianIndex, BigInt threshold){
    return bytesToHex(
      CWallet.recoveryInterface(Constants.zeroAddress).self.function("removeFriend").encodeCall([guardianIndex, threshold]),
      include0x: true
    );
  }

  static addEntryPointStake(BigInt value){
    return bytesToHex(CWallet.interface.self.function("executeUserOp").encodeCall([
      CEntrypoint.address,
      value,
      CEntrypoint.interface.self.function("addStake").encodeCall([Constants.defaultUnlockDelaySeconds])
    ]), include0x: true);
  }

  static upgradeTo(EthereumAddress newImplementation){
    return bytesToHex(
        CWallet.interface.self.function("upgradeTo").encodeCall([newImplementation]),
        include0x: true
    );
  }
  
}