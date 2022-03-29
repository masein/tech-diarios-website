---
date: 2021-11-20 14:13
description: The Storage Subsystem

tags: tech diarios, filecoin, paths, scheduling, store sector, resource windows 
---
# Filecoin explaination in depth (ep-03)

These episodes are explainations of Filecoin more deeply than the other post I have as “Filecoin explanation in a very simple way”.

In miner node architecture the Storage FSM is responsible for getting data from deals.  
- The storage subsystem has two main tasks:
- Store sector data
- Schedule and run sealing operation

## The architecture of storage contains 6 parts

### Paths
We address storage as paths. Storage is divided into paths. Each path is just a directory with a bit of metadata. Both the main miner node and worker nodes can have multiple paths.  
There are two types of paths, storage paths for longterm sector storage and seiling or squarespace. Sealing paths for keeping temporary data for sealing operations. We also can combine and have a path with both of them; But as we need speed for sealing operations we need SSDs which are expensive, so it’s better to use them just for sealing.  
Each storage path has a UUID, weight, and flags specifying what it should be used for.
### Remote Paths
Storing is further divided into Local and Remote storage. Each node can have a different set of local paths(zero or more). Sometimes sectors need to be moved between nodes and this is when remote paths come in handy. Each local path in the system is exposed by it’s node through HTTP(so nodes can transfer sectors themselves).
### Workers
Worker is responsible for executing sealing tasks on sectors stored in local storage. If needed sector data isn’t available in local storage paths, it will be acquired from remote storage paths first.
Each worker has access to a number of storage paths and paths can be shared between workers.
### Scheduling
The logic that decides what, when, and where tasks run. Needs to avoid running out of resources and to utilize resources optimally( optimizing for sealing throughput). Balancing the use of RAM, scratch storage, CPUs, GPUs, network bandwidth, sealing throughput, latency, ....
### Scheduling Strategy
Initially all tasks will go into the global scheduling queue, the main scheduler assigns them to worker windows. Tasks are assigned to workers in windows and after that workers start processing tasks.
### Resource Windows
Resource windows are here mostly to prevent resource starvation. Window size is defined by worker resources. Each worker has four windows; One for running tasks, one for preparing tasks( used for fetching sector data), and two windows for getting tasks from the scheduler.  

- The global scheduler operates on open(empty) windows.  
- Workers always have 2 open assigned windows.  
- Per task resource table is being used to allocate tasks to windows and also is defined in extern/sector-storage/resource.go

### Here the storage part finishes, hope they helped you so far. The last section would be how mining blocks work.

