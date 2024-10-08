---
title: Phishing with tx.origin
organization: DeepStack Software Pvt. Ltd.
organization-url: "https://www.deepstacksoft.com"
lang: en
toc-title: Contents
---

**Posted on: 2024-09-18**

## Introduction

**tx.origin** is a global variable in Solidity that gives you the address of the original externally owned account (EOA) that initiated the transaction. It differs from msg.sender, which simply returns the address of the immediate account—whether an EOA or a contract—that called the function.<br>

If there are multiple function invocations along different contracts in certain chain of transactions, tx.origin will always refer to the EOA that initiated it, no matter the stack of contracts involved.

![](carbon-4.png)
In attacks involving **tx.origin**, the attacker deceives the owner of a vulnerable contract into performing a transaction that could be a contract disguised as a wallet where the **receive()** is triggered having malicious code in it

## Mitigation

Using of **msg.sender** instead of **tx.origin**
