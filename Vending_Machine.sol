//SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract VendingMachine {
    address public owner;
    mapping (address => uint ) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }
    //view function doesnt modify any data but just reads data from the blockchain 
    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }
    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock this machine");
        donutBalances[address(this)] += amount;
    }
    //payable keyword is used for any function which needs to receive ether 
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ether per donut");
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to fulfill purchase request");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }
}
