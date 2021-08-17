const Campain = artifacts.require("Campain");

module.exports = function(deployer){
    deployer.deploy(Campain);
}