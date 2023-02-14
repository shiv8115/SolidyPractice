// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract PiggyBank{
    address public owner= msg.sender;

    event withdraw(uint256 amount);
    event Deposit(uint256 amount);
    receive() external payable{
        emit Deposit(msg.value);
    }
    function Withdraw() external{
        require(msg.sender== owner, "Not owner");
        emit withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}
