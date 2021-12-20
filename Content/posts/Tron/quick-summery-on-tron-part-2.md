---
date: 2021-05-09 08:21
description: In this post we will look a bit closer into transactions in TRON blockchain
tags: tech diarios, tron, blockchain, TVM, transaction fee, energy, bandwidth
---
# Quick summery on TRON (ep-02) 

## In this post we will look a bit closer into transactions in TRON blockchain

Transation fees in TRON blockchain are free. wait! are they really free?
lets get back to white paper again..  

Ordinary transactions only consume bandwidth points, but smart contract operations consume both energy and bandwidth points. There are two types of bandwidth points available. Users can gain bandwidth points from freezing TRX, while 5000 free bandwidth points are also available daily.

So it depends, on which type of transactions you are talking about; and also on which standard?

When a TRX transaction is broadcast, it is transmitted and stored in the form of a byte array over the network. The byte array multiplied by bandwidth point rate would be the bandwidth Points consumed by one transaction. But it's not the only fee you have to pay, if a TRX or token transfer results in the target account being created you have to pay inorder to activate or create the account.

*Mmm.. it's getting more complicated!!*  

No let's have several examples and so you'll see how simlpe they are..  

First you need to now that for each user 5000 free bandwidth points are available daily. 
 
 
- In an account creation scenario, the network will first consume the bandwidth points that the transaction initiator gained from freezing TRX(will be explained in the next ep). If this amount is insufficient, then the network consumes the transaction initiator’s TRX.  

- In standard TRX transfer scenarios from one TRX account to another, the network first consumes the bandwidth points gained by the transaction initiator for freezing TRX. If that is insufficient, it then consumes from the free 5000 daily bandwidth points. If that is still not enough, then the network consumes the TRX of the transaction initiator.(the amount is calculated by the number of bytes in the transaction multiplied by 10 SUN.)  

- For TRC-10 token transfers, the network first verifies whether the total free bandwidth points of the issued token asset are sufficient. If not, the bandwidth points obtained from freezing TRX are consumed. If there is still not enough bandwidth points, then it consumes the TRX of the transaction initiator.
  
*So they are not literally free but as the price of the TRX is less than $0.2 while I'm writing this post, fees are almost free.*

### TRON network also defines a set of fixed fees for the following transactions:  

- Creating a witness node: 9999 TRX 
- Issuing a TRC-10 token: 1024 TRX  
- Creating a new account: 0.1 TRX  
- Creating an exchange pair: 1024 TRX

In the next post I would like to get deeper in bandwidth and energy in TRON blockchain..
