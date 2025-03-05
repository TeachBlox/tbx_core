// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.28;

contract TbxEmailRegistry {
    mapping(bytes32 => string) private emailToCID;
    mapping(bytes32 => bytes32) public emailNonces;

    event CIDUpdated(bytes32 indexed emailHash, string cid);

    function generateNonce(string memory email) public {
        bytes32 emailHash = keccak256(abi.encodePacked(email));
        emailNonces[emailHash] = keccak256(
            abi.encodePacked(block.timestamp, email)
        );
    }

    function registerCID(
        string memory email,
        string memory cid,
        bytes memory signature
    ) public {
        bytes32 emailHash = keccak256(abi.encodePacked(email));
        require(_verifySignature(email, signature), "Invalid signature");

        emailToCID[emailHash] = cid;
        emit CIDUpdated(emailHash, cid);
    }

    function getCID(string memory email) public view returns (string memory) {
        return emailToCID[keccak256(abi.encodePacked(email))];
    }

    function _verifySignature(
        string memory email,
        bytes memory signature
    ) internal view returns (bool) {
        bytes32 messageHash = keccak256(
            abi.encodePacked(
                email,
                emailNonces[keccak256(abi.encodePacked(email))]
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
