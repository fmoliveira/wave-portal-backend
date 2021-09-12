async function main() {
	const [deployer] = await hre.ethers.getSigners();
	console.log("Deploying contracts with the account:", deployer.address);

	const balance = await deployer.getBalance();
	console.log("Account balance:", balance.toString());

	const TokenFactory = await hre.ethers.getContractFactory("WavePortal");
	const token = await TokenFactory.deploy();

	console.log("WavePortal address:", token.address);
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
