// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    mapping(address => SimpleStorage[]) private allSimpleStorage;

    event NewSimpleStorage();
    event NewAccount();
    event AccountUpdated();

    function createSimpleStorage() public {
        SimpleStorage ss = new SimpleStorage();
        emit NewSimpleStorage();
        allSimpleStorage[msg.sender].push(ss);
    }

    function sfCreateAccount(
        uint256 _index,
        string calldata _firstName,
        string calldata _lastName,
        string calldata _email
    ) public {
        SimpleStorage ss = allSimpleStorage[msg.sender][_index];
        emit NewAccount();
        ss.createAccount(_firstName, _lastName, _email);
    }

    function sfUpdateAccountBalance(uint256 _contractIndex, uint256 _accountIndex, uint256 _newBalance) external  {
        SimpleStorage ss = allSimpleStorage[msg.sender][_contractIndex];
        emit AccountUpdated();
        ss.updateBalance(_accountIndex, _newBalance);
    }

    function sfGetDatabases(address _manager) external view returns (SimpleStorage[] memory) {
        return allSimpleStorage[_manager];
    }

    function sfGetAccounts(address _manager, uint256 _index) public view returns (SimpleStorage.Account[] memory) {
        SimpleStorage ss = allSimpleStorage[_manager][_index];
        return ss.getAccounts();
    }
}
