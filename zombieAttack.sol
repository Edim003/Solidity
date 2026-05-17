pragma solidity ^0.8.28;

import "./zombieHelper.sol";

contract ZombieAttack is ZombieHelper {
    /*@title Zombie Attack
     *@author New User
     *@notice This contract allows zombies to attack other zombies and kitties. Winning an attack increases the zombie's level and win count, while losing increases the loss count. The attack outcome is determined by a random number generator, with a victory probability of 70%. After an attack, the attacking zombie goes into a cooldown period before it can attack again.  
     *@dev The attack function uses a pseudo-random number generator based on block timestamp, sender address, and a nonce. This is not secure for production use and should be replaced with a more secure randomness source in a real application.    
    */

     uint randNonce = 0;
     uint attackVictoryProbability = 70;

     function randMod(uint _modulus) internal returns (uint) {
        randNonce++;
        return (uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) _modulus);
     }

     function attack(uint _zombieId, uint _targetDna) external OnlyOwnerOf(_zombieId) {
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