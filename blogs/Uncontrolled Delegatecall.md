---
title: Uncontrolled Delegatecall
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

In Solidity, **delegatecall** is a low-level function that allows a contract to borrow the functionality of another contract while preserving its own storage. This can be dangerous if not controlled properly. Let’s look at an example where an uncontrolled **delegatecall** can be exploited to change the **owner** variable.

![](codeblock-12.png)

### Flow

- The **delegateCall()** function in the **Victim** contract was intended to call functions in the **Victim** contract's implementation, but the attacker exploits it via the **Attack** contract.
- The **attack()** function passes the attack contract's address and the attacker's address, type-cast to **uint256**, as arguments.
- This triggers the **delegatecall()** in the **Victim** contract, which makes a delegate call to **setNum()** in the attack contract.
- Even though **setNum()** accepts a **uint256** argument, the attacker’s address is type-cast to match the parameter type.
- Since **delegatecall()** preserves the storage of the calling contract (in this case, **Victim**), the **owner** variable in the **Victim** contract is modified, not in the **Attack** contract.

## Mitigation

Avoid using **delegatecall()** unless absolutely necessary, or restrict who can invoke it and which contracts it can call.
