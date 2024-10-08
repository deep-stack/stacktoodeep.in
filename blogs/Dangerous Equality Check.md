---
title: Dangerous Equality Check
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

If a contract relies on accounting of funds, an Attacker can easily disrupt the flow by force feeding `ETH` into the contract. There are multiple ways a smart contract can receive Ether, One of them is **payable reveive()** should be present if no then **payable fallback()**

![](carbon.png)

## Understanding problem

Consider this Crowd funding contract for example

![](carbon-1.png)

- **require(address(this).balancer == 100 ether, "Funding not reached")** the above contract relies on exact comparisons to the contract's Ether balance
- The contract's logic seemingly disallows direct payments and tells to use invest function instead.

## Exploit

Force feeding Ether

![](carbon-2.png)

- **selfdestruct** opcode sends all remaining Ether stored in the contract to a designated address.
- An attacke can send as little as **1 wei** through **selfdestruct** and using above contract's address as target

## Mitigation

The effects described above demonstrate that relying on precise comparisons with the contract's Ether balance is unreliable. The smart contract's logic should account for the possibility that its actual balance may exceed the value tracked by internal accounting.
