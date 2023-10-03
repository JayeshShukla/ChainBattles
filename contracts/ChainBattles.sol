// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

// deployed to polygon mumbai testnet address : 0x2d87fDf73300fE5115Fb6ef9A1Fe43250D7d3Cd4

contract ChainBattles is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct attributes {
        uint256 levels;
        uint256 hitpoints;
        uint256 strength;
        string warriortype;
    }

    mapping(uint256 => attributes) public tokenIdToLevels;

    constructor() ERC721("Chain Battles", "CBTLS") {}

    function getAttributes(
        uint256 tokenId
    ) public view returns (string memory) {
        attributes memory updatedAttributes = tokenIdToLevels[tokenId];

        // Create a JSON string manually
        string memory attributesJson = string(
            abi.encodePacked(
                '{"levels": ',
                (updatedAttributes.levels).toString(),
                ', "hitpoints": ',
                (updatedAttributes.hitpoints).toString(),
                ', "strength": ',
                (updatedAttributes.strength).toString(),
                ', "warriortype": "',
                updatedAttributes.warriortype,
                '"}'
            )
        );

        return attributesJson;
    }

    function generateCharacter(
        uint256 tokenId
    ) public view returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>",
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Warrior",
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Levels: ",
            getAttributes(tokenId),
            "</text>",
            "</svg>"
        );
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Chain Battles #',
            tokenId.toString(),
            '",',
            '"description": "Battles on chain",',
            '"image": "',
            generateCharacter(tokenId),
            '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenIdToLevels[newItemId] = attributes(0, 0, 0, "");
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(
        uint256 tokenId,
        uint256 levels,
        uint256 hitpoints,
        uint256 strength,
        string memory warriortype
    ) public {
        require(_exists(tokenId), "Please use an existing token");
        require(
            ownerOf(tokenId) == msg.sender,
            "You must own this token to train it"
        );
        attributes memory tempAttributes;
        tempAttributes.levels = levels;
        tempAttributes.hitpoints = hitpoints;
        tempAttributes.strength = strength;
        tempAttributes.warriortype = warriortype;
        tokenIdToLevels[tokenId] = tempAttributes;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}
