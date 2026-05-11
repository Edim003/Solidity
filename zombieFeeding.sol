// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.5.0 <0.6.0;

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

    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kityyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint _zombieId, uint _targetDna. string _species) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaMod;
        newDna = (_targetDna + newDna) / 2;
        if (keccak256(abi.encodePacked(_species)) == (keccak256(abi.encodePacked("Kitty")))) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("Patrick",newDna);
    }

    function feedOnKitty(uint _zombieId, uint kittyId) public {
        uint kittygenes;
        (,,,,,,,,,kittygenes) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId,kittygenes,"Kitty");
    }
    
}