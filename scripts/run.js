const Reaction = {
	Wave: 0,
	Cake: 1,
	Hype: 2,
};

async function main() {
	const [owner, randomPerson] = await hre.ethers.getSigners();

	const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
	const contractFunds = hre.ethers.utils.parseEther("0.1");
	const waveContract = await waveContractFactory.deploy({
		value: contractFunds,
	});
	await waveContract.deployed();
	console.log("Contract deployed to:", waveContract.address);
	console.log("Contract deployed by:", owner.address);

	let contractBalance = await hre.ethers.provider.getBalance(
		waveContract.address,
	);
	console.log(
		"Contract balance:",
		hre.ethers.utils.formatEther(contractBalance),
	);

	let waveCount = await waveContract.getTotalWaves();

	let waveTxn = await waveContract.wave(Reaction.Wave, "Yooo buddy!");
	await waveTxn.wait();
	waveCount = await waveContract.getTotalWaves();

	waveTxn = await waveContract
		.connect(randomPerson)
		.wave(Reaction.Cake, "Some cake for you!");
	await waveTxn.wait();
	waveCount = await waveContract.getTotalWaves();

	waveTxn = await waveContract
		.connect(randomPerson)
		.wave(Reaction.Hype, "Hyped about Web3!!!");
	await waveTxn.wait();
	waveCount = await waveContract.getTotalWaves();

	contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
	console.log(
		"Contract balance:",
		hre.ethers.utils.formatEther(contractBalance),
	);
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
