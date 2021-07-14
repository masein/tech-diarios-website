---
date: 2021-05-10 17:41
description: Types of accounts in Tron blockchain
tags: techDiarios, tron, blockchain, account, TRC-10
---
# Quick summery on TRON (ep-04) 

## In this post we will get to know types of accounts in TRON blockchain

TRON has three types of account which are named as Normal, AssetIssue and Contract in the type variable of it's structure.    

- Normal account is used for standard transaction  
- AssetIssue account is used for storing TRC-10 tokens(these tokens can be used to activate an account.)  
- Contract account is for smart contracts which is created and triggered by Normal account.  

In order to create an account you may first register a random offline keypair with address and private key which is not acceptable by the network at first. in order to activate the account there are three ways which one of them is to transfer TRC-10 tokens to the new account.


```
message​ ​Account​ { ​
  message​ ​Vote​ {
  ​   bytes​ vote_address = ​1​; }​
  ​​int64​ vote_count = ​2​;
  ​​​bytes​ accout_name = ​1​;
  ​​​AccountType type = ​2​;
  ​​​​bytes​ address = ​3​;
  ​​​​​int64​ balance = ​4​;
  ​​​​​​repeated​ Vote votes = ​5​;
  ​​​​​​map<​string​, ​int64​> asset = ​6​;
} 
```

