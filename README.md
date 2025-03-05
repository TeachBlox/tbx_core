# TBX Core – Smart Contracts for Decentralized Email Payments

TBX Core is an open-source repository containing smart contracts for **decentralized email-based payments and key management on Ethereum**. It enables users to send and receive Ethereum payments using **email addresses**, while ensuring full decentralization, security, and privacy.

## 🚀 Features
- 💳 **Email-based Ethereum transactions** – Send and receive crypto without complex wallet addresses.
- 🔐 **Decentralized private key storage** – Securely store keys in **IPFS**.
- 🔑 **Non-custodial wallet management** – Wallet keys are generated client-side (via SDK) and never exposed to the blockchain.
- 🛡️ **End-to-end encryption** – Private keys encrypted via AES-256.
- 📦 **Open-source SDK integration** – Easily connect Web3 apps.

## 📜 Smart Contracts
This repository contains smart contracts that power TBX’s **decentralized key management and email-based payment system**.

| Contract       | Description |
|---------------|-------------|
| `TbxEmailRegistry.sol` | Stores hashed email-to-CID (IPFS) mapping |

## 📖 Documentation
- **[Smart Contract Docs](docs/README.md)**
- **[Integration Guide](docs/integration.md)**
- **[Security Policy](SECURITY.md)**
- **[Contribution Guide](CONTRIBUTING.md)**

## 🔧 Installation
### Prerequisites
- **Node.js**
- **Hardhat** (Ethereum smart contract development framework)
- **IPFS CLI** (for decentralized key storage)

### Setup Project
```bash
git clone https://github.com/TeachBlox/tbx_core.git
cd tbx_core
npm install
npx hardhat compile
```

### Run Tests
```bash
npx hardhat test
```

## 🏗 Deployment
### Deploy to Local Hardhat Network
```bash
npx hardhat node
npx hardhat deploy --network localhost
```
### Deploy to Ethereum Testnet (Sepolia)
```bash
npx hardhat deploy --network sepolia
```

## 🔒 Security Model
- **Keys are generated client-side** using the TBX SDK and encrypted before storage.
- **Smart contracts do not generate or store private keys**, ensuring maximum security.
- **CID (IPFS hash) is mapped to a hashed email in the TbxEmailRegistry smart contract**.

## 🏛 Governance & DAO
TBX Core will be governed via a **DAO**, allowing the community to vote on improvements and integrations.

## 💡 How to Contribute
We welcome all contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) guide.

### ✨ Ways to Contribute
- Open an **issue** for bugs or feature requests.
- Submit a **pull request** with improvements.
<!-- - Join discussions on **[Discord](https://discord.gg/tbx)**. -->

## 🔒 Security
If you discover a vulnerability, **DO NOT** open a public GitHub issue. Instead, report it to **security@teachblox.com**.

## 📢 Community & Support
- **GitHub Issues** – Report bugs & request features.
<!-- - **Discord** – Join the discussion: [discord.gg/tbx](https://discord.gg/tbx)
- **Twitter** – Follow us: [twitter.com/teachblox](https://twitter.com/teachblox) -->

---
🚀 **TBX Core – Making Ethereum payments as simple as sending an email!**

