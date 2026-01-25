# Week 6 - Bilinear Pairings

## Assignment
[Homework 6 - RareSkills](https://almondine-song-c43.notion.site/Homework-6-8592a0f62a904fed996144d0e4f95e62)

## Overview
This assignment involves implementing a Solidity contract that verifies computation for elliptic curve points using Ethereum precompiles for bilinear pairings.

## Project Structure
```
week_6/
├── python/              # Python scripts for generating test values
│   ├── venv/           # Python virtual environment
│   ├── generate_test_values.py
│   └── requirements.txt
└── contracts/          # Foundry project with Solidity implementation
    ├── src/
    ├── test/
    └── ...
```

## Setup

### Python Environment
```bash
cd python
source venv/bin/activate  # Activate virtual environment
python generate_test_values.py
```

### Solidity Contracts
```bash
cd contracts
forge build
forge test
```

### Approach

The python file is specifically used to generate test values that can be copied over into the foundry tests.

The contract will be used to verify computation for elliptic curve points. It will perform the following checks based on the below formulas:

```
0 = -A_1B_2 +\alpha_1\beta_2 + X_1\gamma_2 + C_1\delta_2
X_1=x_1G1 + x_2G1 + x_3G1
```

* This will require 4 bilinear pairings
* Will use `0x06` precompile for EC Addition
* Will use `0x07` precompile for scalar multiplication 
* will use `0x08` precompile for pairings