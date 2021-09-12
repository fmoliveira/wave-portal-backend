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

	uint256 totalWaves;
	uint256 private seed;

	Wave[] public waveList;
	mapping(address => uint256) public lastWavedAt;

	event NewWave(
		Reaction reaction,
		string message,
		address indexed from,
		uint256 timestamp
	);

	constructor() payable {}

	function wave(Reaction _reaction, string memory _message) public {
		// anti-spam check
		require(
			lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
			"Wait 15 minutes to send another wave."
		);
		lastWavedAt[msg.sender] = block.timestamp;

		// prize randomness
		totalWaves += 1;
		waveList.push(Wave(_reaction, _message, msg.sender, block.timestamp));
		emit NewWave(_reaction, _message, msg.sender, block.timestamp);

		// store private seed to make gaming it more difficult
		uint256 randomNumber = (block.difficulty + block.timestamp + seed) %
			100;
		seed = randomNumber;

		// check preconditions to enter the draw
		bool entersDraw = _reaction != Reaction.Wave ||
			bytes(_message).length > 20;

		// grants prize
		if (entersDraw && randomNumber < 40) {
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
