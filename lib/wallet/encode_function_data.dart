import 'dart:typed_data';

import 'package:wallet_dart/contracts/gnosis_safe_proxy_facotry.dart';
import 'package:wallet_dart/contracts/multi_send_call_only.dart';
import 'package:wallet_dart/contracts/erc20.dart';
import 'package:wallet_dart/contracts/factories/CandideWallet.g.dart';
import 'package:wallet_dart/contracts/factories/ERC20.g.dart';
import 'package:wallet_dart/contracts/factories/GnosisSafeProxyFactory.g.dart';
import 'package:wallet_dart/contracts/factories/MultiSendCallOnly.g.dart';
import 'package:wallet_dart/contracts/factories/SocialRecoveryModule.g.dart';
import 'package:wallet_dart/contracts/social_module.dart';
import 'package:wallet_dart/contracts/account.dart';
import 'package:wallet_dart/utils/abi_utils.dart';
import 'package:wallet_dart/wallet/message.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class EncodeFunctionData {

  static ERC20 _IERC20Interface(){
    return IERC20.interface(address: EthereumAddress(Uint8List(20)), client: Web3Client("", Client()));
  }

  static CandideWallet _IAccountInterface(){
    return IAccount.interface(address: EthereumAddress(Uint8List(20)), client: Web3Client("", Client()));
  }

  static MultiSendCallOnly _IMultiSendCallOnlyInterface(){
    return IMultiSendCallOnly.interface(address: EthereumAddress(Uint8List(20)), client: Web3Client("", Client()));
  }

  static SocialRecoveryModule _ISocialModuleInterface(){
    return ISocialModule.interface(address: EthereumAddress(Uint8List(20)), client: Web3Client("", Client()));
  }

  static GnosisSafeProxyFactory _IGnosisProxyFactoryInterface(){
    return IGnosisSafeProxyFactory.interface(address: EthereumAddress(Uint8List(20)), client: Web3Client("", Client()));
  }

  static String erc20Approve(EthereumAddress spender, BigInt value){
    return bytesToHex(_IERC20Interface().self.function("approve").encodeCall([spender, value]), include0x: true);
  }

  static String erc20Transfer(EthereumAddress to, BigInt value){
    return bytesToHex(_IERC20Interface().self.function("transfer").encodeCall([to, value]), include0x: true);
  }

  static String multiSend(Uint8List transactions){
    return bytesToHex(_IMultiSendCallOnlyInterface().self.function("multiSend").encodeCall([transactions]), include0x: true);
  }

  static String execTransactionFromModule(EthereumAddress to, BigInt value, Uint8List data, BigInt operation){
    return bytesToHex(_IAccountInterface().self.function("execTransactionFromModule").encodeCall([
      to,
      value,
      data,
      operation
    ]), include0x: true);
  }

  static String execTransactionFromEntrypoint(
      EthereumAddress to,
      BigInt value,
      Uint8List data,
      BigInt operation,
      EthereumAddress paymaster,
      EthereumAddress approveToken,
      BigInt approveAmount
    ){
    return bytesToHex(_IAccountInterface().self.function("execTransactionFromEntrypoint").encodeCall([
      to,
      value,
      data,
      operation,
      paymaster,
      approveToken,
      approveAmount
    ]), include0x: true);
  }

  static String setupWithEntrypoint(
    List<EthereumAddress> owners,
    BigInt threshold,
    EthereumAddress to,
    Uint8List data,
    EthereumAddress fallbackHandler,
    EthereumAddress paymentToken,
    BigInt payment,
    EthereumAddress paymentReceiver,
    EthereumAddress entryPoint
  ){
    return bytesToHex(_IAccountInterface().self.function("setupWithEntrypoint").encodeCall([
      owners,
      threshold,
      to,
      data,
      fallbackHandler,
      paymentToken,
      payment,
      paymentReceiver,
      entryPoint,
    ]), include0x: true);
  }

  static Uint8List getTransactionHash(
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

  static String execTransaction(
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
    ){
    return bytesToHex(
      _IAccountInterface().self.function("execTransaction").encodeCall([
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


  static String createProxyWithNonce(EthereumAddress singleton, Uint8List initializer, BigInt salt){
    return bytesToHex(
      _IGnosisProxyFactoryInterface().self.function("createProxyWithNonce").encodeCall([singleton, initializer, salt]),
      include0x: true
    );
  }

  static String enableModule(EthereumAddress moduleAddress){
    return bytesToHex(
      _IAccountInterface().self.function("enableModule").encodeCall([moduleAddress]),
      include0x: true
    );
  }

  static String disableModule(EthereumAddress prevModule, EthereumAddress moduleAddress){
    return bytesToHex(
      _IAccountInterface().self.function("disableModule").encodeCall([prevModule, moduleAddress]),
      include0x: true
    );
  }

  static grantGuardian(EthereumAddress account, EthereumAddress guardian, BigInt threshold){
    return bytesToHex(
      _ISocialModuleInterface().self.function("addGuardianWithThreshold").encodeCall([account, guardian, threshold]),
      include0x: true
    );
  }

  static revokeGuardian(EthereumAddress account, EthereumAddress prevGuardian, EthereumAddress guardian, BigInt threshold){
    return bytesToHex(
      _ISocialModuleInterface().self.function("revokeGuardianWithThreshold").encodeCall([account, prevGuardian, guardian, threshold]),
      include0x: true
    );
  }
  
}