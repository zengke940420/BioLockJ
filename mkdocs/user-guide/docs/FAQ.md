# FAQ, Troublshooting and Special Cases


---
### **Question:** How much does it cost to use BioLockJ ?
---
**Answer:** BioLockJ itself free and open-source.

BioLockJ is designed for large data sets; and it is often necissary to purchase computational resources to handle large datasets and to run the processes that BioLockJ will manage.  This cost often comes in the form of buying an effective computer, subscribing to a cluster, or purchasing cloud computeing power.

---
### **Question:** What are the system requirements for running BioLockJ ?
---
**Answer:** Either unix-and-java or docker, details below.

Easy mode: you have a unix system and you can run docker.  You're covered.  BioLockJ requires java, but if you can run docker, then all of the java-components can run inside the docker container.

Easy-ish mode: no unix, but you can run docker.  See [Pure-Docker](../Pure-Docker).

Local host mode: No docker.  You need to have a unix-like system and java 1.8 or later.  The launch process for BioLockJ will be easy, but the majority of modules have essential dependencies and you will have to install each of those dependencies on your own system.  See [Dependencies](../Dependencies/).

In terms of memory, ram and cpus; the amount required really depends on the size of the data you are processing and the needs of the algorithms you are running.  

_**In general,**_ processing sequence data requires a computer cluster or a cloud-computing system (more than a typical individual-user machine). After sequence data have been summarized as tables, all subsequent steps are orders of magnetude smaller and can usually run on a laptop within a matter of minutes.  

Most datasets can be dramatically sub-sampled to allow a laptop user to run a test of the pipeline; this does not produce usable results, but allows the user to test and troubleshoot the pipeline in a convenient setting before moving it to a bigger system.

---
### **Question:** If biolockj indicates that my pipeline may have failed to start, how do I debug the root cause of the failure?
---
**Answer:** Use `-f`.

By default, BioLockJ runs the java component in the background, and only a minimal, helpful message is printed on the screen.  If there was some problem in getting that short, helpful message to the screen, you can use the `--foreground` or `-f` option to force biolockj to run in the foreground, thus printing everything to the screen.  Often the print-out ends shortly after a helpful message.


---
### **Question:** Sometimes BioLockJ adds modules to my pipeline.  How can I tell what modules will be added?
---
**Answer:** Read the docs; or use `-p`

With the `--precheck-only` or `-p` option, BioLockJ will create the pipeline and go through the check-dependencies phase for each module, but even without finding errors it will not actually run the pipeline.  This allows you see what modules will be run, see the pipeline folder layout, and see if any errors will prevent the pipeline from starting.  This is also ideal when you know you want to change more options or add more modules before you run the pipeline; but you want to check if there anything that needs to be fixed in what you have so far.

In the documentation for each module, there is a section called "Adds modules".  A module may give the class path of another module that it adds before or after itself.  Many modules say *"none found"* to indicate that this module does not add any other modules before or after itself.  Sometimes this section will say *"pipeline-dependent"* and more details are given in the "Details" section to explain which other modules might be added and when / why.

Modules that are added by other modules are called _pre-requisite modules_.  Modules that are added by the BioLockJ backbone are called _implicit modules_.  These can be disabled with the properties `pipeline.disableAddPreReqModules` and `pipeline.disableAddImplicitModules`, respectively.


---
### **Question:** I get an error message about a property, but I have that property configured correctly.  What gives?
---
**Answer:** Use `-u`.

This is often the result of a typo somewhere.  Generally, BioLockJ runs a check-dependencies protocol on each module, and all required properties should be checked during that process, and it stops when it first finds a problem.  With the `--unused-props` or `-u` option, biolockj will check dependencies for all modules, even after one fails, and any properties that were never used will be printed to the screen.  This often highlights typos in property names, or properties that are not used by the currenlty configured moudles.  Keep in mind, this only reports properties in your primary config file, not in any of your defaultProps files.


---
### **Question:** On a cluster system, I need a particular module to run on the head node.
---
**Answer:** Use module-specific properties to control the cluster properties for that module.

See [the Configuration page](../Configuration/#module-specific-forms) for more details about module-specific forms of general properties.

## Example:
On this cluster, the compute nodes do not have internet access, only the head node does. The first module in the pipeline is the SraDownload module to get the data, which requries internet access.

All pipelines run on this cluster include a reference to the properties set up specifically for this cluster:                 
`pipeline.defaultProps=${BLJ}/ourCluster.properties`

This group chose to store their system configurations in the BioLockJ folder, which they reference using the fully dressed ${BLJ} variable.  In this file, they have configurations for launching jobs:
```
cluster.batchCommand = qsub
SraDownload.batchCommand = /bin/bash
```

BioLockJ launches jobs using `qsub <script>`. For ONLY the SraDownload module, the property `SraDownload.batchCommand` overrides `cluster.batchCommand`; so for only this module, the jobs will be launched using `/bin/bash` which runs on the current node rather than launching a compute node.  All config files that reference this file and launch on the head node, will run the SraDownload modude on the head node.


---
### Question: How do I configure my pipeline for multiplexed data?
---
**Answer:** See the [Demultiplexer module Details](../GENERATED/biolockj.module.implicit/Demultiplexer/#details).


---
### Question: How should I configure my properties for a dataset that is one-sample-per-file (ie not multiplexed)?
---
**Answer1:** BioLockJ can extract the sample name from the filename; see [ Input](../GENERATED/Input/).

OR 

**Answer2:** BioLockJ can connect the sample id to the file name given in one or more columns in the metadata; see [Metadata](../GENERATED/Metadata/).

