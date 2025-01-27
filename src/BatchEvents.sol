// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract BatchEvents {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, uint256 num);

    function main(address[] memory emitters, bytes32[] memory ids, uint256[] memory nums) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,uint256)` event
            // Assuming all arrays (emitters, ids, and nums) are of equal length.
            // iterate over the set of parameters and emit events based on the array length.

            // Get len: we assume all arrays are of equal length.
            let len := mload(emitters)

            // Store offsets
            let dist := mul(0x20, len)

            let emmittersOffset := 0x60
            let emmittersMemLoc := add(0x20, emitters)

            let idsOffset := add(add(0x20, emmittersOffset), dist)
            let idsMemLoc := add(0x20, ids)

            let numsOffset := add(add(0x20, idsOffset), dist)
            let numsMemLoc := add(0x20, nums)

            for { let i := 0 } lt(i, len) { i := add(i, 1) } {
                let emmitter := mload(add(emmittersMemLoc, mul(0x20, i)))
                let id := mload(add(idsMemLoc, mul(0x20, i)))
                let num := mload(add(numsMemLoc, mul(0x20, i)))

                mstore(0x00, num)

                log3(0x00, 0x20, 0x044d482819499c9d5fde1245ce63873b1259fc52fc78651ccdcdf7392637d374, emmitter, id)
            }
        }
    }
}
