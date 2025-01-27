// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract RevertWithError {
    function main() external pure {
        assembly {
            // revert the function with an error of type `Error(string)`
            // use "RevertRevert" as error message
            // Hint: The error type is a predefined four bytes. See https://www.rareskills.io/post/try-catch-solidity

            // Store selector
            mstore(0x00, 0x08c379a000000000000000000000000000000000000000000000000000000000)
            // Store offset
            mstore(0x04, 0x20)
            // Store length
            mstore(0x24, 0x0c)
            // Store string
            mstore(0x44, 0x5265766572745265766572740000000000000000000000000000000000000000)
            // Revert
            revert(0x00, 0x64)
        }
    }
}
