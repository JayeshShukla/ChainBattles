require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

// /** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    mumbai: {
      url: process.env.TESTNET_RPC,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_API_KEY,
  },
};

// module.exports = {
//   solidity: "0.8.10",
// networks: {
//   mumbai: {
//     url: process.env.TESTNET_RPC,
//     accounts: [process.env.PRIVATE_KEY],
//   },
// },
// etherscan: {
//   apiKey: process.env.POLYGONSCAN_API_KEY,
// },
// };

// import { HardhatUserConfig } from "hardhat/config";
// import "@nomicfoundation/hardhat-toolbox";
// require("dotenv").config();

// const SEPOLIA_URL = process.env.SEPOLIA_URL;
// const PRIVATE_KEY = process.env.PRIVATE_KEY;

// if (!PRIVATE_KEY) {
//   throw new Error("PRIVATE_KEY environment variable is not defined.");
// }

// const config: HardhatUserConfig = {
//   solidity: "0.8.19",
//   networks: {
//     sepolia: {
//       url: SEPOLIA_URL,
//       accounts: [PRIVATE_KEY],
//     },
//   },
// };

// export default config;
