// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Deed {
    constructor() {
        
    }
    // Tracks who owns each property (ID → Owner)
    mapping(uint256 => address) public owners;
    //people with approval to mange tokens
    mapping(uint256 => address) public approvedTransfers;


    // Events for transparency
    event Minted(address indexed owner, uint256 indexed deedId);
    event Transferred(address indexed from, address indexed to, uint256 indexed deedId);

    function mint(uint256 deedId) public {
        require(owners[deedId] == address(0), "Deed already exists!");
        owners[deedId] = msg.sender;
        emit Minted(msg.sender, deedId);

    
    }
    function transfer(address to, uint256 deedId) public {
        require(owners[deedId] == msg.sender, "You don't own this deed!");
        owners[deedId] = to;
        emit Transferred(msg.sender, to, deedId);
    }

    function approve(address to, uint256 deedId) public {
        require(owners[deedId] == msg.sender, "Not owner!");
        approvedTransfers[deedId] = to;
    }

    function transferFrom(address from, address to, uint256 deedId) public {
        require(
            owners[deedId] == from && 
            (msg.sender == from || msg.sender == approvedTransfers[deedId]),
            "Transfer not allowed!"
        );
        owners[deedId] = to;
        emit Transferred(from, to, deedId);
    }
}