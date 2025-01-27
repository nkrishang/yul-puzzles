// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract FizzBuzz {
    function main(uint256 num) external pure returns (string memory) {
        assembly {
            // your code here
            // if `num` is divisible by 3 return the word "fizz",
            // if divisible by 5 with the word "buzz",
            // if divisible by both 3 and 5 return the word "fizzbuzz",
            // else return an empty string "".

            // Assume `num` is greater than 0.

            // "fizz": 0x66697a7a
            // "buzz": 0x62757a7a
            // "fizzbuzz": 0x66697a7a62757a7a

            // Fizz
            let mod3 := iszero(mod(num, 3))
            let mod5 := iszero(mod(num, 5))

            if and(mod3, mod5) {
                mstore(0x00, 0x20)
                mstore(0x20, 8)
                mstore(0x40, shl(192, 0x66697a7a62757a7a))
                return(0x00, 0x60)
            }

            if mod3 {
                mstore(0x00, 0x20)
                mstore(0x20, 4)
                mstore(0x40, shl(224, 0x66697a7a))
                return(0x00, 0x60)
            }

            if mod5 {
                mstore(0x00, 0x20)
                mstore(0x20, 4)
                mstore(0x40, shl(224, 0x62757a7a))
                return(0x00, 0x60)
            }

            mstore(0x00, 0x20)
            return(0x00, 0x60)
        }
    }
}
