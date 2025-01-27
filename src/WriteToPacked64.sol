// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPacked64 {
    uint64 public someValue1 = 7;
    uint64 public writeHere = 1;
    uint64 public someValue2 = 7;
    uint64 public someValue3 = 7;

    function main(uint256 v) external {
        assembly {
            // your code here
            // change the value of `writeHere` storage variable to `v`
            // be careful not to alter the value of `someValue` variable

            let mask := 0xffffffffffffffffffffffffffffffff0000000000000000ffffffffffffffff
            let temp := and(sload(0), mask)

            sstore(0, or(temp, shl(0x40, v)))
        }
    }
}
