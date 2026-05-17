// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

import "./erc721.sol";
import "./zombieAttack.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {
    ///@notice This is the mapping from tokenId to approved addresses. We will use this in the transferFrom function to check if the msg.sender is approved to transfer the tokenId
    mapping (uint => address) zombieApprovals;

    ///@notice This is the function to check the balance of a particular address. It returns the number of tokens that an address owns.
    ///@dev This function is required by the ERC721 standard. It is used to check the balance of a particular address. It returns the number of tokens that an address owns.
    function balanceOf(address _owner) external view returns (uint256) {
        return userZombiecount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        return zombieToOwner[_owner];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerZombiecount[_to]++;
        ownerZombieCount[_from]--;
        zombieToOwner[_tokenId] = _to;
        emit Transfer (_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require(msg.sender == zombieToOwner[_tokenId] || msg.sender == zombieApprovals[_tokenId]);
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable {
        zombieApprovals[_tokenId] = _approved;
        emit Approval (msg.sender, _tokenId);
    }
}

