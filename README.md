Backend for [Hodle](https://github.com/ExcelCoin/hodle).

It implements a cryptocurrency powered by multiple copies of a giant Excel spreadsheet.

This exposes a Metamask-compatible RPC endpoint containing 26 ERC-20 tokens, but doesn't actually implement a Blockchain or an Ethereum VM. Instead, requests are translated into reads and writes to Excel spreadsheets (one spreadsheet per token).

# TODO

- actually do the transactions - currently it just always return a hardcoded balance

# Running

You'll need to install Raku (from [rakudo-pkg](https://github.com/nxadm/rakudo-pkg)). Then:

```
zef install --/test cro Cro::RPC::JSON
raku hodle.raku
```

Add a new chain in Metamask with the parameters:

- RPC URL: `http://localhost:3000`
- Chain ID: `24602`
- Currency Symbol: `LOC`

Then import a token with the parameters:

- Token Contract Address: `0x8888888888888888888888888888888888888888`
- Token Symbol: `ACOIN`
- Token Decimal: `18`