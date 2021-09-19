require("@nomiclabs/hardhat-waffle");


module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: "https://eth-rinkeby.alchemyapi.io/v2/c0zBdHnO2y3XtoRZDrTyhZEgLYilwGIx",
      accounts: [`3a244dca4eb77e166da4fd9b2ae60c44214a06697ce5f80ac0b1665e664eea9c`],
   },
  },
};
