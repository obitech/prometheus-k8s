#!/usr/bin/env bash

kubectl delete -f monitoring/ --recursive
kubectl delete -f guestbook/

