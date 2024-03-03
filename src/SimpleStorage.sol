// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage {
    struct Account {
        string firstName;
        string lastName;
        string email;
        uint256 balance;
    }

    Account[] private allAccounts;

    function createAccount(string calldata _firstName, string calldata _lastName, string calldata _email) external {
        Account memory newAccount = Account(_firstName, _lastName, _email, 0);
        allAccounts.push(newAccount);
    }

    function updateBalance(uint256 _index, uint256 _newBalance) external {
        Account memory account = allAccounts[_index];
        account.balance = _newBalance;
        allAccounts[_index] = account;
    }

    function getAccounts() external view returns (Account[] memory) {
        return allAccounts;
    }
}
