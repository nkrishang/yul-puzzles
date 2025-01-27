// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CalculatorInFallback {
    uint256 public result;

    fallback() external {
        // your code here
        // compare the function selector in the calldata with the any of the selectors below, then
        // execute a logic based on the right function selector and store the result in `result` variable.
        // assumming operations won't overflow

        // add(uint256,uint256) -> 0x771602f7 (add two numbers and store result in storage)
        // sub(uint256,uint256) -> 0xb67d77c5 (sub two numbers and store result in storage)
        // mul(uint256,uint256) -> 0xc8a4ac9c (mul two numbers and store result in storage)
        // div(uint256,uint256) -> 0xa391c15b (div two numbers and store result in storage)

        assembly {
            // Copy calldata in memory
            calldatacopy(0x1c, 0x00, 0x44)

            // Get selector
            let selector := mload(0x00)

            // Get arguments
            let x := mload(0x20)
            let y := mload(0x40)
            let ret := 0

            switch selector
            // add(uint256,uint256)
            case 0x771602f7 { ret := add(x, y) }
            // sub(uint256,uint256)
            case 0xb67d77c5 { ret := sub(x, y) }
            // mul(uint256,uint256)
            case 0xc8a4ac9c { ret := mul(x, y) }
            // div(uint256,uint256)
            case 0xa391c15b { ret := div(x, y) }
            // Revert if unexpected selector
            default { revert(0, 0) }

            sstore(result.slot, ret)
        }
    }
}
