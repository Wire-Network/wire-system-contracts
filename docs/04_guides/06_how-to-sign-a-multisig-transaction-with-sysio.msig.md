---
title: How to sign a multisig transaction with sysio.msig
link_text: How to sign a multisig transaction with sysio.msig
---

### sysio.msig

### Prerequisites:
   - sysio.token contract installed to sysio.token account, sysio.msig contract installed on sysio.msig account which is a priviliged account.
   - account 'treasury' is the issuer of SYS token.
   - account 'tester' exists.
   - keys to accounts 'treasury' and 'tester' imported into local wallet, the wallet is unlocked.

### One user creates a proposal:
```sh
clio multisig propose test '[{"actor": "treasury", "permission": "active"}]' '[{"actor": "treasury", "permission": "active"}]' sysio.token issue '{"to": "tester", "quantity": "1000.0000 SYS", "memo": ""}' -p tester
```
```console
executed transaction: e26f3a3a7cba524a7b15a0b6c77c7daa73d3ba9bf84e83f9c2cdf27fcb183d61  336 bytes  107520 cycles
#    sysio.msig <= sysio.msig::propose          {"proposer":"tester","proposal_name":"test","requested":[{"actor":"treasury","permission":"active"}]...
```

### Another user reviews the transaction:
```sh
clio multisig review tester test
```
```json
{
  "proposal_name": "test",
  "requested_approvals": [{
      "actor": "treasury",
      "permission": "active"
    }
  ],
  "provided_approvals": [],
  "packed_transaction": "00aee75a0000000000000000000000000100a6823403ea30550000000000a5317601000000fe6a6cd4cd00000000a8ed323219000000005c95b1ca809698000000000004454f530000000000",
  "transaction": {
    "expiration": "2018-05-01T00:00:00",
    "region": 0,
    "ref_block_num": 0,
    "ref_block_prefix": 0,
    "max_net_usage_words": 0,
    "max_kcpu_usage": 0,
    "delay_sec": 0,
    "context_free_actions": [],
    "actions": [{
        "account": "sysio.token",
        "name": "issue",
        "authorization": [{
            "actor": "treasury",
            "permission": "active"
          }
        ],
        "data": {
          "to": "tester",
          "quantity": "1000.0000 SYS",
          "memo": ""
        },
        "hex_data": "000000005c95b1ca809698000000000004454f530000000000"
      }
    ]
  }
}
```

### And then approves it:
```sh
clio multisig approve tester test '{"actor": "treasury", "permission": "active"}' -p treasury
```
```console
executed transaction: 475970a4b0016368d0503d1ce01577376f91f5a5ba63dd4353683bd95101b88d  256 bytes  108544 cycles
#    sysio.msig <= sysio.msig::approve          {"proposer":"tester","proposal_name":"test","level":{"actor":"treasury","permission":"active"}}
```

### First user initiates execution:
```sh
clio multisig exec tester test -p tester
```
```console
executed transaction: 64e5eaceb77362694055f572ae35876111e87b637a55250de315b1b55e56d6c2  248 bytes  109568 cycles
#    sysio.msig <= sysio.msig::exec             {"proposer":"tester","proposal_name":"test","executer":"tester"}
```


## `clio` usage example for transferring tokens.

### Prerequisites:
   - sysio.token contract installed to sysio.token account, sysio.msig contract installed on sysio.msig account which is a priviliged account.
   - account 'treasury' has at least 1.1000 SYS token balance.
   - account 'tester' exists.
   - keys to accounts 'treasury' and 'tester' imported into local wallet, the wallet is unlocked.

### One user creates a proposal:
```sh
clio multisig propose test '[{"actor": "treasury", "permission": "active"}]' '[{"actor": "treasury", "permission": "active"}]' sysio.token transfer '{"from": "treasury", "to": "tester", "quantity": "1.0000 SYS", "memo": ""}' -p tester
```
```console
executed transaction: e26f3a3a7cba524a7b15a0b6c77c7daa73d3ba9bf84e83f9c2cdf27fcb183d61  336 bytes  107520 cycles
#    sysio.msig <= sysio.msig::propose          {"proposer":"tester","proposal_name":"test","requested":[{"actor":"treasury","permission":"active"}]...
```

### Another user reviews the transaction:
```sh
clio multisig review tester test
```
```json
{
  "proposal_name": "test",
  "requested_approvals": [{
      "actor": "treasury",
      "permission": "active"
    }
  ],
  "provided_approvals": [],
  "packed_transaction": "00aee75a0000000000000000000000000100a6823403ea30550000000000a5317601000000fe6a6cd4cd00000000a8ed323219000000005c95b1ca809698000000000004454f530000000000",
  "transaction": {
    "expiration": "2018-05-01T00:00:00",
    "region": 0,
    "ref_block_num": 0,
    "ref_block_prefix": 0,
    "max_net_usage_words": 0,
    "max_kcpu_usage": 0,
    "delay_sec": 0,
    "context_free_actions": [],
    "actions": [{
        "account": "sysio.token",
        "name": "transfer",
        "authorization": [{
            "actor": "treasury",
            "permission": "active"
          }
        ],
        "data": {
          "from": "treasury",
          "to": "tester",
          "quantity": "1.0000 SYS",
          "memo": ""
        },
        "hex_data": "000000005c95b1ca809698000000000004454f530000000000"
      }
    ]
  }
}
```

### And then approves it:
```sh
clio multisig approve tester test '{"actor": "treasury", "permission": "active"}' -p treasury
```
```console
executed transaction: 475970a4b0016368d0503d1ce01577376f91f5a5ba63dd4353683bd95101b88d  256 bytes  108544 cycles
#    sysio.msig <= sysio.msig::approve          {"proposer":"tester","proposal_name":"test","level":{"actor":"treasury","permission":"active"}}
```

### First user check account balance before executing the proposed transaction
```sh
clio get account tester
```
```console
...
SYS balances:
     liquid:            1.0487 SYS
     staked:            2.0000 SYS
     unstaking:         0.0000 SYS
     total:             4.0487 SYS
```

### First user initiates execution of proposed transaction:
```sh
clio multisig exec tester test -p tester
```
```console
executed transaction: 64e5eaceb77362694055f572ae35876111e87b637a55250de315b1b55e56d6c2  248 bytes  109568 cycles
#    sysio.msig <= sysio.msig::exec             {"proposer":"tester","proposal_name":"test","executer":"tester"}
```

### First user can check account balance, it should be increased by 1.0000 SYS
```sh
clio get account tester
```
```console
...
SYS balances:
     liquid:            2.0487 SYS
     staked:            2.0000 SYS
     unstaking:         0.0000 SYS
     total:             4.0487 SYS
```
