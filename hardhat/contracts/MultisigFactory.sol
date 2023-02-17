// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import "./Multisig.sol";

contract MultisigFactory {
    // starts with one but if there is not multisig deployed then it is zero
    uint256 private s_contractIdCounter;

    mapping(uint256 => address) public multisigContractAddress;

    function createNewMultisig(
        address[] memory _owners,
        uint _required
    ) external payable {
        MultiSig msig = new MultiSig{value: msg.value}(_owners, _required);
        s_contractIdCounter += 1;
        multisigContractAddress[s_contractIdCounter] = address(msig);
    }

    function getCounter() public view returns (uint256) {
        return s_contractIdCounter;
    }
}
