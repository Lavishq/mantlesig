// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// These files are dynamically created at test time
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MultisigFactory.sol";

contract TestFacMsig {
    function testInitialCounterUsingDeployedContract() public {
        MultisigFactory msig = MultisigFactory(
            DeployedAddresses.MultisigFactory()
        );

        uint expected = 0;

        Assert.equal(
            msig.getCounter(),
            expected,
            "Factory should have 0 Multisig contracts deployed initially"
        );
    }
}
