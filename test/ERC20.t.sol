// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ERC20} from "../src/ERC20.sol";

contract ERC20Test is Test {
    ERC20 public token;

    function setUp() public {
        token = new ERC20("Test token", "TST", 18);
    }

    function testName() public {
        assert(keccak256(abi.encodePacked(token.name())) == keccak256(abi.encodePacked("Test token")));
    }

    function testSymbol() public {
        assert(keccak256(abi.encodePacked(token.symbol())) == keccak256(abi.encodePacked("TST")));
    }

    function testMint() public {
        address recipient = address(1);
        uint256 amount = 100;
        token._mint(recipient, amount);
        assert(token.balanceOf(recipient) == amount);
    }

    function testBurn() public {
        address user = address(1);
        uint256 initialBalance = 100 * 10 ** 18;
        uint256 burnAmount = 30 * 10 ** 18;

        token._mint(user, initialBalance);
        assert(token.balanceOf(user) == initialBalance);

        vm.prank(user);
        token._burn(user, burnAmount);

        assert(token.balanceOf(user) == initialBalance - burnAmount);
        assert(token.totalSupply() == initialBalance - burnAmount);
    }

    function testTransfer() public {
        address sender = address(1);
        address recipient = address(2);
        uint256 amount = 50;

        token._mint(sender, 100);

        vm.prank(sender);
        bool success = token.transfer(recipient, amount);

        assert(success);
        assert(token.balanceOf(sender) == 50);
        assert(token.balanceOf(recipient) == 50);
    }

    function testApproveAndTransferFrom() public {
        address owner = address(1);
        address spender = address(2);
        address recipient = address(3);
        uint256 amount = 50;

        token._mint(owner, 100);

        vm.prank(owner);
        bool approveSuccess = token.approve(spender, amount);

        assert(approveSuccess);
        assert(token.allowance(owner, spender) == amount);

        vm.prank(spender);
        bool transferSuccess = token.transferFrom(owner, recipient, amount);

        assert(transferSuccess);
        assert(token.balanceOf(owner) == 50);
        assert(token.balanceOf(recipient) == 50);
        assert(token.allowance(owner, spender) == 0);
    }
}
