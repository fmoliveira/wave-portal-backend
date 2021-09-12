// SPDX-License-Identifier: UNLICENSE

pragma solidity ^0.8.0;

contract WavePortal {
	enum Reaction {
		Wave,
		Cake,
		Hype
	}

	struct Wave {
		Reaction reaction;
		string message;
		address waver;
		uint256 timestamp;
	}

	Wave[] public waveList;
	uint256 totalWaves;
	uint256 private seed;

	event NewWave(
		Reaction reaction,
		string message,
		address indexed from,
		uint256 timestamp
	);

	constructor() payable {}

	function wave(Reaction _reaction, string memory _message) public {
		totalWaves += 1;
		waveList.push(Wave(_reaction, _message, msg.sender, block.timestamp));
		emit NewWave(_reaction, _message, msg.sender, block.timestamp);

		uint256 randomNumber = (block.difficulty + block.timestamp + seed) %
			100;
		seed = randomNumber;

		bool entersDraw = _reaction != Reaction.Wave ||
			bytes(_message).length > 20;

		if (entersDraw && randomNumber < 50) {
			uint256 prizeAmount = 0.0001 ether;
			require(
				prizeAmount <= address(this).balance,
				"Contract funds are insufficient to grant prize."
			);
			(bool success, ) = (msg.sender).call{value: prizeAmount}("");
			require(success, "Failed to withdraw money from contract.");
		}
	}

	function getAllWaves() public view returns (Wave[] memory) {
		return waveList;
	}

	function getTotalWaves() public view returns (uint256) {
		return waveList.length;
	}
}
