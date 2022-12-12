---
layout: page
title: Running more complex jobs on a HPC system 
order: 8
session: 2
length: 20
toc: true
---

When you move your work from your desktop/laptop to HPC system you might have to rethink how you structure it. This may be enforced or you may want to take advantage of the change to put some thought into the design.

Programming takes advantage of repetitive processes - 

## Serial vs Parallel processing

When we write a programme we write a series of commands that the "computer" executes one after the other. This sequential process requires one command to finish executing before the next can start. This means that the time the programme takes to run is the sum of each part (plus a bit of overheads). The logic of a programme is important, and the order of commands is important - but there are times when the programme, or elements of the programme, do not needs to run in sequence. 

For example think about the for loop below

```
for(number in 1 2 3 4 5){
    print number * number
}
```

This loop takes the values 1 to 5 in turn and calculates the square. The output would be

```
1
4
9
16
25
```

We can generalise this loop to run through any series of numbers. The time that the loop takes to run, depends on the number of numbers we want to square. The longer the list the longer, the longer the execution time. This way of running the code is call serial. We run one command at any point in time. 

In this example, the output of each command does not depend on the previous command. Calculating the square of 2 does not require us to know the square of 1. We don't actually need to wait for that command to finish. If we had more than one computer available we could distribute these jobs and speed up the execution without changing the output. This approach is called parallel processing. The real power of HPC is taking advantage of the multiple compute nodes simultaneously to speed up the compute time. 

To truly exploit this you typically need to use functions/wrappers/arguments to your script that do this distribution of tasks for you. These tend to be specific for different languages/programmes. However, you can manually parallelize your workflow, by identifying elements that can be run in parallel and submitting them as separate jobs to the queue.