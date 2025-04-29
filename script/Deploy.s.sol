// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Deed.sol";
import "../src/Key.sol";
import "../src/Registry.sol";

contract DeployDeed is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy the Deed contract
        Deed deed = new Deed();
        Key key = new Key();
        Registry registry = new Registry();

        console.log("Deed contract deployed at:", address(deed));
        console.log("Key contract deployed at:", address(key));
        console.log("Registry contract deployed at:", address(registry));

        vm.stopBroadcast();
    }
}