---
date: 2021-05-08 17:58
description: In these series I'm gonna share a quick summery on TRON blockchain
tags: techDiarios, tron, blockchain
---
# Quick summery on TRON (ep-01) 

## Let's take a look at what they've said in their **Vision** section of white paper:

> TRON is an ambitious project dedicated to the establishment of a truly decentralized Internet and its infrastructure. The TRON Protocol, one of the largest blockchain-based operating systems in the world, offers public blockchain support of high throughput, high scalability, and high availability for all Decentralized Applications (DApps) in the TRON ecosystem. The July 2018 acquisition of BitTorrent further cemented TRON’s leadership in pursuing a decentralized ecosystem.

  
That seems like couple of great claims, let's get further.

lets start with it's architecture  

TRON adopts a 3-layer architecture divided into Storage Layer, Core Layer, and Application Layer. The TRON protocol adheres to Google Protobuf, which intrinsically supports multi-language extension.

so TRON got it's own VM(TVM) which is initially forked from EVM and can connect seamlessly with the existing solidity smart contract.  

<p align="center">
  <img src="/Tron/tron-architecture.png">
</p>

The compiler first translates the Solidity smart contract into bytecode readable and executable on the TVM. The TVM then processes data through opcode, which is equivalent to operating the logic of a stack-based finite state machine. Finally, the TVM accesses blockchain data and invokes External Data Interface through the Interoperation layer

TVM employs the concept of Energy. Different from the Gas mechanism on EVM which I would explain in next post ..
