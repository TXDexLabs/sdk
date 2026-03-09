// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TXDexToken is ERC20, Ownable {

    uint256 public burnRate = 2; // 2% burn on sell
    address public dexPair;

    constructor(uint256 initialSupply) ERC20("TXDex", "TXD") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    function setDexPair(address _pair) external onlyOwner {
        dexPair = _pair;
    }

    function setBurnRate(uint256 _rate) external onlyOwner {
        require(_rate <= 10, "Burn too high");
        burnRate = _rate;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal override {

        if(recipient == dexPair && burnRate > 0){
            uint256 burnAmount = (amount * burnRate) / 100;
            uint256 sendAmount = amount - burnAmount;

            super._burn(sender, burnAmount);
            super._transfer(sender, recipient, sendAmount);
        } 
        else {
            super._transfer(sender, recipient, amount);
        }
    }
}
