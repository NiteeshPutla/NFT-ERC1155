require('dotenv').config()

require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");



const PRIVATE_KEY = process.env.PRIVATE_KEY
const ETHERSCAN_API_KEY=process.env.ETHERSCAN_API_KEY

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks:{
    goerli:{
      url:"https://eth-goerli.g.alchemy.com/v2/KSM93xJEEY9dwqbegaro7RrB8sEiNsyu",
      accounts:[PRIVATE_KEY],
    },
  },
  etherscan:{
    apiKey:{
      goerli:[ETHERSCAN_API_KEY],
    },
  }

 
};
