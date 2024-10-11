#!/bin/bash

echo "This is a Cilium Testing suite Script"

echo "Intialize Infrastructure"
terraform init

echo "Plan the Construction of Infrastructure"
terraform plan