// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithSelectorPlusArgs {
    error RevertData(uint256); // selector: 0xae412287

    function main(uint256 x) external pure {
        assembly {
            // your code here
            // revert custom error with x parameter
            // Hint: concatenate selector and x by storing them
            // adjacent to each other in memory

            // Store 4 byte selector: 28:32
            mstore(0x00, 0xae412287)
            // Copy `x` from calldata at 32:64
            mstore(0x20, x)
            // Revert 28:64
            revert(0x1c, 0x24)
        }
    }
}
