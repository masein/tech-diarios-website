---
date: 2022-03-29 21:13
description: Proving storage & Mining

tags: tech diarios, filecoin, WindosPoSt, Deadlines, Faults, Recoveries, Mining process, Timing 
---
# Filecoin explanation in depth (ep-04)

These episodes are explanations of Filecoin more deeply than the other post I have as “Filecoin explanation in a very simple way”.

## Now that we know how the storing process works, it’s time to know how miners prove that they are storing data. Like other posts this section contains segments and we will explain the process in 6 steps.

### WindosPoSt
All sectors have to be proven every 24 hours. Sector set is split into 48 deadlines and each deadline can be split further into partitions. Each thirty minutes each deadline has to be proved.  
Partition is an arbitrary group of sectors which you prove together in a single WindowPoSt message.  
Missing a deadline proof results in losing power for the sectors in that deadline.
### Deadlines
Miners can start computing windowPoSt about ten minutes before the deadline opens. PoSt must be submitted to the chain before the deadline close epoch. If you miss the deadline there would be a fault.  
Fault recoveries for a given deadline must be declared before the FaultCutoff epoch.
### Faults
There are two main sector- related types of faults:  
- Declared fault(pay smaller penalty): must be declared thirty five minutes before the deadline for related faulty sectors opens.  
- Skipped PoSt(large penalty): can be caused by not submitting requiere PoSt within a deadline, or submitting WindowPoSt with skipped sectors.  
- Sectors can be faulty for fourteen proving periods(fourteen days) before being permanently terminated(unless they are recovered).  
workers.
### Recoveries
Sector recoveries must be declared thirty five minutes before the deadline for recovering sector opens(like declared faults). After successful recovery declaration and successful WindowPoSt on the recovered sector, the power is restored.  

Let’s discuss Mining blocks where miners actually get the block reward and get paid.
### Mining process
This stage contains selecting blocks which you as a miner will mine and check if you won or didn’t. If you didn’t, you’d go back to the first step and wait for the next epoch, if you did win, you start winning PoSt which just approves spacetime on a single random sector.  
After you select and put the message into the block you wait for the epoch timestamp and send the block to the network.  
So how are these timing and epochs working?
### Timing
After each epoch starts, miners wait about 6 seconds to get blocks from the network. They check whether they’ve won a block and so if they did, they’d compute a winning PoSt, select messages, and create the block(GPU supported-ten to 15 seconds). Then again miners wait for epoch timestamps in the newly created block. After the wait, the block gets released to the network.

### So, I think thats enough for these series, lets call it an in depth tutorial and finish the topic.
