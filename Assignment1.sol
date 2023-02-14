// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Assignemnt1 {

    string public x;

    //it contain address of account which is first update the string x.
    address public setOwner;

    function update(string calldata _str) external {
       
       // Checks if "setOwner" is not set yet (i.e., equals the zero address)
        if (setOwner == 0x0000000000000000000000000000000000000000) {
            x = _str;

            // Sets "setOwner" to the address of the caller of the function (i.e., the contract deployer)
            setOwner = msg.sender;
        } 

        // if string x is already set then only address who update value first time able to update the string x.
        else {
            require(setOwner == msg.sender, "You are not eligible");
            x = _str;
        }
    }
}
