pragma solidity >=0.5.0 <0.6.0

contract ZombieFactory {

    event ZombieCreated(uint zombieId, string name, uint dna);

    uint zombieDna = 16;
    uint dnaMod = 10 ** zombieDna;


    struct Zombie{
        string name;
        uint dna;
    } 
    
    Zombie[] public zombies;

    mapping (uint => address) public ZombieToOwner;
    mapping (address => uint) userZombieCount;

    function _createZombie(string memory _name,uint _dna) internal {
        ZombieToOwner[id] = msg.sender;
        userZombieCount[msg.sender]++;
        uint id = zombies.push(Zombie(_name,_dna)) - 1;
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