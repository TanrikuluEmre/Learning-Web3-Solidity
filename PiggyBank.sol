// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
 
contract PiggyBank{
    
    address public owner = msg.sender;
    
    event deposit(uint amount);
    event withdraw(uint amount);

    receive() external payable {
        emit deposit(msg.value);
    }
    modifier onlyOwner(){
        require(owner==msg.sender,"not owner");
        _;
    }
    function contractBalance() external view returns(uint){

        return address(this).balance;
    }
    

    function withDraw() external  onlyOwner{

        emit withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
    
    }