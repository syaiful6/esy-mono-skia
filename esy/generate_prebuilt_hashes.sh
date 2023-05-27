#!/usr/bin/env bash

cd ./prebuilt &&
find . -type f -not -path ./sha256hashes.txt -exec sha256sum {} \; > sha256hashes.txt
