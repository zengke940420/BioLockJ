# RarefyOtuCounts
Add to module run order:                    
`#BioModule biolockj.module.report.otu.RarefyOtuCounts`

## Description 
Applies a mean iterative post-OTU classification rarefication algorithm so that each output sample will have approximately the same number of OTUs.

## Properties 
*Properties are the `name=value` pairs in the [configuration](../../../Configuration#properties) file.*                   

### RarefyOtuCounts properties: 
| Property| Description |
| :--- | :--- |
| *rarefyOtuCounts.iterations* | _integer_ <br>(positive integer) the number of iterations to randomly select the rarefyOtuCounts.quantile of OTUs<br>*default:*  10 |
| *rarefyOtuCounts.lowAbundantCutoff* | _numeric_ <br>(positive double) minimum percentage of samples that must contain an OTU.<br>*default:*  0.01 |
| *rarefyOtuCounts.quantile* | _numeric_ <br>Quantile for rarefication. The number of OTUs/sample are ordered, all samples with more OTUs than the quantile sample are subselected without replacement until they have the same number of OTUs as the quantile sample<br>*default:*  0.5 |
| *rarefyOtuCounts.rmLowSamples* | _boolean_ <br>Options: Y/N. If Y, all samples below the rarefyOtuCounts.quantile quantile sample are removed<br>*default:*  *null* |

### General properties applicable to this module: 
| Property| Description |
| :--- | :--- |
| *cluster.batchCommand* | _string_ <br>Terminal command used to submit jobs on the cluster<br>*default:*  *null* |
| *cluster.jobHeader* | _string_ <br>Header written at top of worker scripts<br>*default:*  *null* |
| *cluster.modules* | _list_ <br>List of cluster modules to load at start of worker scripts<br>*default:*  *null* |
| *cluster.prologue* | _string_ <br>To run at the start of every script after loading cluster modules (if any)<br>*default:*  *null* |
| *cluster.statusCommand* | _string_ <br>Terminal command used to check the status of jobs on the cluster<br>*default:*  *null* |
| *docker.saveContainerOnExit* | _boolean_ <br>If Y, docker run command will NOT include the --rm flag<br>*default:*  *null* |
| *docker.verifyImage* | _boolean_ <br>In check dependencies, run a test to verify the docker image.<br>*default:*  *null* |
| *script.defaultHeader* | _string_ <br>Store default script header for MAIN script and locally run WORKER scripts.<br>*default:*  #!/bin/bash |
| *script.numThreads* | _integer_ <br>Used to reserve cluster resources and passed to any external application call that accepts a numThreads parameter.<br>*default:*  8 |
| *script.numWorkers* | _integer_ <br>Set number of samples to process per script (if parallel processing)<br>*default:*  1 |
| *script.permissions* | _string_ <br>Used as chmod permission parameter (ex: 774)<br>*default:*  770 |
| *script.timeout* | _integer_ <br>Sets # of minutes before worker scripts times out.<br>*default:*  *null* |

## Details 
*none*

## Adds modules 
**pre-requisite modules**                    
*none found*                   
**post-requisite modules**                    
*none found*                   

## Docker 
If running in docker, this module will run in a docker container from this image:<br>
```
biolockjdevteam/biolockj_controller:v1.3.6
```
This can be modified using the following properties:<br>
`RarefyOtuCounts.imageOwner`<br>
`RarefyOtuCounts.imageName`<br>
`RarefyOtuCounts.imageTag`<br>

## Citation 
Module developed by Mike Sioda                   
BioLockJ v1.3.6

