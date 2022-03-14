pragma solidity >=0.5.0 <0.6.0;

// Creating a contract
contract ZombieFactory {
    // Creating an Event
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    // Our global Variables will be here
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    // This is something like a Class, holding some properties
    struct Zombie {
        string name;
        uint256 dna;
    }

    // In here we're creating an array from that Class
    // It means anything that we push in this array should have the properties from the Class
    Zombie[] public zombies;

    // This function is private and will create our zombies
    function _createZombie(string memory _name, uint256 _dna) private {
        uint256 id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    /*
    The first line of code should take the keccak256 hash of
    abi.encodePacked(_str) to generate a pseudo-random hexadecimal,
    typecast it as a uint, and finally store the result in a uint called rand.
    We want our DNA to only be 16 digits long (remember our dnaModulus?).
    So the second line of code should return the above value modulus (%) dnaModulus.
    */
    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // Creating a Zombie
    function createRandomZombie(string memory _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
