// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import "./Multisig.sol";

contract MultiSigFactory {
    // starts with one but if there is not multisig deployed then it is zero
    uint256 public s_contractIdCounter;

    mapping(uint256 => address) public multisigContract;

    receive() external payable {}

    function createNewMultisig(
        address[] memory _owners,
        uint _required
    ) external {
        MultiSig msig = new MultiSig(_owners, _required);
        s_contractIdCounter += 1;
        multisigContract[s_contractIdCounter] = address(msig);
    }
}
