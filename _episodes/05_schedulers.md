---
layout: page
title: Running a job on a HPC system
order: 6
session: 1
length: 20
toc: true
---

## Questions
What is a scheduler and why does a cluster need one?

How do I launch a program to run on a compute node in the cluster?

How do I capture the output of a program that is run on a node in the cluster?

## Objectives

Submit a simple script to the cluster.

Monitor the execution of jobs using command line tools.

Inspect the output and error files of your jobs.

## Job Scheduler
An HPC system might have thousands of nodes and thousands of users. How do we decide who gets what and when? How do we ensure that a task is run with the resources it needs? This job is handled by a special piece of software called the scheduler. On an HPC system, the scheduler manages which jobs run where and when.

The following illustration compares these tasks of a job scheduler to a waiter in a restaurant. If you can relate to an instance where you had to wait for a while in a queue to get in to a popular restaurant, then you may now understand why sometimes your job do not start instantly as in your laptop.

```flow
st=>start: Start
op=>operation: Your Operation
cond=>condition: Yes or No?
e=>end

st->op->cond
cond(yes)->e
cond(no)->op
```

The scheduler used on ISCA is Slurm. Although Slurm is not used everywhere, running jobs is quite similar regardless of what software is being used. The exact syntax might change, but the concepts remain the same.