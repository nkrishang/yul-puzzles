// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteTwoDynamicArraysToStorage {
    uint256[] public writeHere1;
    uint256[] public writeHere2;

    function len1() external view returns (uint256) {
        return writeHere1.length;
    }

    function len2() external view returns (uint256) {
        return writeHere2.length;
    }

    function main(uint256[] calldata x, uint256[] calldata y) external {
        assembly {
            // your code here
            // write the dynamic calldata array `x` to storage variable `writeHere1` and
            // dynamic calldata array `y` to storage variable `writeHere2`

            // Get offsets
            calldatacopy(0x00, 0x04, 0x40)
            let offsetx := add(0x04, mload(0x00))
            let offsety := add(0x04, mload(0x20))

            // Load lengths
            calldatacopy(0x00, offsetx, 0x20)
            let lenx := mload(0x00)

            calldatacopy(0x00, offsety, 0x20)
            let leny := mload(0x00)

            // Store array lengths
            sstore(writeHere1.slot, lenx)
            sstore(writeHere2.slot, leny)

            // Get array storage slots
            mstore(0x00, writeHere1.slot)
            let slotx := keccak256(0x00, 0x20)

            mstore(0x00, writeHere2.slot)
            let sloty := keccak256(0x00, 0x20)

            // Copy array x elements
            calldatacopy(0x00, add(offsetx, 0x20), mul(lenx, 0x20))

            for { let i := 0 } lt(i, lenx) { i := add(i, 1) } {
                // Load elem
                let elem := mload(mul(i, 0x20))

                // Store elem
                sstore(add(slotx, i), elem)
            }

            // Copy array y elements
            calldatacopy(0x00, add(offsety, 0x20), mul(leny, 0x20))

            for { let i := 0 } lt(i, leny) { i := add(i, 1) } {
                // Load elem
                let elem := mload(mul(i, 0x20))

                // Store elem
                sstore(add(sloty, i), elem)
            }
        }
    }
}
