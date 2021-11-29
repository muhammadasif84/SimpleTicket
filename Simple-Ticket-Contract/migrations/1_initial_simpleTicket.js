const SimpleTicket = artifacts.require("SimpleTicket");

module.exports = function (deployer) {
  deployer.deploy(SimpleTicket);
};

