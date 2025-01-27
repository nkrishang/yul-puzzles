// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PopFromDynamicArray {
    uint256[] popFromMe = [23, 4, 19, 3, 44, 88];

    function main() external {
        assembly {
            // your code here
            // pop the last element from the dynamic array `popFromMe`
            // dont forget to clean the popped element's slot.
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            // Get new array length
            let newLen := sub(sload(popFromMe.slot), 1)

            // Store new length
            sstore(popFromMe.slot, newLen)

            // Get array storage slot
            mstore(0x00, popFromMe.slot)
            let slot := keccak256(0x00, 0x20)

            // Clean last slot
            sstore(add(slot, newLen), 0x00)
        }
    }

    function getter() external view returns (uint256[] memory) {
        return popFromMe;
    }

    function lastElementSlotValue(bytes32 s) external view returns (uint256 r) {
        assembly {
            r := sload(s)
        }
    }
}
