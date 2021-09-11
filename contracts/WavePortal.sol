// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
	enum Reaction {
		Wave,
		Cake,
		Fire
	}

	struct Wave {
		Reaction reaction;
	}

	Wave[] public waveList;

	constructor() {
		console.log("Hey fam, I am a contract and I am smart!");
	}

	function wave(Reaction _reaction) public {
		Wave memory newWave;
		newWave.reaction = _reaction;
		waveList.push(newWave);

		if (_reaction == Reaction.Wave) {
			console.log("%s waved at you!", msg.sender);
		} else if (_reaction == Reaction.Cake) {
			console.log("%s sent you some cake!", msg.sender);
		} else if (_reaction == Reaction.Fire) {
			console.log("%s is hyped with your work!", msg.sender);
		}
	}

	function getTotalWaves() public view returns (uint256) {
		console.log("We have %d total waves", waveList.length);
		return waveList.length;
	}
}
