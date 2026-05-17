// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

import "./ZombieFactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieWorld {

    KittyInterface kittyContract;

    modifier OnlyOwnerOf(uint _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        _;
    }

    function setKittyContract(address _address) external {
        kittyContract = KittyInterface(_address);
    }

    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint(block.timestamp + cooldownTime);
    }

    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= block.timestamp);
    }

    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) internal ownerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie));
        _targetDna = _targetDna % dnaMod;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        if (keccak256(abi.encodePacked(_species)) == (keccak256(abi.encodePacked("Kitty")))) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("Patrick",newDna);
        _triggerCooldown(myZombie);
    }

    function feedOnKitty(uint _zombieId, uint kittyId) public {
        uint kittygenes;
        (,,,,,,,,,kittygenes) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId,kittygenes,"Kitty");
    }

}