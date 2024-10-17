---
title: Overflow Bugs in Solidity
organization: DeepStack Software Pvt. Ltd.
organization-url: "https://www.deepstacksoft.com"
lang: en
toc-title: Contents
---

<nav>
  <a href="index.html"><button>Back</button></a>
</nav>

**Posted on: 2024-09-18**

## Insecure Arithmetic

In Solidity versions below 0.8.0, unsigned integers (uint256) do not support negative numbers. If the subtraction causes an underflow, it will wrap around to a very large value instead of throwing an error. And if the addition is causing an overflow it will reset to zero<p>Lets see the below example

![](codeblock-27.png)

- As you can see the soldility version being used here is below 0.8.0
- In line 14, the require statement is supposed to ensure that value to be transfer should be less than or equal to the user's balance
- If balances[msg.sender] = 100 and \_value = 150, the subtraction will result in an underflow, causing balances[msg.sender] to wrap around to a very large number, close to 2^256 - 1.

## No overflow checks for shift operations

In Solidity, shift operations (<< for left shift and >> for right shift) do not perform overflow checks. This is in contrast to arithmetic operations (like addition, subtraction, multiplication), where overflow checks are done in recent Solidity versions (starting from 0.8.0).
When performing a shift operation, the result is always truncated to fit within the variable's data type (e.g., uint256 or int256). This means that bits that "fall off" during the shift are discarded, and no error is thrown if the result exceeds the maximum or minimum representable value.

![](codeblock-28.png)

## Overflow when using Ternary operator and Array Subscript

While most operators produce a literal expression when applied to literals, there are certain operators that do not follow this pattern:

Ternary operator (... ? ... : ...),

Array subscript (<array>[<index>]).

You might expect expressions like 255 + (true ? 1 : 0) or 255 + [1, 2, 3][0] to be equivalent to using the literal 256 directly, but in fact they are computed within the type uint8 and can overflow.

![](codeblock-29.png)
