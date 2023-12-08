// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleEscrow {
    address public alice;
    address payable public bob;
    uint public releaseTime;
    bool public isDepositMade = false;

    constructor(address _bob) {
        alice = msg.sender;
        bob = payable(_bob);
        releaseTime = 0;
    }

    function deposit() external payable {
        require(msg.sender == alice, "Only Alice can deposit");
        require(!isDepositMade, "Deposit already made");
        releaseTime = block.timestamp + 1 days;
        isDepositMade = true;
    }

    function withdraw() external {
        require(msg.sender == bob, "Only Bob can withdraw");
        require(block.timestamp >= releaseTime, "Cannot withdraw before release time");
        require(address(this).balance > 0, "No funds to withdraw");

        bob.transfer(address(this).balance);
    }
}
