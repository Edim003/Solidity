pragma solidity ^0.8.28;

import "./zombieHelper.sol";

conntract ZombieAttack is ZombieHelper {

     uint randNonce = 0;
     uint attackVictoryProbability = 70;

     function randMod(uint _modulus) internal returns (uint) {
        randNonce++;
        return (uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) _modulus);
     }

     function attack(uint _zombieId, uint _targetDna) external ownerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_zombieId];
        uint rand = randMod(100);
        if (rand <= attackVictoryprobability) {
            myZombies.winCount++;
            myZombie.level++
            enemyZombies.lossCount++;
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        } else {
            myZombie.lossCount++;
            enemyZombie.winCount++;
            _triggerCooldown(myZombie);
        }
     }
}