const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MultisigFactory", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployMultisigFactoryFixture() {
    const MultisigFactory = await ethers.getContractFactory("MultisigFactory");
    const multisigFactory = await MultisigFactory.deploy();

    const [owner, account1, account2, account3] = await ethers.getSigners();

    return { multisigFactory, owner, account1, account2, account3 };
  }

  describe("Deployment", function () {
    it("Should have the counter 0", async function () {
      const { multisigFactory } = await loadFixture(
        deployMultisigFactoryFixture
      );

      const expected = 0;
      expect(await multisigFactory.getCounter()).to.equal(expected);
    });
    describe("Create a Multisig", function () {
      it("Should have the counter 1", async function () {
        const { multisigFactory, owner, account1, account2 } =
          await loadFixture(deployMultisigFactoryFixture);
        const arrayOfAccounts = [owner, account1, account2];
        const required = 2;
        // await multisigFactory.createNewMultisig(arrayOfAccounts, required);
        await multisigFactory.createNewMultisig(
          [
            ethers.utils.computeAddress(owner.toString()),
            ethers.utils.computeAddress(account1.toString()),
            ethers.utils.computeAddress(account2.toString()),
          ],
          required
        );

        const expected = 1;
        expect(await multisigFactory.getCounter()).to.equal(expected);
      });
    });
  });
});
