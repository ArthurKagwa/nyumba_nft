// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./NyumbaDeed.sol";
import "./NyumbaKey.sol";

contract NyumbaRegistry {

    NyumbaDeed public nyumbaDeed;
    NyumbaKey public key;
    
    constructor(address nyumbaDeedAddress, address keyAddress) {
        nyumbaDeed = NyumbaDeed(nyumbaDeedAddress);
        key = NyumbaKey(keyAddress);
    }

    function registerProperty(string memory uri) public {
        nyumbaDeed.safeMint(msg.sender, uri);
    }
    
}

// forge script script/Deploy.s.sol:DeployDeed --broadcast --rpc-url $RPC_URL --sender $WALLET_ADDRESS --private-key $PIRIVATE_KEY