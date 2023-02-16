// const ConvertLib = artifacts.require("ConvertLib");
// const MetaCoin = artifacts.require("MetaCoin");
const MultiSigFactory = artifacts.require("MultisigFactory");
const Split = artifacts.require("Split");

module.exports = function (deployer) {
  // deployer.deploy(ConvertLib);
  // deployer.link(ConvertLib, MetaCoin);
  // deployer.deploy(MetaCoin);
  deployer.deploy(MultiSigFactory);
  deployer.deploy(Split);
};
