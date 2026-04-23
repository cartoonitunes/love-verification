// Submitted by EthereumHistory (ethereumhistory.com)
contract tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData); }

contract Love { 
    string public name;
    string public symbol;
    uint8 public decimals;

    bytes32 public currentChallenge;
    uint public timeOfLastProof;
    uint public difficulty = 10**32;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint)) public allowance;
    mapping (address => mapping (address => uint)) public spentAllowance;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function Love(uint256 initialSupply, string tokenName, uint8 decimalUnits, string tokenSymbol) {
        balanceOf[msg.sender] = initialSupply;
        name = tokenName;
        symbol = tokenSymbol;
        decimals = decimalUnits;
        timeOfLastProof = now;
    }

    function proofOfWork(uint nonce){
        bytes8 n = bytes8(sha3(nonce, currentChallenge));
        if (n < bytes8(difficulty)) throw;
        uint timeSinceLastProof = (now - timeOfLastProof);
        difficulty = difficulty * 60 / timeSinceLastProof + 1;
        timeOfLastProof = now;
        currentChallenge = sha3(nonce, currentChallenge, block.blockhash(block.number));
        balanceOf[msg.sender] += timeSinceLastProof / 6;
    }

    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
    }

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        tokenRecipient spender = tokenRecipient(_spender);
        spender.receiveApproval(msg.sender, _value, this, _extraData);
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balanceOf[_from] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        if (spentAllowance[_from][msg.sender] + _value > allowance[_from][msg.sender]) throw;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        spentAllowance[_from][msg.sender] += _value;
        Transfer(msg.sender, _to, _value);
    }

    function () {
        throw;
    }
}
