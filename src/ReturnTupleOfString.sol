// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfString {
    function main() external pure returns (string memory, string memory) {
        assembly {
            // your code here
            // return the tuple of string: ("Hello", "RareSkills")

            // "Hello": 0x48656c6c6f
            // "RareSkills": 0x52617265536b696c6c73

            mstore(0x00, 0x40)
            mstore(0x20, 0x80)

            mstore(0x40, 5)
            mstore(0x60, shl(216, 0x48656c6c6f))

            mstore(0x80, 10)
            mstore(0xa0, shl(176, 0x52617265536b696c6c73))

            return(0x00, 0xc0)
        }
    }
}
