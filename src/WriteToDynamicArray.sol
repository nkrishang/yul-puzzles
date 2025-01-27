// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            // your code here
            // store the values in the DYNAMIC array `x` in the storage variable `writeHere`
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            // Load and store length
            let len := mload(x)
            sstore(writeHere.slot, len)

            // Get memory pointer to array elements
            let dataPtr := add(x, 0x20)

            // Get storage slot for writing the array
            mstore(0x00, writeHere.slot)
            let slot := keccak256(0x00, 0x20)

            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                // Load elem
                let elem := mload(add(dataPtr, mul(i, 0x20)))
                // Store elem
                sstore(add(slot, i), elem)
            }
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
