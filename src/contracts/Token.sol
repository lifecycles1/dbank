// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    //add minter variable
    address payable public minter;

    //add minter changed event
    event MinterChanged(address indexed from, address to);

    constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
        //asign initial minter
        setMinter(msg.sender);
    }

    function setMinter(address newMinter) public {
        minter = payable(newMinter);
    }

    //Add pass minter role function
    function passMinterRole(address payable dBank) public returns (bool) {
        require(
            msg.sender == minter,
            "Error, Only owner can change pass minter role"
        );
        minter = dBank;

        emit MinterChanged(msg.sender, dBank);
        return true;
    }

    function mint(address account, uint256 amount) public {
        //check if msg.sender have minter role
        require(
            msg.sender == minter,
            "Error, msg.sender does not have minter role"
        );
        _mint(account, amount);
    }
}
