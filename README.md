# Love Token Verification

**Contract:** [0x45601D0497419Ec993552EF425927F08f73CE032](https://etherscan.io/address/0x45601D0497419Ec993552EF425927F08f73CE032)

**Deployed:** March 8, 2016 (Block 1,117,697)

**Compiler:** soljson v0.2.0+commit.4dc2445e, optimizer ON

**Result:** Exact runtime bytecode match (1,853 bytes)

## Source

`Love.sol` contains the verified source code with an EthereumHistory attribution header.

The contract is based on the ethereum.org "Create your own crypto-currency" tutorial from early 2016, with a proof-of-work mining extension. Miners submit nonces to solve a hash challenge for token rewards.

## Verification

Compile with solc v0.2.0 (optimizer ON) to reproduce the exact on-chain bytecode:

```
npm install solc@0.2.0
node -e "var solc=require('solc'); var src=require('fs').readFileSync('Love.sol','utf8'); var out=solc.compile(src,1); console.log(out.contracts[':Love'].runtimeBytecode)"
```

## Links

- [EthereumHistory page](https://www.ethereumhistory.com/contract/0x45601D0497419Ec993552EF425927F08f73CE032)
- [Sourcify verification](https://repo.sourcify.dev/contracts/partial_match/1/0x45601D0497419Ec993552EF425927F08f73CE032/)
- [ethereum.org Token Tutorial (source template)](https://github.com/ethereum/ethereum-org/blob/master/views/content/token.md)
- [love2016.com](https://love2016.com)
