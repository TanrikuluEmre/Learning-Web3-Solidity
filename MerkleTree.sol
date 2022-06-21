// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/*
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 , 0x5931b4ed56ace4c46b68524cb5bcbf4195f1bbaacbe5228fbd090546c88dd229
0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 , 0x999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb
0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db , 0x04a10bfd00977f54cc3450c9b25c9b3a502a089eba0097ba35fc33c4ea5fcb54
0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB , 0xdfbe3e504ac4e35541bebad4d0e7574668e16fefa26cd4172f93e18b59ce9486
0x617F2E2fD72FD9D5503197092aC168c91465E7f2 , 0xf6d82c545c22b72034803633d3dda2b28e89fb704f3c111355ac43e10612aedc
0x17F6AD8Ef982297579C203069C1DbfFE4348c372 , 0xc23d89d4ba0f8b56a459710de4b44820d73e93736cfc0667f35cdd5142b70f0d
0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678 , 0x1c22adb6b75b7a618594eacef369bc4f0ec06380e8630fd7580f9bf0ea413ca8
0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7 , 0xbb9f0f05f155b5df3bbdd079fa47bedd6da0e32966c72f92264d98e80248858e
0-1 - 0x9d997719c0a5b5f6db9b8ac69a988be57cf324cb9fffd51dc2c37544bb520d65
2-3 - 0x4726e4102af77216b09ccd94f40daa10531c87c4d60bba7f3b3faf5ff9f19b3c
0,1 - 2,3 - 0xad244e5bd3fb328e827d41c235daf10d4022beee814f707874034bc00dd1c448
4-5 - 0x03feca1f6d34efc6b067b22571e52b426876788ec566341008f23c3f6ae64b7d
6-7 - 0xeff686dda3c1034cbd62ed93a5b51b88d232822bbd71ad4fd83919fd9238b1a6
4,5 - 6,7 - 0xf35c6de158e2b37138040d7d60ac352e06fd4c99c96a1f0f8a3675a551880bdb

*/

contract MerkleProof {
    function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf,
        uint index
    ) public pure returns (bool) {
        bytes32 hash = leaf;

        for (uint i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }

            index = index / 2;
        }

        return hash == root;
    }
}

contract TestMerkleProof is MerkleProof {
    bytes32[] public hashes;

    constructor() {
        address[8] memory transactions = [
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,
        0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,
        0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,
        0x617F2E2fD72FD9D5503197092aC168c91465E7f2,
        0x17F6AD8Ef982297579C203069C1DbfFE4348c372,
        0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678,
        0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7
        ];

        for (uint i = 0; i < transactions.length; i++) {
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }

        uint n = transactions.length;
        uint offset = 0;

        while (n > 0) {
            for (uint i = 0; i < n - 1; i += 2) {
                hashes.push(
                    keccak256(
                        abi.encodePacked(hashes[offset + i], hashes[offset + i + 1])
                    )
                );
            }
            offset += n;
            n = n / 2;
        }
    }

    function getRoot() public view returns (bytes32) {
        return hashes[hashes.length - 1];
    }

    function getHash(address x) external pure returns(bytes32){
        return keccak256(abi.encodePacked(x));
    }

    function getHashByte(bytes32 x,bytes32 y) external pure returns(bytes32){
        return keccak256(abi.encodePacked(x,y));
    }
}

