// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ERC20} from "../src/ERC20.sol";

contract DeployERC20 is Script {
    function run() external {
        vm.startBroadcast();
        // Deploy the contract with name, symbol, and decimals
        ERC20 token = new ERC20("Test token", "TST", 18);
        // Mint some tokens to deployer(msg.sender)
        token._mint(msg.sender, 1000000 * 10 ** 18);
        vm.stopBroadcast();
    }
}
