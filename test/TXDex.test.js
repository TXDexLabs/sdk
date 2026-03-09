const { expect } = require("chai");

describe("TXDexToken", function () {

  it("Should deploy with correct supply", async function () {

    const TXDex = await ethers.getContractFactory("TXDexToken");
    const txdex = await TXDex.deploy(1000000);

    const owner = await txdex.owner();
    const balance = await txdex.balanceOf(owner);

    expect(balance).to.equal(ethers.parseEther("1000000"));

  });

});
