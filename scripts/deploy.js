const hre = require("hardhat");

async function main() {

  const TXDex = await hre.ethers.getContractFactory("TXDexToken");

  const txdex = await TXDex.deploy(1000000);

  await txdex.deployed();

  console.log("TXDex deployed to:", txdex.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
