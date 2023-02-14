// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract TestContract{
    uint public x;
    uint public value=123;
    function setX(uint _x) external{
        x=_x;
    }
    function getX() external view returns(uint){
        return x;
    }
}

contract TestCall{
    function setValue(address _test, uint _x) external{
        TestContract(_test).setX(_x); //	54872 gas
    }

    function setValue1(TestContract _test, uint _x) external{
        _test.setX(_x); // 35281 gas
    }

}
