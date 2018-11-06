#!/usr/bin/env bash

kubectl delete -f classic/ --recursive
kubectl delete -f test-spring-full.yml
