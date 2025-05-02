// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NyumbaDeed.sol";

contract NyumbaKey {
    NyumbaDeed public nyumbaDeed;
    mapping(uint256 => address) public occupants;
    mapping(uint256 => uint256) public expiryTime;
    
    event OccupancyAssigned(uint256 indexed propertyId, address occupant, uint256 until);

    function assign(uint256 propertyId, address occupant, uint256 durationDays) public {
        require(nyumbaDeed.ownerOf(propertyId) == msg.sender, "Not property owner");

        occupants[propertyId] = occupant;
        expiryTime[propertyId] = block.timestamp + (durationDays * 1 days);
        
        emit OccupancyAssigned(propertyId, occupant, expiryTime[propertyId]);
    }

    function transferOccupancy(
        uint256 propertyId, 
        address newOccupant
    ) public {
        // 1. Check current occupant is the caller
        require(
            occupants[propertyId] == msg.sender,
            "Not the current occupant"
        );
        
        // 2. Check occupancy hasn't expired
        require(
            block.timestamp < expiryTime[propertyId],
            "Occupancy period expired"
        );
        
        
        // 3. Execute transfer
        occupants[propertyId] = newOccupant;
        
        emit OccupancyTransferred(
            msg.sender, 
            newOccupant, 
            propertyId
        );
    }

    event OccupancyTransferred(
        address indexed from,
        address indexed to,
        uint256 indexed propertyId
    );

    
}