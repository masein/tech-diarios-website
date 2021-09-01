---
date: 2021-09-01 09:09
description: Sealing a sector

tags: tech diarios, filecoin, sealing a sector, PreCommit1, PreCommit2, Packaging, Creating Sectors
---
# Filecoin explanation in depth (ep-02)  

These episodes are explanations of Filecoin more deeply than the other post I have as “Filecoin explanation in a very simple way”.

### Before a Sector can be used, the miner must seal the Sector that means encode the data in the Sector to prepare it for the proving process. This process contains 7 steps each would be explained in the following.  

<p align="center">
<img src="/Filecoin/sealing sector.png" style="border-radius:2%">
</p>

## Creating Sectors

Sectors can be created in two ways,with deals(pledge a sector) or as “Committed Capacity”

- Create a committed capacity sector means to create a sector without deals

- Pledge a sector: Accepting some client deals. When you accept a client deal, you’ll create the sector, put the deal into that sector and keep it open for 1h to hopefully put more deals into the sector(so you have to do less work to accept more deals).

- Committed capacity sectors can be upgraded to sectors with deals(requires resealing the entire sector) means that initial pledge doesn't have to be paid again.

  

## Packaging

  The packaging step fills the sector with padding data(bunch of null bytes) to make sure it has the current size.

## PreCommit1

  We perform “Replication” with SDR which is a single-threaded process. There’s a need of minimum 64GiB of RAM, and using more memory causes more speed. As this process is single-thread, gpu doesn’t help at all.

  This process creates 11 layer files, 12*sector size(12*32GiB). You are able to discard most of that after this sector is fully sealed.

  - Takes 4h on AMD Zen2 based CPUs.

## PreCommit2

There is a test for a few merkle trees over the data

- 3*x sector size

- 4-8GiB RAM

- Parallelizable(gpu over 4GB memory)

- Takes 40m on 2080Ti

  

## PreCommit

  We send a PreCommit message that includes a PreCommit Deposit(expected block reward from sector over 20 days) to the miner actor(on chain transaction). Process is proving that the data is being replicated.

  The message also includes a sealed CID replica, list of DealIDs, and expiration time.

  After the message lands on the chain, we would wait for a random seed for the Commit stage.

## Commit

  In the Commit1 stage we read a challenge using random input from the previous. We pass that as an input to the Commit2 step. Then we compute the PoRep which’s been compressed by the SNARK algorithm(omg: 10-20 mg -> 192 bytes). To do this compression there’s a 170 GiB memory or 120GiB of RAM and a bit of swap required.

  - The whole process takes about an hour with a 2080Ti for a 32 GiB sector.

    

## SubmitCommit

    We send the commit message or the PoRep proof to the miner actor, wait for the miner actor to verify it and if it is ok, it tells the power actor to grant us some power for the sector. It also tells the main actor that deals in the sector are now being proven which mean we get block rewards and get paid for the deals we’ve put in the sector.
    In the upcoming post I will explain the storage subsystem.
