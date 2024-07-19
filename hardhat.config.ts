import type { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-etherscan";
import "@typechain/hardhat";
import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
	solidity: "0.8.0",
	networks: {
		hardhat: {
			chainId: 1337,
		},
	},
};

export default config;
