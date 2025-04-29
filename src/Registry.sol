// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Deed.sol";
import "./Key.sol";

contract Registry {

    Deed public deed;
    Key public key;
    
    constructor() {
        deed = new Deed();
        key = new Key();
    }
    
    function registerProperty(uint256 propertyId) public {
        deed.mint(propertyId);
        key.assign(propertyId, msg.sender, 365); // Owner gets 1-year occupancy by default
    }
}