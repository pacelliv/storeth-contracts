// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {StorageFactory} from "../src/StorageFactory.sol";

address constant FACTORY = address(0); // Insert factory address

contract DeployFactory is Script {
    function run() public returns (StorageFactory) {
        vm.broadcast();
        return new StorageFactory();
    }
}

contract CreateDatabase is Script {
    function run() public {
        vm.broadcast();
        StorageFactory(FACTORY).createSimpleStorage();
    }
}

contract CreateAccount is Script {
    function run() public {
        uint256 databaseIndex = 0;
        string memory firstName = "Ash";
        string memory lastName = "Ketchum";
        string memory email = "ash.ketchum@kanto";

        vm.broadcast();
        StorageFactory(FACTORY).sfCreateAccount(databaseIndex, firstName, lastName, email);
    }
}

contract UpdateAccountBalance is Script {
    uint256 databaseIndex = 0;
    uint256 accountIndex = 0;
    uint256 newBalance = 1e18;

    function run() public {
        vm.broadcast();
        StorageFactory(FACTORY).sfUpdateAccountBalance(databaseIndex, accountIndex, newBalance);
    }
}