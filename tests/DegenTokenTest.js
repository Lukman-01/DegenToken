const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CryptoToken Contract", function () {
  let Token;
  let cryptoToken;
  let owner;
  let addr1;
  let addr2;
  let addrs;

  // Deploy the contract before each test
  beforeEach(async function () {
    Token = await ethers.getContractFactory("CryptoToken");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
    cryptoToken = await Token.deploy();
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await cryptoToken.owner()).to.equal(owner.address);
    });

    it("Should assign the total supply of tokens to the owner", async function () {
      const ownerBalance = await cryptoToken.balanceOf(owner.address);
      expect(await cryptoToken.totalSupply()).to.equal(ownerBalance);
    });
  });

  describe("Transactions", function () {
    it("Should transfer tokens between accounts", async function () {
      // Transfer 50 tokens from owner to addr1
      await cryptoToken.mint(owner.address, 100);
      await cryptoToken.transfer(addr1.address, 50);
      const addr1Balance = await cryptoToken.balanceOf(addr1.address);
      expect(addr1Balance).to.equal(50);
    });

    it("Should fail if sender doesn’t have enough tokens", async function () {
      const initialOwnerBalance = await cryptoToken.balanceOf(owner.address);
      await expect(cryptoToken.connect(addr1).transfer(owner.address, 1)).to.be.revertedWith("Insufficient balance");
      expect(await cryptoToken.balanceOf(owner.address)).to.equal(initialOwnerBalance);
    });

    it("Allows owner to mint tokens", async function () {
      await cryptoToken.mint(addr1.address, 100);
      expect(await cryptoToken.balanceOf(addr1.address)).to.equal(100);
    });

    it("Should burn tokens successfully", async function () {
      await cryptoToken.mint(addr1.address, 100);
      await cryptoToken.connect(addr1).burn(50);
      expect(await cryptoToken.balanceOf(addr1.address)).to.equal(50);
    });
  });

  describe("Token Redemption", function () {
    it("Should allow tokens to be redeemed for items", async function () {
      await cryptoToken.mint(addr1.address, 200);
      await cryptoToken.connect(addr1).redeemTokensForRewards(0); // Reward_A
      expect(await cryptoToken.balanceOf(addr1.address)).to.equal(190);
    });
  });
});
