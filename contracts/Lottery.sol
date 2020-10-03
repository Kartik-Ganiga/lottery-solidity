//pragma solidity  ^0.5.2;
pragma solidity >=0.4.22 <0.6.0;
contract Lottery{
    address  public manager;
    address [] public players;
   // address [] public players;
    //mapping(uint256 => address payable) players;

    constructor  () public {
        manager=msg.sender;
    }

    function enter() public payable{
        require(msg.value >0.01 ether);
        players.push(msg.sender); 
    }



    function random() public view returns(uint ){
       return uint(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }

    function pickWinner() public restricted  {
        require(msg.sender == manager);
        uint index= random() % players.length;
       // players[index].transfer(address(this).balance);
        players[index].transfer(address(this).balance);
        players=new address [](0);
        //players.length=0;
    }

    modifier restricted(){
        require(msg.sender==manager);
        _;
    }

     function getPlayers() public view returns(address [] memory){

         return players;
     }


}
