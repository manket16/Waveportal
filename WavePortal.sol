// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;


import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    uint private seed;

    struct Wave{
        string message;
        address waver;
        uint timestamp;
    }

    Wave[] waves;
    event NewWave(address indexed from, uint timestamp, string message);
    mapping (address => uint) public lastWavedAt;

    constructor() payable {
        console.log("We have been constructed!");
    }


    function wave(string memory _message) public {
        require( lastWavedAt[msg.sender] + 15 minutes < block.timestamp,"Wait 15m");

            lastWavedAt[msg.sender] = block.timestamp;

            totalWaves +=1;
            console.log("%s waved w/ message",msg.sender);
            console.log("Got message:%s", _message);
            waves.push(Wave(_message, msg.sender, block.timestamp));

            uint randomNumber = (block.difficulty + block.timestamp + seed)%100;
            console.log("Random # generated: %s", randomNumber);
            seed = randomNumber;

        
        if (randomNumber < 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.00001 ether;
            require( prizeAmount <= address(this).balance, "Trying to withdraw more ether than the contract has." );
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw ether from contract");
        }
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint) {
        return totalWaves;
    }
}