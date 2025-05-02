// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/NyumbaDeed.sol";
import "../src/NyumbaKey.sol";
import "../src/NyumbaRegistry.sol";

contract DeployNyumbaDeed is Script {
    function run() external {
        vm.startBroadcast();

        NyumbaDeed nyumbaDeed = new NyumbaDeed(msg.sender);
        NyumbaKey key = new NyumbaKey();
        NyumbaRegistry registry = new NyumbaRegistry(address(nyumbaDeed), address(key));


        console.log("NyumbaDeed contract deployed at:", address(nyumbaDeed));
        console.log("Key contract deployed at:", address(key));
        console.log("Registry contract deployed at:", address(registry));
        

        vm.stopBroadcast();
    }
}