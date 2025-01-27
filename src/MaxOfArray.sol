// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            // Layout: selector[0:4) || offset[4:36) || length[36:68) || array[68:68+length)

            // Copy array length in memory
            calldatacopy(0x00, 0x24, 0x20)
            // Load length
            let len := mload(0x00)

            if iszero(len) { revert(0x00, 0x00) }

            // Loop to calculate sum
            let offset := 0x44
            let end := add(offset, mul(len, 0x20))
            let max := 0

            for {} lt(offset, end) { offset := add(offset, 0x20) } {
                // Copy array element
                calldatacopy(0x00, offset, 0x20)
                let elem := mload(0x00)

                // Store it if elem > max
                if gt(elem, max) { max := elem }
            }

            mstore(0x00, max)
            return(0x00, 0x20)
        }
    }
}
