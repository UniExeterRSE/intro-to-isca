#!/bin/sh

## print start date and time
echo Job started on:
date -u

echo "hello-world"

## print node job run on
echo -n "This script is running on "
hostname

## print end date and time
echo Job ended on:
date -u