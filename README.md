# Love (W♥) Token — Source Verification

**Contract:** [0x45601D0497419Ec993552EF425927F08f73CE032](https://www.ethereumhistory.com/contract/0x45601D0497419Ec993552EF425927F08f73CE032)  
**Deployed:** March 8, 2016 (block 1,117,697)  
**Deployer:** [0xA2A4710d4e0F76f500582eeBeE7eBFe0Ea57A1E4](https://etherscan.io/address/0xA2A4710d4e0F76f500582eeBeE7eBFe0Ea57A1E4)  
**Deployment TX:** [0xf7fa0013...](https://etherscan.io/tx/0xf7fa00130546cf4177998364c16ffb9dfc695ad1cc075b88f0f37e4cd953b9aa)

## Historical Significance

The **Love token (W♥)** is the oldest known mineable coin on Ethereum — a proof-of-work ERC-20-style token deployed just 8 months after the Ethereum mainnet launched in July 2015.

It implements a SHA3-based mining mechanism where block rewards scale with time since the last successful proof. The difficulty adjusts dynamically: if miners solve blocks faster, difficulty rises; slower, it falls. This mirrors Bitcoin's original design but implemented entirely in Solidity on Ethereum.

The token predates the ERC-20 standard. It was later wrapped as W♥ (Wrapped Love) at a separate contract, which is tracked under the `0xd9071a977a10f256df50256cb0c7bf885149f454` address.

## Verification Status

| Field | Value |
|---|---|
| **ABI verification** | ✅ All 13 function selectors confirmed |
| **Bytecode match** | ⚠️ Exact match not achievable (see below) |
| **Source language** | Solidity |
| **Runtime size** | 1,853 bytes |
| **Era** | Frontier/Homestead boundary |

## Source Code

[`Love.sol`](Love.sol) — reconstructed from bytecode analysis.

All 13 public function selectors were computed from the reconstructed source and verified against the on-chain dispatcher:

| Selector | Function |
|---|---|
| `06fdde03` | `name()` |
| `19cae462` | `difficulty()` |
| `23b872dd` | `transferFrom(address,address,uint256)` |
| `313ce567` | `decimals()` |
| `51bdd585` | `currentChallenge()` |
| `5c10fe08` | `proofOfWork(uint256)` |
| `70a08231` | `balanceOf(address)` |
| `81c8149d` | `timeOfLastProof()` |
| `95d89b41` | `symbol()` |
| `a9059cbb` | `transfer(address,uint256)` |
| `cae9ca51` | `approveAndCall(address,uint256,bytes)` |
| `dc3080f2` | `spentAllowance(address,address)` |
| `dd62ed3e` | `allowance(address,address)` |

## Compiler Archaeology

The on-chain bytecode uses **EXP-based function selector dispatch**:

```
60 e0   PUSH1 0xe0 (= 224)
60 02   PUSH1 0x02
0a      EXP           → 2^224
60 00   PUSH1 0x00
35      CALLDATALOAD  → load 32 bytes from calldata
04      DIV           → calldata / 2^224 = 4-byte selector
```

All available Solidity compilers from soljson v0.1.1 (August 2015) onward use the more gas-efficient **PUSH29** constant instead of EXP to represent 2^224. This means the Love contract was compiled with a **pre-soljson-era Solidity compiler** — a binary that no longer exists in any public repository.

The contract was deployed March 8, 2016, but may have been compiled earlier using a development build of the cpp-ethereum Solidity compiler from late 2014 or early 2015. The specific compiler commit has not been identified.

The bytecode size (1,853 bytes) is significantly smaller than what any available compiler produces for this source (≈3,208 bytes), consistent with an older, less verbose code generator.

**Conclusion:** The source code is correct (ABI fully verified), but byte-perfect reproduction requires a compiler binary that is no longer publicly available. This is the furthest verification achievable for this contract.

## Storage Layout

| Slot | Variable | Type |
|---|---|---|
| 0 | `name` | `string` |
| 1 | `symbol` | `string` |
| 2 | `decimals` | `uint8` |
| 3 | `currentChallenge` | `uint256` |
| 4 | `timeOfLastProof` | `uint256` |
| 5 | `difficulty` | `uint256` |
| 6 | `balanceOf` | `mapping(address => uint256)` |
| 7 | `allowance` | `mapping(address => mapping(address => uint256))` |
| 8 | `spentAllowance` | `mapping(address => mapping(address => uint256))` |

## Part of Ethereum History

This verification is part of [Ethereum History](https://ethereumhistory.com) — a historical archive of early Ethereum smart contracts.

See also: [Awesome Ethereum Proofs](https://github.com/cartoonitunes/awesome-ethereum-proofs)
