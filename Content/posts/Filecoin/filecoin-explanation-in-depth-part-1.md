---
date: 2021-08-14 17:37
description: Terms & Storage Market

tags: tech diarios, filecoin, fragment, actor, AllocTable, commintment, pledge, SNARK, replica
---
# Filecoin explanation in depth (ep-01)  

These episodes are explanations of Filecoin more deeply than the other post I have as “Filecoin explanation in a very simple way”.

Filecoin isn’t a Proof-of-Work blockchain. Power is based on how much data you store, and prove over time, which is like Hash Rate in PoW blockchains.

### Actors

All interactions with the chain are through actors. Every actor has Balance, Nonce, Code, and State.

There is a key address assigned to each actor.

- Power Actor is responsible for keeping the network power that is mostly just interacting with miner actors

- Miner Actor holds metadata about the miner, tracks sector information, and handles storage events. They also ensure that data is correctly stored over time.

  

  In order to understand Filecoin more deeply, covering some terms are necessary:

### Fragment

  A part of the data stored in a Decentralized Storage Network(DSN).

### Sector

  Disk space provided to the network by Storage Miners.

  Bigger sectors require more resources to handle, but also require less interactions with the chain.

### AllocTable

  A data structure that tracks parts and their allocated sectors.Updates on every block in the ledger and it’s Merkle root are stored in the latest block.Preserve the state of the DSN for quick lookup during validation and verification.

### Commitment

  A commitment to provide a sector to the network.Storage miners must submit pledges to the ledgers in order to begin accepting orders in the storage market.

### Pledge

  Includes the size of the pledge department and the collateral stored by miners.(FIL)

### SNARK

  zk-SNARKs are **a type of zero-knowledge proof construction** that have become popular in various blockchain applications, notably to enable private crypto transactions.

  Now let's have a story of how orders work:

  Imagine you want 20GB storage and I’m your storage miner. You bid an order to the orderbook via PUT. In your order you also specify the FIL you’re going to pay for this service and number of copies you want to have. You can also submit multiple orders or specify replication factors that would help having higher tolerance to storage failures.

  I as a storage miner will deposit collateral and pledge my storage to the network via a pledged transaction(Manage.PledgeSector). The collateral inside a transaction is stored during the time service is provided; If the miner generates storage vouchers for the data it promises to store, the collateral will be returned, and so if some storage certifications fail, a percentage of the collateral is lost.

  In order to get how this penalty works we have to get familiar with fault tolerance in this blockchain:

If a large amount of evidence is missing or invalid(that means I as a miner have passed the threshold), the network would consider me to be faulty, the order would be a failure, and then reintroduce the same order to the market.

Now, there are lots of storage miners as I am, so your order can be matched with them. But if each storage miner that is storing your peace is faulty(by each I mean more than our fault tolerance) then the peace is lost and the client gets refunded.

Once the pledged transaction appears in the blockchain(AllocTable), I can now offer my storage in the storage market(Put.AddOrders). Inside my offer I can set prices and add asking orders to the market’s orderbook.

When a matching order is found(Put.MatchOrders),the client sends the piece to the miner(PUT.SendPiece ran by client and Put.RecievePiece by the miner). As the data is received, we both sign a deal order and submit it to the storage market order book.

The network keeps track of each sector through an allocation table. When a deal order is signed, the network assigns the data to the miner and makes a note of it in AllocationTable(Manage.AssignOrders). At the time a storage miner sector is filled, the sector is sealed; Sealing is a slow sequential operation which transforms the data in a sector into a replica(Manage.SealSector).

Replica: A unique physical copy of the data that is associated with the public key of the storage miner.

Storage miners must repeatedly generate proofs of replication to guarantee they are storing the data. Proofs are posted in the blockchain and the network would verify them and make them pay if their proofs are not valid(as mentioned above).

In the next post we will get deeper in Sealing a sector and how each function in sealing works.
