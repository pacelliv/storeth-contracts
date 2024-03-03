// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SimpleStorage} from "../src/SimpleStorage.sol";
import {StorageFactory} from "../src/StorageFactory.sol";
import {Test} from "forge-std/Test.sol";

contract StorageFactoryTest is Test {
    StorageFactory sf;

    function setUp() public {
        sf = new StorageFactory();
    }

    function testCreateSimpleStorage() public {
        sf.createSimpleStorage();
        sf.createSimpleStorage();
        sf.createSimpleStorage();
    }

    function testCreateAccounts() public {
        testCreateSimpleStorage();

        sf.sfCreateAccount(0, "Ash", "Ketchum", "ash.ketchum@kanto");
        sf.sfCreateAccount(1, "Misty", "Kasumi", "misty.kasumi@kanto");
        sf.sfCreateAccount(2, "Brock", "Takeshi", "brock.takeshi@kanto");
    }

    function testGetAccounts() public {
        testCreateAccounts();

        SimpleStorage.Account[] memory accounts0 = sf.sfGetAccounts(address(this), 0);
        assertEq(accounts0[0].firstName, "Ash");
        assertEq(accounts0[0].lastName, "Ketchum");
        assertEq(accounts0[0].email, "ash.ketchum@kanto");
        assertEq(accounts0[0].balance, 0);

        SimpleStorage.Account[] memory accounts1 = sf.sfGetAccounts(address(this), 1);
        assertEq(accounts1[0].firstName, "Misty");
        assertEq(accounts1[0].lastName, "Kasumi");
        assertEq(accounts1[0].email, "misty.kasumi@kanto");
        assertEq(accounts1[0].balance, 0);

        SimpleStorage.Account[] memory accounts2 = sf.sfGetAccounts(address(this), 2);
        assertEq(accounts2[0].firstName, "Brock");
        assertEq(accounts2[0].lastName, "Takeshi");
        assertEq(accounts2[0].email, "brock.takeshi@kanto");
        assertEq(accounts2[0].balance, 0);
    }

    function testUpdateAccountsBalance() public {
        testCreateSimpleStorage();
        testCreateAccounts();

        sf.sfUpdateAccountBalance(0, 0, 1e18);
        SimpleStorage.Account[] memory accounts0 = sf.sfGetAccounts(address(this), 0);
        assertEq(accounts0[0].balance, 1e18);

        sf.sfUpdateAccountBalance(1, 0, 2e18);
        SimpleStorage.Account[] memory accounts1 = sf.sfGetAccounts(address(this), 1);
        assertEq(accounts1[0].balance, 2e18);

        sf.sfUpdateAccountBalance(2, 0, 3e18);
        SimpleStorage.Account[] memory accounts2 = sf.sfGetAccounts(address(this), 2);
        assertEq(accounts2[0].balance, 3e18);
    }
}