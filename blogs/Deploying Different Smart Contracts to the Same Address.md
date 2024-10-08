---
title: Deploying Different Smart Contracts to the Same Address
organization: DeepStack Software Pvt. Ltd.
organization-url: "https://www.deepstacksoft.com"
lang: en
toc-title: Contents
---

<nav>
  <a href="index.html"><button>Back</button></a>
</nav>

**Posted on: 2024-09-18**

## Introduction

[![](https://portal.wireit.in/uploads/images/gallery/2024-10/scaled-1680-/inbSVwdYqYLiAtor-image-1727789740275.png)](https://portal.wireit.in/uploads/images/gallery/2024-10/inbSVwdYqYLiAtor-image-1727789740275.png)

- **CREATE** and **CREATE2** are two opcodes to deploy a smart contract, difference is
- Using **CREATE** new contracts are generated based on deployer address and nonce
  - Addresses generated using **CREATE** are still somehwhat diterministic like if you know the deployer nonce
  - Nonce starts from **0** and increments by 1 on every succesful **CREATE** call
- Using **CREATE2** new contracts are generated based on deployer address, salt, separator constant, bytecode
  - Compared to **CREATE** one has more control over contract generation

## Example code

![](carbon-3.png)

### Flow

- `A` is the deployer contract for `B` using `CREATE2` which will always deploy B on same address as long as same `salt` is being passed
  - **Note:** Calling of selfdestruct is very important here, if the contract is still there you won't be able to deploy new contract on the same address e.g. deploy -> selfdestruct -> repeat
- `B` deploys `C` (good contract) first using `CREATE` here the nonce has increased by 1
- Now that `C` is deployed, using `kill()` contract is destroyed, making a vacancy for a new contract (Bad contract) on the same address
  - **Note:** Since nonce was previously increased, you wont be able to deploy a new contract on the same address
- Using `kill()` we destroy `B` and re-deploy it on the same address through contract `A`
- Now that the nonce has been reset on `B`, we can deploy `D` to the same address where `C` was previously deployed

## Mitigation

Always check if the contract you are planning to give authority is EOA or smart contract, has a function which call selfdestruct and is based on newer versions of solidity
