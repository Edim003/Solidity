pragma solidity ^0.8.28;

contract ZombieFactory {

    event ZombieCreated(uint zombieId, string name, uint dna);

    uint zombieDna = 16;
    uint dnaMod = 10 ** zombieDna; 
    uint cooldownTime = 1 days;


    struct Zombie{
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    } 
    
    Zombie[] public zombies;

    mapping (uint => address) public ZombieToOwner;
    mapping (address => uint) userZombieCount;

    function _createZombie(string memory _name,uint _dna) internal {
        zombies.push(Zombie(_name,_dna,1,uint32(now + cooldownTime), 0, 0));
        uint id = zombies.length - 1;
        zombieToOwner[id] = msg.sender;
        userZombieCount[msg.sender]++;
        emit ZombieCreated(id, _name, _dna);
    }

    function _genRandomNo(string memory _str) private returns(uint){
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaMod;
    }

    function _createRandomZombie(string memory _name) public {
        require(userZombieCount[msg.sender] == 0);
        uint randDna = _genRandomNo(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    } 
        
}