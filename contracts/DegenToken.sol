// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.18;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract DegenToken is ERC20, Ownable {

//     constructor() ERC20("Degen", "DGN") {}

//         function mint(address to, uint256 amount) public onlyOwner {
//             _mint(to, amount);
//     }
// }


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    enum RewardType { Reward_A, Reward_B }

    uint256 public constant REWARD_A_COST = 10;
    uint256 public constant REWARD_B_COST = 100;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) // Set deployer as the owner
    {}
    
    // Function for only owner to mint new tokens
    function mint(address recipient, uint256 quantity) public onlyOwner {
        _mint(recipient, quantity);
    }

    // Function for users to transfer tokens to others
    function sendTokens(address recipient, uint256 quantity) external {
        require(balanceOf(msg.sender) >= quantity, "Insufficient balance");
        approve(msg.sender, quantity);
        transferFrom(msg.sender, recipient, quantity);
    }

    // Function for users to redeem tokens for rewards
    function redeemTokensForRewards(RewardType rewardType) external {
        if (rewardType == RewardType.Reward_A) {
            require(balanceOf(msg.sender) >= REWARD_A_COST, "Insufficient tokens to redeem for Reward_A");
            _burn(msg.sender, REWARD_A_COST); // Burn tokens upon successful transaction
        } else if (rewardType == RewardType.Reward_B) {
            require(balanceOf(msg.sender) >= REWARD_B_COST, "Insufficient tokens to redeem for Reward_B");
            _burn(msg.sender, REWARD_B_COST); // Burn tokens upon successful transaction
        } else {
            revert("Invalid reward type");
        }
    }

    // Function for users to check their token balance
    function getBalance(address account) public view override returns (uint256) {
        return super.balanceOf(account);
    }
    
    // Function for users to burn their tokens
    function destroyTokens(uint256 quantity) public override {
        require(balanceOf(msg.sender) >= quantity, "Insufficient balance");
        _burn(msg.sender, quantity);
    }
}
