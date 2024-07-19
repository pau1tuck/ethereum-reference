import { expect } from "chai";
import { ethers } from "hardhat";

describe("BasicAuthControl", () => {
	let BasicAuthControl: any;
	let basicAuthControl: any;
	let owner: any;
	let addr1: any;

	beforeEach(async () => {
		BasicAuthControl = await ethers.getContractFactory("BasicAuthControl");
		[owner, addr1] = await ethers.getSigners();
		basicAuthControl = await BasicAuthControl.deploy();
	});

	describe("Deployment", () => {
		it("Should set the right owner", async () => {
			expect(await basicAuthControl.owner()).to.equal(owner.address);
		});
	});

	describe("Item Management", () => {
		it("Should return the correct item count", async () => {
			await basicAuthControl.addItem("Item1", 100);
			await basicAuthControl.addItem("Item2", 200);
			expect(await basicAuthControl.getItemCount()).to.equal(2);
		});
		it("Should add an item", async () => {
			await basicAuthControl.addItem("Item1", 100);
			const item = await basicAuthControl.getItem(0);
			expect(item.name).to.equal("Item1");
			expect(item.price).to.equal(100);
			expect(item.owner).to.equal(owner.address);
		});
		it("Should remove an item", async () => {
			await basicAuthControl.addItem("Item1", 100);
			await basicAuthControl.removeItem(0);
			await expect(basicAuthControl.getItem(0)).to.be.revertedWith(
				"Item not found",
			);
		});
	});
});
