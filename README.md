# Nyumba NFT Smart Contract System

The **Nyumba NFT System** is a decentralized property registry built on Ethereum, using the ERC-721 NFT standard. It enables property ownership tracking, temporary occupancy assignment, and a unified registration system via three core smart contracts:

* `NyumbaDeed.sol`  – ERC-721 NFT representing property ownership.
* `NyumbaKey.sol` – Manages temporary property occupancy.
* `NyumbaRegistry.sol` – A unified interface for minting and registering properties.

---

## 🔐 Contracts Overview

### 1. `NyumbaDeed.sol`

**Inherits:** `ERC721`, `Ownable`, `ERC721URIStorage`, `ERC721Pausable`, `ERC721Burnable`

This contract represents property deeds as NFTs.

* Each NFT is a unique property deed.
* Metadata (like location, images, etc.) is stored as a URI (e.g., IPFS link).
* Minting is restricted to the contract owner (typically the `Registry`).

**Key Functions:**

* `safeMint(address to, string memory uri)`: Mints a new deed with metadata.
* `pause()` / `unpause()`: Pauses/unpauses transfers and minting.

### 2. `Key.sol`

**Purpose:** Temporary occupancy management

This contract allows the NFT owner to assign a temporary occupant to a property. The occupant is tracked for a limited duration.

**State Variables:**

* `occupants`: Maps `propertyId` to occupant address.
* `expiryTime`: Maps `propertyId` to Unix expiration timestamp.

**Key Functions:**

* `assign(uint256 propertyId, address occupant, uint256 durationDays)`: Assigns occupancy.
* `transferOccupancy(uint256 propertyId, address newOccupant)`: Allows current occupant to transfer occupancy.

**Rules:**

* Only property owner (from `NyumbaDeed`) can assign an occupant.
* Only current occupant can transfer occupancy.
* Owner is exempt from occupancy expiration rules.

### 3. `NyumbaRegistry.sol`

**Purpose:** Unified interface for interacting with `NyumbaDeed` and `Key` contracts.

Deployed with the addresses of the `NyumbaDeed` and `Key` contracts. Provides a single function to mint a deed and (optionally) assign it.

**Key Functions:**

* `registerProperty(uint256 propertyId)`:

  * Calls `safeMint` on `NyumbaDeed`.
  * Optionally, can later assign an occupant using the `Key` contract.

---

## 🛠️ Deployment

Use Foundry to deploy contracts. Example script:

```solidity
Deed deed = new NyumbaDeed(msg.sender);
Key key = new Key();
Registry registry = new Registry(address(deed), address(key));
```

---

## 🖥️ Frontend Integration

You’ll need the ABIs for each contract (`NyumbaDeed`, `Key`, and `Registry`).

Use the `forge build` command and copy the JSON files from `out/` directory into your frontend project.

Example using Ethers.js:

```js
import RegistryABI from './abis/Registry.json';

const registry = new ethers.Contract(registryAddress, RegistryABI.abi, signer);
await registry.registerProperty(123);
```

---

## 🔐 Security Considerations

* Ownership is immutable until transferred via `ERC721` rules.
* Deeds can be paused for emergency.
* Assignments are permissioned (only property owners can assign).
* Time-based expiry ensures occupants lose access after duration.

---

## 📦 Future Extensions

* Link metadata to decentralized storage (e.g., IPFS/Filecoin).
* Add a `RenewOccupancy` feature.
* Create a marketplace for occupancy rights.
* Add support for subletting logic.

---

## 📄 License

MIT License.

---

## 👤 Authors

* Asasira Arthur
* Louis Asingizwe

---

## 🌍 Summary

The Nyumba system allows decentralized, transparent property ownership and managed occupancy using NFTs and smart contracts. It combines the best of blockchain and real estate administration into a unified protocol.
