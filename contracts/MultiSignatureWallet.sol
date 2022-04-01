// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MultiSignatureWallet {
    // Variables/Storage
    address[] private owners;

    uint256 public transactionsCount = 0;

    mapping (address => bool) public isOwner;

    uint256 public minimumApprovalRequired;

    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        uint256 approvalCount;
        bool executed;
    }

    mapping (uint256 => Transaction) transactions;

    // initialize
    constructor (address[] memory _owners, uint256 _minimumApprovalRequired) {
        require(_owners.length > 0, "There should be at least one owner");
        require(_minimumApprovalRequired > 0, "Minimum Approvals Required should be at least one");

        owners = _owners;
        minimumApprovalRequired = _minimumApprovalRequired;
    }

    // Events
    event DepositEvent(address owner, uint256 amount);
    event ApprovalEvent(address owner, uint256 transactionId, Transaction transaction);
    event ExecutionEvent(uint256 transactionId, Transaction transaction);

    // Modifiers

    // Functions
    receive() external payable {}
}


/**
* @dev nwobodo.eth
*/