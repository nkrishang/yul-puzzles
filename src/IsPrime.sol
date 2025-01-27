// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract IsPrime {
    function main(uint256 x) external pure returns (bool) {
        assembly {
            // your code here
            // return true if x is a prime number, else false

            if eq(x, 1) { return(0x00, 0x20) }
            if iszero(mul(mod(x, 2), mod(x, 3))) { return(0x00, 0x20) }

            let lim := div(x, 2)
            for { let i := 5 } lt(i, lim) { i := add(i, 2) } { if iszero(mod(x, i)) { return(0x00, 0x20) } }

            mstore(0x00, 0x01)
            return(0x00, 0x20)
        }
    }
}
