pragma solidity >=0.4.23 <0.6.0;

contract KrazyKewlSlotsToken{
    
    string public name;
    string public symbol;
    uint8 public decimals = 8;
    uint256 public totalSupply;
    
    mapping(address => uint256)public balanceOf;
    mapping(address => mapping(address =>uint256))public allowance;
    
     event Transfer(address indexed from,address indexed to, uint256 value);
    event Approval(address indexed _owner,address indexed _spender,uint256 value);
    event Burn(address indexed from,uint256 value);
    event SlotResult(uint256 value);
    
    uint256 public player_count;
    uint256 player_amount;
    uint256 player_slotresult;
    address player_address;
    
    uint256 initialSupply = 2000000;
    string tokenName = 'KrazyKewlSlotsToken';
    string tokenSymbol= 'KKST';
    address owner;
    
    
    
    
    constructor()public{
        totalSupply=initialSupply*10**uint256(decimals);
        balanceOf[msg.sender]=totalSupply;
        name=tokenName;
        symbol=tokenSymbol;
        
        owner = msg.sender;
    }
    
    function _transfer(address _from,address _to,uint _value)internal{
        
        require(_to != 0x0);
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        
         uint previousBalances=balanceOf[_from] + balanceOf[_to];
         
         balanceOf[_from] -= _value;
         balanceOf[_to] += _value;
         emit Transfer(_from,_to,_value);
         
         assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
         
        
    }
    
    function transfer(address _to,uint256 _value)public returns(bool success){
        _transfer(msg.sender, _to,_value);
        return true;
    }
    
     function transferFrom(address _from,address _to,uint256 _value)public returns(bool success){
        require(_value <= allowance[_from][msg.sender]);
        
        _transfer(_from,_to,_value);
        return true;
    }
    function approve(address _spender,uint256 _value)public returns(bool success){
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        
        return true;
    }
    
     function burn(uint256 _value)public returns(bool success){
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        emit Burn(msg.sender,_value);
        return true;
    }
    
    function didBet(uint256 _value,uint256 _slotresult)public returns(bool success){
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[owner] += _value;
        
        player_count +=1;
        
        if(player_count == 1){
            player_diceresult = _diceresult;
            player_amount = _value;
            player_address = msg.sender;
            emit SlotResult(999);
        }
        if(player_count == 2){
            if(player_diceresult == _slotresult){
                balanceOf[player_address] += player_amount;
                balanceOf[msg.sender] += _value;
                balanceOf[owner] -= player_amount;
                balanceOf[owner] -= _value;
                emit SlotResult(0);//Draw
                
            }
            
            if(player_slotresult > _slotresult){
                balanceOf[player_address] += player_amount;
                balanceOf[player_address] += _value;
                balanceOf[owner] -= player_amount;
                balanceOf[owner] -= _value;
                emit SlotResult(1);//player1 wins
                
            }
            
            if(player_slotresult < _slotresult){
                balanceOf[msg.sender] += player_amount;
                balanceOf[msg.sender] += _value;
                balanceOf[owner] -= player_amount;
                balanceOf[owner] -= _value;
                emit SlotResult(2);//player2 wins
                
            }
            player_amount = 0;
            player_count = 0;
            player_slotresult = 0;
            player_address = 0x0;
        }
        return true;
        
    }
    
}
