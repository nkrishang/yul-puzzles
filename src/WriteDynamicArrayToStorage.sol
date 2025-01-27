// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere`

            // Load array length
            calldatacopy(0x00, 0x24, 0x20)
            // Store array length
            let len := mload(0x00)
            sstore(writeHere.slot, len)

            // Get array storage slot
            mstore(0x00, writeHere.slot)
            let slot := keccak256(0x00, 0x20)

            // Copy array elements
            calldatacopy(0x00, 0x44, mul(len, 0x20))

            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                // Load elem
                let elem := mload(mul(i, 0x20))

                // Store elem
                sstore(add(slot, i), elem)
            }
        }
    }
}
