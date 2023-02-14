// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract A {
    address payable public a;
    address payable public b;
    address payable public c;
    address payable public d;

    // Initialize contract addresses
    constructor(address payable _b, address payable _c, address payable _d) {
        b = _b;
        c = _c;
        d = _d;
        a = payable(msg.sender);
    }

    // Allow contract to receive ethers
    function deposit() external payable {}

    // Send ethers from contract A to contract B and forward to contract C
    function sendToB() external payable {

        // Contract A forward ethers to contract B
        (bool ok, ) = b.call{value: msg.value}("");
        require(ok, "Failed to send Ether from A to B");

        // Contract B forward ethers to C
        (bool sent, ) = b.call(abi.encodeWithSignature("forwardToC()"));
        require(sent, "Failed to send Ether");
    }

    // Send ethers from contract A to contract D but Contract D rejects the transaction.
    function sendAtoD() external payable {
        (bool sent, ) = d.call{value: msg.value}(abi.encodeWithSignature("reject()"));
        require(sent, "D rejects to accept ethers");
    }

    // Get the balance of contract A
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}

contract B {
    address payable public c;

    // Initialize contract address
    constructor(address payable _c) {
        c = _c;
    }

    // Allow contract to receive ethers
    receive() external payable {}

    // Get the balance of contract B
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

    // Forward ethers to contract C
    function forwardToC() external payable {
        (bool ok, ) = c.call{value: address(this).balance}("");
        require(ok, "Failed to send Ether from B to C");
    }
}

contract C {
    // Allow contract to receive ethers
    receive() external payable {}

    // Get the balance of contract C
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}

contract D {
    // Allow contract to receive ethers
    receive() external payable {}

    // Reject transaction
    function reject() external pure {
        revert("Transaction rejected");
    }
}
