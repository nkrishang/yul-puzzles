// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract EventWithComplexData {
    // EMIT ME!!!
    event MyEvent(address indexed emitter, address[] players, uint256[] scores);

    function main(address emitter, address[] memory players, uint256[] memory scores) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,address[],uint256[])` event
            // Hint: Use `log2` to emit the event with the hash as the topic0 and `emitter` as topic1, then the data

            // Get players len.
            let playersLen := mload(players)
            // Get players offset.
            let playersOffset := 0x40

            // Store players offset.
            mstore(0x00, playersOffset)

            // Store len at offset.
            mstore(playersOffset, playersLen)

            // Get players array data loc in memory.
            let playersMemLoc := add(0x20, players)

            for { let i := 0 } lt(i, playersLen) { i := add(i, 1) } {
                // Load player.
                let playerAddr := mload(add(playersMemLoc, mul(0x20, i)))
                // Store player.
                mstore(add(0x60, mul(0x20, i)), playerAddr)
            }

            // Get scores len.
            let scoresLen := mload(scores)
            // Get scores offset.
            let scoresOffset := add(0x60, mul(0x20, playersLen))

            // Store scores offset.
            mstore(0x20, scoresOffset)
            // Store scores len at offset.
            mstore(scoresOffset, scoresLen)

            // Get loc to store player data
            let scoresLoc := add(0x20, scoresOffset)
            // Get players array data loc in memory.
            let scoresMemLoc := add(0x20, scores)

            for { let i := 0 } lt(i, scoresLen) { i := add(i, 1) } {
                let score := mload(add(scoresMemLoc, mul(0x20, i)))
                mstore(add(scoresLoc, mul(0x20, i)), score)
            }

            log2(
                0x00,
                add(scoresLoc, mul(0x20, scoresLen)),
                0x06af3d8f9866c9f54dcf425d9da9f75849af90454a25bca9df5fb24d80683e6a,
                emitter
            )
        }
    }
}
