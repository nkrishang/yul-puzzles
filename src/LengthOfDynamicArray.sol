// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract LengthOfDynamicArray {
    function main(uint256[] memory x) external view returns (uint256) {
        assembly {
            // your code here
            // return the length of array `x`
            // Hint: https://www.rareskills.io/post/solidity-dynamic

            // Copy array length in memory
            // selector[0:4) || offset[4:36) || length[36:68) || array[68:68+length)
            calldatacopy(0x00, 0x24, 0x20)

            // Return length
            return(0x00, 0x20)
        }
    }
}
