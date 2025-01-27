// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract keccakX {
    function main(uint256 x) external pure returns (bytes32) {
        assembly {
            // your code here
            // return the keccak hash of x
            // Hint: use keccak256(offset, size)
            // Hint: you need to put x in memory first

            // Store x in memory
            calldatacopy(0x00, 0x04, 0x20)
            // Store hash(x) in memory
            mstore(0x00, keccak256(0x00, 0x020))
            // Return hash(x)
            return(0x00, 0x20)
        }
    }
}
