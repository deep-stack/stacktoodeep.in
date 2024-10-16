---
title: Improper Storage Layout
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

One common problem that arises when using [proxies](https://medium.com/@social_42205/proxy-contracts-in-solidity-f6f5ffe999bd) is storage collision. This occurs when the implementation contract reads from or writes to a storage variable that occupies a different slot in the proxy contract than it does in the implementation contract.<br>

### Storage Collision Between Proxy and Implementation

![](blogs/codeblocks/codeblock-7.png) ![](blogs/codeblocks/codeblock-8.png) ![](blogs/codeblocks/codeblock-9.png)

### Storage Collision Between Implementation Versions

Storage collisions can also occur between different versions of an implementation contract<br>
![](blogs/codeblocks/codeblock-10.png)

## Mitigation

To avoid storage collisions, instead of storing the implementation address at the first storage slot of the proxy, a pseudo-random slot is chosen using EIP-1967<br>
![](codeblock-11.png)

When extending the storage layout, it is crucial to append new variables rather than inserting or deleting them from between existing ones. This approach ensures that the layouts remain completely independent and do not interfere with each other’s variable locations.
