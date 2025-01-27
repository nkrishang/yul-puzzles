// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract AnonymonusEventWithComplexData {
    enum Gender {
        Male,
        Female,
        Trans
    }

    struct Person {
        string name;
        uint256 age;
        Gender gender;
    }

    // EMIT ME!!!
    event MyEvent(address indexed emitter, bytes32 indexed id, Person person);

    function main(address emitter, bytes32 id, Person memory person) external {
        assembly {
            // your code here
            // emit the `MyEvent(address,bytes32,(string,uint256,uint8))` event.
            // Anonymous events don't have the event signature (topic0) included.
            // Hint: how the `Person` struct is encoded in mem:
            //          - string offset
            //          - string length offset
            //          - age
            //          - gender
            //          - name length
            //          - name

            let nameOffset := mload(person)
            let nameLenOffset := mload(add(nameOffset, person))
            let nameLen := mload(add(nameOffset, nameLenOffset))

            mstore(0x00, 0x20)
            mstore(0x20, 0x60)
            mstore(0x40, mload(add(0x20, person)))
            mstore(0x60, mload(add(0x40, person)))
            mstore(0x80, nameLen)
            mstore(0xa0, mload(add(add(nameOffset, nameLenOffset), 0x20)))

            log3(0x00, 0xc0, 0x00, emitter, id)
        }
    }
}
