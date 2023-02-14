// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

// 3 way to send ETH
// tranfer- 2300 gas,  revert
//send- 2300 gas, return bool
//call-- all gas, return bool and data

contract SendEther{
    constructor() payable {}
    receive() external payable{}

    function sendViaTransfer(address payable _to) external payable{
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable{
        bool sent= _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable{
      (bool success,) = _to.call{value:123}("");
      require(success, "call failed");
    }
}

contract EthReceive{
    event Log(uint amount, uint gas);
    receive() external payable{
        emit Log(msg.value, gasleft());
    }
}
