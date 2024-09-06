// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    // Events
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    // State Variables
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    uint256 private _totalSupply;

    string public name;
    string public symbol;
    uint8 public decimals;

    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    function transfer(address _to, uint256 _amount) external returns (bool) {
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        return true;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function approve(address spender, uint256 _amount) external returns (bool) {
        allowance[msg.sender][spender] = _amount;
        return true;
    }

    function _mint(address to, uint256 _amount) public {
        balanceOf[to] += _amount;
        _totalSupply += _amount;
    }

    function _burn(address from, uint256 _amount) public {
        balanceOf[from] -= _amount;
        _totalSupply -= _amount;
    }
}
