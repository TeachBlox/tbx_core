// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.28;

contract KeyStorage {
    struct KeyData {
        string cid;
        address owner;
        uint256 timestamp;
    }

    mapping(bytes32 => KeyData) private emailToKeyData;

    event KeyStored(
        bytes32 indexed emailHash,
        string cid,
        address indexed owner
    );
    event KeyUpdated(
        bytes32 indexed emailHash,
        string newCid,
        address indexed owner
    );

    modifier onlyOwner(string memory email, bytes memory signature) {
        require(_verifySignature(email, signature), "Unauthorized access");
        _;
    }

    function storeCID(
        string memory email,
        string memory cid,
        bytes memory signature
    ) public {
        bytes32 emailHash = keccak256(abi.encodePacked(email));

        require(_verifySignature(email, signature), "Invalid signature");
        require(
            emailToKeyData[emailHash].owner == address(0),
            "Email already registered"
        );

        emailToKeyData[emailHash] = KeyData({
            cid: cid,
            owner: msg.sender,
            timestamp: block.timestamp
        });

        emit KeyStored(emailHash, cid, msg.sender);
    }

    function updateCID(
        string memory email,
        string memory newCid,
        bytes memory signature
    ) public onlyOwner(email, signature) {
        bytes32 emailHash = keccak256(abi.encodePacked(email));
        require(
            emailToKeyData[emailHash].owner == msg.sender,
            "Not authorized to update"
        );

        emailToKeyData[emailHash].cid = newCid;
        emailToKeyData[emailHash].timestamp = block.timestamp;

        emit KeyUpdated(emailHash, newCid, msg.sender);
    }

    function getCID(string memory email) public view returns (string memory) {
        return emailToKeyData[keccak256(abi.encodePacked(email))].cid;
    }

    function _verifySignature(
        string memory email,
        bytes memory signature
    ) internal view returns (bool) {
        bytes32 messageHash = keccak256(
            abi.encodePacked(
                email,
                emailToKeyData[keccak256(abi.encodePacked(email))].timestamp
            )
        );
        return _recoverSigner(messageHash, signature) == msg.sender;
    }

    function _recoverSigner(
        bytes32 hash,
        bytes memory signature
    ) internal pure returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;
        require(signature.length == 65, "Invalid signature length");

        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }

        return ecrecover(hash, v, r, s);
    }
}
