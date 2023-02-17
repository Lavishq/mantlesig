const { ethers } = require("hardhat");

async function main() {
  const MultisigFactory = await ethers.getContractFactory("MultisigFactory");
  const multisigFactory = await MultisigFactory.deploy();

  await multisigFactory.deployed();

  deploySplit();

  console.log(`multisigFactory to ${multisigFactory.address}`);
}

async function deploySplit() {
  const Split = await ethers.getContractFactory("Split");
  const split = await Split.deploy();

  await split.deployed();

  console.log(`split to ${split.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
