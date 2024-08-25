# Wire system contracts

Wire system contracts are a collection of contracts deployable to a Wire blockchain. These system contracts extend the robust foundation provided by the [sysio.contracts]() with enhancements from [Antelope]() protocol and some of the key features include: 

- **Accounts and Permissions**: Flexible permission system for transaction-specific actions via multi-signature authorizations.
- **Advanced Consensus**: Extends the basic consensus framework to include detailed processes for selecting Node Operators and aligning their incentives, using a system of rewards and penalties.
- **Sophisticated Resource Management(ROA)**: Extended systems for tracking and usage of CPU/NET and RAM, and facilitates the establishment of markets where users can dynamically trade and manage resource rights.
- **Token Functionality:** Support for creation and management of both fungible and non-fungible tokens.


The collection of system contracts consists of the following individual contracts:

* [boot contract](contracts/sysio.boot/include/sysio.boot/sysio.boot.hpp): A minimal contract that only serves the purpose of activating protocol features which enables other more sophisticated contracts to be deployed onto the blockchain. (Note: this contract must be deployed to the privileged `sysio` account.)
* [bios contract](contracts/sysio.bios/include/sysio.bios/sysio.bios.hpp): A simple alternative to the core contract which is suitable for test chains or perhaps centralized blockchains. (Note: this contract must be deployed to the privileged `sysio` account.)
* [token contract](contracts/sysio.token/include/sysio.token/sysio.token.hpp): A contract enabling fungible tokens.
* [core contract](contracts/sysio.system/include/sysio.system/sysio.system.hpp): A monolithic contract that includes a variety of different functions. Note: This contract must be deployed to the privileged `sysio` account. Additionally, this contract requires that the token contract is deployed to the `sysio.token` account and has already been used to setup the core token.) The functions contained within this monolithic contract include (non-exhaustive):
   + Appointed Proof of Stake (APoS) consensus mechanism for selecting and paying (via core token inflation) a set of Node Operators that are chosen through delegation of the staked core tokens.
   + Allocation of CPU/NET resources based on core tokens in which the core tokens are either staked for an indefinite allocation of some fraction of available CPU/NET resources, or they are paid as a fee in exchange for a time-limited allocation of CPU/NET resources via ROA.
   + An automated market maker enabling a market for RAM resources which allows users to buy or sell available RAM allocations.
   + An auction for bidding for premium account names.
* [multisig contract](contracts/sysio.msig/include/sysio.msig/sysio.msig.hpp): A contract that enables proposing transactions on the blockchain, collecting authorization approvals for many accounts, and then executing the actions within the transaction after authorization requirements of the transaction have been reached. (Note: this contract must be deployed to a privileged account.)
* [wrap contract](contracts/sysio.wrap/include/sysio.wrap/sysio.wrap.hpp): A contract that wraps around any transaction and allows for executing its actions without needing to satisfy the authorization requirements of the transaction. If used, the permissions of the account hosting this contract should be configured to only allow highly trusted parties (e.g. the operators of the blockchain) to have the ability to execute its actions. (Note: this contract must be deployed to a privileged account.)

## Branches

The `main` branch contains the latest stable branch 


## Supported Operating Systems

[CDT](https://github.com/Wire-Network/wire-cdt) is required to build contracts. Any operating systems supported by CDT is sufficient to build the system contracts.

To build and run the tests as well, [Wire Sysio](https://github.com/Wire-Network/wire-sysio) is also required as a dependency, which may have its further restrictions on supported operating systems.


## Building

The build guide below will assume you are running Ubuntu 20.04 and 22.04. However, as mentioned above, other operating systems may also be supported.

### Build or install CDT dependency

The CDT dependency is required. This release of the system contracts requires at least version 3.0 of CDT. 

At the moment, we only support building from source for CDT. Please refer to the guide in the [CDT README](https://github.com/Wire-Network/wire-cdt#building-from-source) for instructions on how to do this. 

It is important to keep the path to the build directory in the shell environment variable `CDT_BUILD_PATH` for later use when building the system contracts.

### Optionally build Wire Sysio dependency

The Wire Sysio dependency is optional and it is only needed if you wish to build the tests using the `BUILD_TESTS` CMake flag.

If want to build the contract tests, you will first need to build [Wire Sysio](https://github.com/Wire-Network/wire-sysio) from source.

Please refer to the guide in the [Wire Sysio README](https://github.com/Wire-Network/wire-sysio) for instructions on how to do this. Please keep the path to the build directory in the shell environment variable `WIRE_SYSIO_BUILD_PATH` for later use when building the system contracts.

### Build system contracts

#### Prerequisites ####

Before proceeding with the instructions below, please ensure the following prerequisites are met:

1. **Wire Sysio Built from Source**: You should have already built Wire Sysio from source on your system.
2. **CDT Dependency**: Ensure that the Wire Contract Development Toolkit (CDT) is installed on your system.
3. **System Contracts with Tests**: The instructions assume that you are building the system contracts with tests included.

For configurations that differ from the above, please refer to the additional details provided in the expandable panels located further down in this section.
For all configurations, you should first `cd` into the directory containing cloned system contracts repository.

Build system contracts with tests using Wire Sysio built from source and with installed CDT package:

```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON -Dwire_sysio_DIR="${WIRE_SYSIO_BUILD_PATH}/lib/cmake/wire-sysio" ..
make -j $(nproc)
```

**Note:** `CMAKE_BUILD_TYPE` has no impact on the WASM files generated for the contracts. It only impacts how the test binaries are built. Use `-DCMAKE_BUILD_TYPE=Debug` if you want to create test binaries that you can debug.

<details>
<summary>Build system contracts with tests using Wire Sysio and CDT both built from source</summary>

```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON -Dcdt_DIR="${CDT_BUILD_PATH}/lib/cmake/cdt" -Dwire_sysio_DIR="${WIRE_SYSIO_BUILD_PATH}/lib/cmake/wire-sysio" ..
make -j $(nproc)
```
</details>

<details>
<summary>Build system contracts without tests and with CDT build from source</summary>

```
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -Dcdt_DIR="${CDT_BUILD_PATH}/lib/cmake/cdt" ..
make -j $(nproc)
```

</details>

#### Supported CMake options

The following is a list of custom CMake options supported in building the system contracts (default values are shown below):

```
-DBUILD_TESTS=OFF                       Do not build the tests

-DSYSTEM_CONFIGURABLE_WASM_LIMITS=ON    Enable use of the CONFIGURABLE_WASM_LIMITS
                                        protocol feature

-DSYSTEM_BLOCKCHAIN_PARAMETERS=ON       Enable use of the BLOCKCHAIN_PARAMETERS
                                        protocol feature
```

### Running tests

Assuming you built with `BUILD_TESTS=ON`, you can run the tests.

```
cd build/tests
ctest -j $(nproc)
```
