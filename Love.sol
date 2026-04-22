// Submitted by EthereumHistory (ethereumhistory.com)
// Source reconstructed from bytecode analysis. All 13 function selectors verified.
// Exact compiler binary unavailable (pre-soljson era; EXP-based selector dispatch).
// Deployed: March 8, 2016 (block 1,117,697)
// Contract: 0x45601D0497419Ec993552EF425927F08f73CE032

pragma solidity ^0.3.0;

contract tokenRecipient {
    function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData);
}

contract Love {
    string public name;                                      // slot 0
    string public symbol;                                    // slot 1
    uint8 public decimals;                                   // slot 2
    uint256 public currentChallenge;                         // slot 3
    uint256 public timeOfLastProof;                          // slot 4
    uint256 public difficulty;                               // slot 5
    mapping(address => uint256) public balanceOf;            // slot 6
    mapping(address => mapping(address => uint256)) public allowance;       // slot 7
    mapping(address => mapping(address => uint256)) public spentAllowance;  // slot 8

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    function Love(string _name, string _symbol) {
        balanceOf[msg.sender] = 0;
        name = _name;
        symbol = _symbol;
        decimals = 0;
        timeOfLastProof = now;
        difficulty = 10**32;
    }

    function proofOfWork(uint256 nonce) {
        bytes32 n = sha3(nonce, currentChallenge);
        if (uint64(uint256(n) / 2**192) < uint64(difficulty)) throw;

        uint256 timeSinceLastProof = now - timeOfLastProof;
        difficulty = difficulty * 60 / timeSinceLastProof + 1;
        timeOfLastProof = now;
        currentChallenge = uint256(sha3(nonce, currentChallenge, block.blockhash(block.number)));
        balanceOf[msg.sender] += timeSinceLastProof / 6;
    }

    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balanceOf[_from] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        if (spentAllowance[_from][msg.sender] + _value > allowance[_from][msg.sender]) throw;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        spentAllowance[_from][msg.sender] += _value;
        Transfer(_from, _to, _value);
        return true;
    }

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        tokenRecipient(_spender).receiveApproval(msg.sender, _value, this, _extraData);
        return true;
    }
}
