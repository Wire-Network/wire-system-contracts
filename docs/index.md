---
content_title: About System Contracts
---

The Antelope blockchain framework is unique in that the features and characteristics of the blockchain built on it are flexible, that is, they can be changed, or modified completely to suit each business case requirement. Core blockchain features such as consensus, fee schedules, account creation and modification, token economics, block producer registration, voting, multi-sig, etc., are implemented inside smart contracts which are deployed on the blockchain built on the Antelope framework.

## System contracts defined in eos-system-contracts

The `eos-system-contracts` repository contains the system contracts encapsulating the base functionality for the EOS blockchain.

1. [sysio.bios](action-reference/sysio.bios)
2. [sysio.system](action-reference/sysio.system)
3. [sysio.msig](action-reference/sysio.msig)
4. [sysio.token](action-reference/sysio.token)
5. [sysio.wrap](action-reference/sysio.wrap)

## Key Concepts Implemented by sysio.system

1. [System](01_key-concepts/01_system.md)
2. [RAM](01_key-concepts/02_ram.md)
3. [CPU](01_key-concepts/03_cpu.md)
4. [NET](01_key-concepts/04_net.md)
5. [Stake](01_key-concepts/05_stake.md)
6. [Vote](01_key-concepts/06_vote.md)

## Build and deploy
To build and deploy the system contract follow the instruction from [Build and deploy](03_build-and-deploy.md) section.