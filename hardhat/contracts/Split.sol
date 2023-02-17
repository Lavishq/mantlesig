// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Split {
    function to_split(address[] memory _to) public payable {
        uint256 splitAmong = _to.length;
        uint256 amountPerSplit = msg.value / splitAmong;
        for (uint i; i < splitAmong; i++) {
            (bool sent, ) = _to[i].call{value: amountPerSplit}("");
            require(sent, "Failed to send");
        }
    }
}
