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
