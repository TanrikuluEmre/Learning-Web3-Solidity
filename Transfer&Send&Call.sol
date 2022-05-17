// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract EtherWallet{

    address payable public owner;
    constructor(){
        owner = payable(msg.sender);
    }
    receive() external payable{}

    function withDraw(uint _amount) external {
        require(msg.sender==owner,"you are not the owner");
        payable(msg.sender).transfer(_amount);
    }
    function getBalance() external view returns(uint){

        return address(this).balance;
    }
}

contract SendEther{
    
    constructor() payable{}

    receive() external payable{}

    function sendViaTransfer(address payable _to) external payable{

        _to.transfer(321);
    }
    function sendViaSend(address payable _to) external payable{

        bool sent = _to.send(321);
        require(sent,"send is failed");
    }
    function sendViaCall(address payable _to) external payable{

        (bool success, ) = _to.call{value : 321}("");
        require(success,"call is failed");
    }
  
}
contract EthReceiver{

    event log(uint amount, uint gas);

    receive() external payable {
        emit log(msg.value,gasleft());
    }


}

