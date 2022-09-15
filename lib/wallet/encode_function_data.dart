import 'dart:typed_data';

import 'package:wallet_dart/constants/constants.dart';
import 'package:wallet_dart/contracts/entrypoint.dart';
import 'package:wallet_dart/contracts/erc20.dart';
import 'package:wallet_dart/contracts/wallet.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class EncodeFunctionData {
  static erc20Approve(EthereumAddress tokenAddress, EthereumAddress spender, BigInt value){
    return bytesToHex(CWallet.interface.self.function("executeUserOp").encodeCall([
      tokenAddress,
      BigInt.zero,
      CERC20.interface.self.function("approve").encodeCall([spender, value])
    ]), include0x: true);
  }

  static erc20Transfer(EthereumAddress tokenAddress, EthereumAddress to, BigInt value){
    return bytesToHex(CWallet.interface.self.function("executeUserOp").encodeCall([
      tokenAddress,
      BigInt.zero,
      CERC20.interface.self.function("transfer").encodeCall([to, value])
    ]), include0x: true);
  }
  
  static executeUserOp(EthereumAddress to, BigInt value, Uint8List data){
    return bytesToHex(CWallet.interface.self.function("executeUserOp").encodeCall([
      to,
      value,
      data
    ]), include0x: true);
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

  static grantGuardian(EthereumAddress guardian){
    return bytesToHex(
        CWallet.interface.self.function("grantGuardian").encodeCall([guardian]),
        include0x: true
    );
  }

  static revokeGuardian(EthereumAddress guardian){
    return bytesToHex(
        CWallet.interface.self.function("revokeGuardian").encodeCall([guardian]),
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