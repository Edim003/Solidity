// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >= 0.5.0 < 0.6.0;

import "./zombieFeeding.sol";

contract ZombieHelper is ZombieFeeding {

    modifier aboveLevel (uint _level, uint _zombieId) view internal returns (bool) {
        return zombies[_zombieId].level > _level;
        _;
    }

    function changeName (uint _zombieId, string memory _newname) external aboveLevel(2, _zombieId) {
        require(msg.sender == ZombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    function changeDna (uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(msg.sender == ZombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    function getZombieByOwner(address _owner) external view returns (uint[] memory) {
        uint[] memory result = new uint[](userZombieCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < zombies.length; i++) {
            if (ZombieToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}