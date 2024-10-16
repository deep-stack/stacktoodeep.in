---
title: Overriding in Solidity
organization: DeepStack Software Pvt. Ltd.
organization-url: "https://www.deepstacksoft.com"
lang: en
toc-title: Contents
---

<nav>
  <a href="index.html"><button>Back</button></a>
</nav>

**Posted on: 2024-09-18**

## Function Overriding

Functions that don't have an implementation must be marked as virtual to indicate that derived contracts are allowed to override them

Contract containing function without implementation should be marked abstract

In interfaces, you don't need to mark functions as virtual since they are implicitly virtual, meaning they are always expected to be implemented by other contracts.

[![](https://portal.wireit.in/uploads/images/gallery/2024-10/scaled-1680-/FzCzFi910pPFMjrM-image-1728034197138.png)](https://portal.wireit.in/uploads/images/gallery/2024-10/FzCzFi910pPFMjrM-image-1728034197138.png)

Example code

![](codeblock-22.png)

Before Solidity 0.8.8 the override keyword was required every time you overrode a function from an interface or abstract contract, from Solidity 0.8.8: If a function is defined in a single base (e.g., an interface or abstract contract), the override keyword is no longer required. However, when multiple inheritance is involved (i.e., the same function exists in multiple base contracts), the override keyword is still required to specify which base functions are being overridden.

[![](https://portal.wireit.in/uploads/images/gallery/2024-10/scaled-1680-/IlSFLABCPbMGNJuS-image-1728275316653.png)](https://portal.wireit.in/uploads/images/gallery/2024-10/IlSFLABCPbMGNJuS-image-1728275316653.png)

Example code

solidity >=0.8.8, no need to mention override when overriding a function

![](codeblock-23.png)

When function is defined in multiple bases, override must be mentioned

![](codeblock-24.png)

## State Variable Overriding

[![](https://portal.wireit.in/uploads/images/gallery/2024-10/scaled-1680-/IlSFLABCPbMGNJuS-image-1728275316653.png)](https://portal.wireit.in/uploads/images/gallery/2024-10/IlSFLABCPbMGNJuS-image-1728275316653.png)

Example code

![](codeblock-25.png)

## Abstract Contracts

[![](https://portal.wireit.in/uploads/images/gallery/2024-10/scaled-1680-/oP00IEaUBR3ZR9x6-image-1728278642005.png)](https://portal.wireit.in/uploads/images/gallery/2024-10/oP00IEaUBR3ZR9x6-image-1728278642005.png)

Example code

![](codeblock-26.png)

This would throw an error
