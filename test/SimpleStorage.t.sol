// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    SimpleStorage ss;

    function setUp() public {
        ss = new SimpleStorage();
    }

    function testCreateAccounts() public {
        ss.createAccount("Ash", "Ketchum", "ash.ketchum@kanto");
        ss.createAccount("Misty", "Kasumi", "misty.kasumi@kanto");
        ss.createAccount("Brock", "Takeshi", "brock.takeshi@kanto");
    }

    function testGetAccounts() public {
        testCreateAccounts();

        SimpleStorage.Account[] memory accounts = ss.getAccounts();
        assertEq(accounts.length, 3);

        assertEq(accounts[0].firstName, "Ash");
        assertEq(accounts[0].lastName, "Ketchum");
        assertEq(accounts[0].email, "ash.ketchum@kanto");
        assertEq(accounts[0].balance, 0);

        assertEq(accounts[1].firstName, "Misty");
        assertEq(accounts[1].lastName, "Kasumi");
        assertEq(accounts[1].email, "misty.kasumi@kanto");
        assertEq(accounts[1].balance, 0);

        assertEq(accounts[2].firstName, "Brock");
        assertEq(accounts[2].lastName, "Takeshi");
        assertEq(accounts[2].email, "brock.takeshi@kanto");
        assertEq(accounts[2].balance, 0);
    }

    function testUpdateAccountsBalance() public {
        testCreateAccounts();

        ss.updateBalance(0, 1e18);
        ss.updateBalance(1, 2e18);
        ss.updateBalance(2, 3e18);

        SimpleStorage.Account[] memory accounts = ss.getAccounts();

        assertEq(accounts[0].balance, 1e18);
        assertEq(accounts[1].balance, 2e18);
        assertEq(accounts[2].balance, 3e18);
    }
}
