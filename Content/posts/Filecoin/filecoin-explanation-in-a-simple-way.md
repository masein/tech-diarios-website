---
date: 2021-08-04 15:07
description: We’re gonna review Filecoin at a high level.

tags: tech diarios, filecoin, storage market, retieval market, consensus algorithm, proof of spacetime, collateral
---
# Filecoin explanation in a very simple way 
“The internet is in the middle of a revolution: centralized proprietary services are being replaced with decentralized open ones” this is how Protocol Labs started its white paper on Filecoin.

In this post we’re gonna review Filecoin at a high level.(We have low level explanations on each topic in other posts named by Filecoin deep explanation)

So, what’s Filecoin?

According to their abstraction section, Filecoin is a decentralized storage network that turns cloud storage into an algorithmic market. An algorithm market is a market without third parties to verify the market.(i.e. decentralized exchanges)

In this algorithmic market after the client and miner reach an agreement, the miner is obliged to continue to provide evidence of it’s stored data, because the difference here is that trades are not one time and you as a client must have insurance that your data is stored over time. The evidence provided by miners is publicly available as any other blockchain platforms and can be verified by everyone.

## User types 

There are 3 types of users in Filecoin network: client - storage miner - retrieval miner

Client and storage miners seem to be obvious, but what do retrieval miners really do? Are they just retrieving data and passing them to clients?

Retrieval miners can get data from clients or storage, they provide customer data on their request and they also can act as storage miners.

## Market types

#### Storage Market

Customer bids an order to order book, including how much is he or she offering to storage miners in order to store their data, on the other hand miner’s prices and storages are available in the order book of the network. They have been guaranteed through a protocol including penalty(collateral), that if the miner didn't stick to the numbers that had been provided by itself, must pay.

When the matching ask and bid order is found, the client sends the piece to the miner, they sign a deal order and submit it to the blockchain.

Storage miners make a copy of data they’re storing in a number that’s been requested by the customer. They must repeatedly generate proof of replication to guarantee that they are storing the data. Network checks whether the required proofs for each are present, if they are valid, and acts accordingly.

#### Retrieval Market 

In the retrieval market which is an off chain exchange, clients and retrieval miners discover each other in a peer-to-peer way.

Retrieval miners set theri price and add an ask order to the market’s orderbook. They announce their pieces by gossiping their ask orders to the network. Being off chain and gossiping simply means that each node passes data to another and this flow goes on, so everyone would have the data they needed.

<p align="center">
<img src="/Filecoin/gossip.png" style="border-radius:15%">
</p>

Clients do their bid order like they do in the retrieval market, and the retrieval miners check if their orders match with the clients bid order.

Once orders are matched, the miner sends parts of data & client sends micro-payments. When the piece is received, both the miner and the client sign a deal order and submit it to the blockchain.

## Consensus Algorithms

Proof of work schemes often require solving puzzles whose solutions are not reusable(useless, just securing network) and are wasteful(parallel) work.

Filecoin proposes a useful work consensus protocol(Proof-of-Spacetime), where the probability that the network elects the miner to create a new block is proportional to their storage currently in use in relation to the rest of the network.
