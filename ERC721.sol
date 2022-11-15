// contracts/ERC721.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.8.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.8.0/token/ERC721/extensions/ERC721URIStorage.sol";
//import "@openzeppelin/contracts@4.8.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.8.0/utils/Counters.sol";

contract Sang is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_Supply = 4;

    // Assigning the name and symnol
    constructor() ERC721("Sang", "GEET") {}
    

    // Minting is creating a new entry onto the blockchain, we are creating new NFT. 
    // address the NFT will land onto. {address}
    // This will write to the blockchain, and the uri will have the metadata for the NFTs. 
    function safeMint(address to, string memory uri) public { // onlyowner
    // this can be used to mint NFT for admin. 
    // So admin can mint out NFTs. 
        // here the public view modifier can use the smart anywhere. 
        require(_tokenIdCounter.current() <= MAX_Supply,"I am sorry we have reachd the CAP ");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);



    }

    // The following functions are overrides required by Solidity.
    // This will copy from this contract and modifiy something as our need. 
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
    // here this method is internal, very much the contract inherence to other contract. 
    // the public and private is only readable from the same smart contract only. Unlike Internal. 
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }


    // this is a View market, if we call from a wallet it won't charge but if we call from the contract, it will charges . 
    // this variable will called the URI to get the value of the token associated with the tokenID. 
    function tokenURI(uint256 tokenId)
        public

        // view function modifier in solidity. they dont write into the blockchain. 
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    //
    // anyone calling for our contract. 
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}