// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MultiSignatureWallet {
    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        uint256 approvalCount;
        bool executed;
    }

    // Variables/Storage
    address[] private owners;

    uint256 public transactionsCount = 0;

    mapping (address => bool) public isOwner;

    uint256 public minimumApprovalRequired;

    mapping (uint256 => Transaction) public transactions;

    // transactionId => owner => approved(true)
    mapping (uint256 => mapping (address => bool)) public approvals;

    // initialize
    constructor (address[] memory _owners, uint256 _minimumApprovalRequired) {
        require(_owners.length > 0, "There should be at least one owner");
        require(_minimumApprovalRequired > 0, "Minimum Approvals Required should be at least one");

        owners = _owners;
        for(uint i = 0; i < _owners.length; i++) {
            isOwner[_owners[i]] = true;
        }
        minimumApprovalRequired = _minimumApprovalRequired;
    }

    // Events
    event DepositEvent(address from, uint256 amount);
    event ApprovalEvent(address owner, uint256 transactionId, Transaction transaction);
    event NewTransactionEvent(uint256 transactionId, Transaction transaction);
    event ExecutionTransactionEvent(uint256 transactionId, Transaction transaction);

    // Modifiers
    modifier onlyOwner () {
        require(isOwner[msg.sender], "Only Owners of the Wallet can call this function");
        _;
    }

    modifier transactionExists (uint256 _transactionId) {
        require(_transactionId <= transactionsCount, "Transaction Does not Exist");
        _;
    }

    modifier transactionNotExecuted (uint256 _transactionId) {
        require(!transactions[_transactionId].executed, "Transaction Already Executed");
        _;
    }

    modifier transactionApprovedByOwner (uint256 _transactionId) {
        require(approvals[_transactionId][msg.sender], "Transaction not Approved By Owner");
        _;
    }

    modifier transactionNotApprovedByOwner (uint256 _transactionId) {
        require(!approvals[_transactionId][msg.sender], "Transaction Already Approved By Owner");
        _;
    }

    // Functions
    receive() external payable {}

    function deposit () public payable {}

    function createTransaction (address _to, bytes calldata _data) public onlyOwner {
        
    }

    function approveTransaction (uint256 _transactionId) public onlyOwner transactionExists(_transactionId) transactionNotApprovedByOwner(_transactionId) {
        
    } 
}


/**
* @dev nwobodo.eth
*/