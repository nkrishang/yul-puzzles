// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPackedDynamicArray64 {
    uint64[] public writeHere;

    function main(uint64 v1, uint64 v2, uint64 v3, uint64 v4, uint64 v5) external {
        assembly {
            // your code here
            // write the code to store v1, v2, v3, v4, and v5 in the `writeHere` array in sequential order.
            // Hint: `writeHere` is a dynamic array, so you will need to access its length and use `mstore` or `sstore`
            // appropriately to push new values into the array.

            // Get current array length
            let len := sload(writeHere.slot)

            // Get array slot
            mstore(0x00, writeHere.slot)
            let slot := keccak256(0x00, 0x20)

            // Get slot to start storing values
            let startSlot := add(slot, div(len, 4))

            // Store leftover
            let leftover := mod(len, 4)

            switch leftover
            // Start from an empty slot
            case 0 {
                // Store: [v4, v3, v2, v1]
                let val := shl(192, v4)
                val := or(val, shl(128, v3))
                val := or(val, shl(64, v2))
                val := or(val, v1)
                sstore(startSlot, val)

                // Store: [_, _, _, v5]
                sstore(add(startSlot, 0x20), v5)
            }
            // Start from an a slot with 1 elem to pack
            case 1 {
                // Store: [v1, x, x, x]
                let val := sload(startSlot)
                sstore(startSlot, or(val, shl(192, v1)))

                startSlot := add(startSlot, 0x20)

                // Store: [v5, v4, v3, v2]
                val := shl(192, v5)
                val := or(val, shl(128, v4))
                val := or(val, shl(64, v3))
                val := or(val, v2)
                sstore(startSlot, val)
            }
            // Start from an a slot with 2 elem to pack
            case 2 {
                // Store: [v2, v1, x, x]
                let val := sload(startSlot)
                val := or(val, shl(128, v1))
                val := or(val, shl(192, v2))
                sstore(startSlot, val)

                startSlot := add(startSlot, 0x20)

                // Store: [_, v5, v4, v3]
                val := shl(128, v5)
                val := or(val, shl(64, v4))
                val := or(val, v3)
                sstore(startSlot, val)
            }
            // Start from an a slot with 3 elem to pack
            case 3 {
                // Store: [v3, v2, v1, x]
                let val := sload(startSlot)
                val := or(val, shl(64, v1))
                val := or(val, shl(128, v2))
                val := or(val, shl(192, v3))
                sstore(startSlot, val)

                // Store: [_, _, v5, v4]
                val := shl(64, v5)
                val := or(val, v4)
                sstore(startSlot, val)
            }
            default { revert(0, 0) }

            // Store new length
            sstore(writeHere.slot, add(len, 5))
        }
    }
}
