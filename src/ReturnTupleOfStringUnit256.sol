// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfStringUnit256 {
    function main() external pure returns (string memory, uint256) {
        assembly {
            // your code here
            // return the tuple of (string and uint256): ("RareSkills", 420)

            // "RareSkills": 0x52617265536b696c6c73
            mstore(0x00, 0x40)
            mstore(0x20, 420)
            mstore(0x40, 10)
            mstore(0x60, shl(176, 0x52617265536b696c6c73))

            return(0x00, 0x80)
        }
    }
}
