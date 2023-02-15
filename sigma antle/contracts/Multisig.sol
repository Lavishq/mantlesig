// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MultiSig {
    address[] public owners;
    uint256 public required;
    uint256 public transactionCount;

    struct Transaction {
        address destination;
        uint256 tx_value;
        bool executed;
        bytes data;
    }

    mapping(uint256 => Transaction) public transactions;
    mapping(uint256 => mapping(address => bool)) public confirmations;

    constructor(address[] memory _owners, uint _required) {
        require(_required > 0);
        require(_owners.length > _required);
        required = _required;
        owners = _owners;
    }

    receive() external payable {}

    function addTransaction(
        address _destination,
        uint256 _value,
        bytes memory _data
    ) internal returns (uint) {
        uint currentTxCount = transactionCount;
        transactions[transactionCount] = Transaction(
            _destination,
            _value,
            false,
            _data
        );
        transactionCount += 1;
        return currentTxCount;
    }

    function confirmTransaction(uint _txId) public {
        bool isOwner;
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == msg.sender) {
                isOwner = true;
            }
        }
        require(isOwner);
        confirmations[_txId][msg.sender] = true;
        if (isConfirmed(_txId)) {
            executeTransaction(_txId);
        }
    }

    function getConfirmationsCount(uint _txId) public view returns (uint) {
        address[] memory _owners = owners;
        uint total_confirmations;
        for (uint i = 0; i < _owners.length; i++) {
            if (confirmations[_txId][_owners[i]] == true) {
                total_confirmations++;
            }
        }
        return total_confirmations;
    }

    function submitTransaction(
        address _destination,
        uint256 _value,
        bytes memory _data
    ) public {
        uint currentTxId = addTransaction(_destination, _value, _data);
        confirmTransaction(currentTxId);
    }

    function isConfirmed(uint _txId) public view returns (bool) {
        return getConfirmationsCount(_txId) >= required;
    }

    function executeTransaction(uint _txId) public {
        require(isConfirmed(_txId));
        Transaction storage currTx = transactions[_txId];
        (bool sent, ) = currTx.destination.call{value: currTx.tx_value}(
            currTx.data
        );
        require(sent);
        currTx.executed = true;
    }
}
