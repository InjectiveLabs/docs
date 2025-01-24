# - Permissions

Permissions module provides an extra layer of configuration for all actions related to tokens: mint, transfer and burn.


## NamespaceDenoms

Defines a gRPC query method that returns the denoms for which a namespace exists

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/1_NamespaceDenoms.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/1_NamespaceDenoms/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


### Response Parameters
> Response Example:

``` json
{
  "denoms": [
    "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/reR"
  ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryNamespaceDenomsResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## Namespaces

Defines a gRPC query method that returns the permissions module's created namespaces

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/2_Namespaces.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/2_Namespaces/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


### Response Parameters
> Response Example:

``` json
{
 "namespaces": [
  {
   "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/reR",
   "role_permissions": [
    {
     "name": "EVERYONE",
     "permissions": 8
    },
    {
     "name": "Admin",
     "role_id": 1,
     "permissions": 2013265951
    },
    {
     "name": "Minter",
     "role_id": 2,
     "permissions": 3
    },
    {
     "name": "OtherMinter",
     "role_id": 3,
     "permissions": 1
    },
    {
     "name": "Receiver",
     "role_id": 4,
     "permissions": 2
    },
    {
     "name": "SenderAndReceiver",
     "role_id": 5,
     "permissions": 10
    },
    {
     "name": "Burner",
     "role_id": 6,
     "permissions": 4
    },
    {
     "name": "SuperBurner",
     "role_id": 7,
     "permissions": 16
    },
    {
     "name": "ModifyPolicyManagers",
     "role_id": 8,
     "permissions": 134217728
    },
    {
     "name": "ModifyContractHook",
     "role_id": 9,
     "permissions": 268435456
    },
    {
     "name": "ModifyRoleManagers",
     "role_id": 10,
     "permissions": 1073741824
    },
    {
     "name": "ModifyRolePermission",
     "role_id": 11,
     "permissions": 536870912
    },
    {
     "name": "TestToModify",
     "role_id": 12,
     "permissions": 5
    },
    {
     "name": "TestToModify2",
     "role_id": 13,
     "permissions": 7
    },
    {
     "name": "TestToModify3",
     "role_id": 14,
     "permissions": 15
    },
    {
     "name": "Blacklisted",
     "role_id": 15
    }
   ],
   "actor_roles": [
    {
     "actor": "inj1q82aa323r2vxha9mvsz5nvhc0h6unh2duk48gc",
     "roles": [
      "ModifyRolePermission"
     ]
    },
    {
     "actor": "inj1yv7jzmzcxusrvnaj86mjg59x4nc05wtz93tyhv",
     "roles": [
      "SenderAndReceiver"
     ]
    },
    {
     "actor": "inj1y5vuaw7qvltxp6vmynaf74d0gfgduk3c494x0q",
     "roles": [
      "ModifyPolicyManagers"
     ]
    },
    {
     "actor": "inj188dcnc89c5lvxvhxegju722jsnz3huls6sdw3r",
     "roles": [
      "TestToModify2",
      "OtherMinter"
     ]
    },
    {
     "actor": "inj1gxx3mkvrymyw5u7mdrnzjl6q8vcgvj85kfghkg",
     "roles": [
      "TestToModify"
     ]
    },
    {
     "actor": "inj1g5xj7flevr9nqn068wtenhjtlagpm3kd7hgq2x",
     "roles": [
      "Receiver"
     ]
    },
    {
     "actor": "inj12maj7ndrm0ytumcffd4hrl7jk05du69axnjndz",
     "roles": [
      "Burner",
      "Receiver"
     ]
    },
    {
     "actor": "inj1dku85qn8cs2648trk74kluck286sphrvhrfpfe",
     "roles": [
      "ModifyContractHook"
     ]
    },
    {
     "actor": "inj10zyguxjt3m0yfq4ae5s6flvudyqaev2p2nxzv7",
     "roles": [
      "SuperBurner",
      "Receiver"
     ]
    },
    {
     "actor": "inj1sn9yc5e27sd9c6334ufresn9356narlz0s9vdq",
     "roles": [
      "Receiver"
     ]
    },
    {
     "actor": "inj14enjvrdza0m495q77nk6cnl3c9r0u06wsugkdc",
     "roles": [
      "Receiver"
     ]
    },
    {
     "actor": "inj1kuhunpk695kn93twqhfvamg4tx2lcjafpmgx5s",
     "roles": [
      "TestToModify3"
     ]
    },
    {
     "actor": "inj1cr2jzsgmw4tf4t82nk7hskxpcsvd9c84nyy5rg",
     "roles": [
      "SenderAndReceiver"
     ]
    },
    {
     "actor": "inj16jtcqsyng98wk7fu87wpzgyx59ghle980cjrp8",
     "roles": [
      "Blacklisted"
     ]
    },
    {
     "actor": "inj16nj2c4j2e7scq8r5xkkgdjmwhpv7mw0trtjapf",
     "roles": [
      "SenderAndReceiver"
     ]
    },
    {
     "actor": "inj1mhgedl8exqca4mnmmh0r3tsgxcvz8kgj2tjukf",
     "roles": [
      "OtherMinter"
     ]
    },
    {
     "actor": "inj1az9uh3ytwcgjyy9akspdtaerfqca7jswfupgd7",
     "roles": [
      "ModifyRoleManagers"
     ]
    },
    {
     "actor": "inj1a0cl5hagkcncjsylsqryk8rze9m56gda60f68s",
     "roles": [
      "Blacklisted"
     ]
    },
    {
     "actor": "inj1aj6yxg97ynvyewdyf76q47yn49f6t622ftmud6",
     "roles": [
      "Minter"
     ]
    },
    {
     "actor": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "roles": [
      "Admin"
     ]
    }
   ],
   "role_managers": [
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "roles": [
      "EVERYONE",
      "Admin",
      "Minter",
      "OtherMinter",
      "Receiver",
      "SenderAndReceiver",
      "Burner",
      "SuperBurner",
      "ModifyPolicyManagers",
      "ModifyContractHook",
      "ModifyRoleManagers",
      "ModifyRolePermission",
      "TestToModify",
      "TestToModify2",
      "TestToModify3",
      "Blacklisted"
     ]
    }
   ],
   "policy_statuses": [
    {
     "action": 134217728
    },
    {
     "action": 268435456
    },
    {
     "action": 536870912
    },
    {
     "action": 1073741824
    },
    {
     "action": 1
    },
    {
     "action": 2
    },
    {
     "action": 4
    },
    {
     "action": 8
    },
    {
     "action": 16
    }
   ],
   "policy_manager_capabilities": [
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 134217728,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 268435456,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 536870912,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 1073741824,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 1,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 2,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 4,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 8,
     "can_disable": true,
     "can_seal": true
    },
    {
     "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
     "action": 16,
     "can_disable": true,
     "can_seal": true
    }
   ]
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryNamespacesResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Namespace**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/namespace.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/role.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ActorRole**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actorRole.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/roleManager.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyStatus.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyManagerCapability.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Actions**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actions.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## Namespace

Defines a gRPC query method that returns the permissions module's namespace associated with the provided denom

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/3_Namespace.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/3_Namespace/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryNamespaceRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "namespace": {
  "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/reR",
  "role_permissions": [
   {
    "name": "EVERYONE",
    "permissions": 8
   },
   {
    "name": "Admin",
    "role_id": 1,
    "permissions": 2013265951
   },
   {
    "name": "Minter",
    "role_id": 2,
    "permissions": 3
   },
   {
    "name": "OtherMinter",
    "role_id": 3,
    "permissions": 1
   },
   {
    "name": "Receiver",
    "role_id": 4,
    "permissions": 2
   },
   {
    "name": "SenderAndReceiver",
    "role_id": 5,
    "permissions": 10
   },
   {
    "name": "Burner",
    "role_id": 6,
    "permissions": 4
   },
   {
    "name": "SuperBurner",
    "role_id": 7,
    "permissions": 16
   },
   {
    "name": "ModifyPolicyManagers",
    "role_id": 8,
    "permissions": 134217728
   },
   {
    "name": "ModifyContractHook",
    "role_id": 9,
    "permissions": 268435456
   },
   {
    "name": "ModifyRoleManagers",
    "role_id": 10,
    "permissions": 1073741824
   },
   {
    "name": "ModifyRolePermission",
    "role_id": 11,
    "permissions": 536870912
   },
   {
    "name": "TestToModify",
    "role_id": 12,
    "permissions": 5
   },
   {
    "name": "TestToModify2",
    "role_id": 13,
    "permissions": 7
   },
   {
    "name": "TestToModify3",
    "role_id": 14,
    "permissions": 15
   },
   {
    "name": "Blacklisted",
    "role_id": 15
   }
  ],
  "actor_roles": [
   {
    "actor": "inj1q82aa323r2vxha9mvsz5nvhc0h6unh2duk48gc",
    "roles": [
     "ModifyRolePermission"
    ]
   },
   {
    "actor": "inj1yv7jzmzcxusrvnaj86mjg59x4nc05wtz93tyhv",
    "roles": [
     "SenderAndReceiver"
    ]
   },
   {
    "actor": "inj1y5vuaw7qvltxp6vmynaf74d0gfgduk3c494x0q",
    "roles": [
     "ModifyPolicyManagers"
    ]
   },
   {
    "actor": "inj188dcnc89c5lvxvhxegju722jsnz3huls6sdw3r",
    "roles": [
     "TestToModify2",
     "OtherMinter"
    ]
   },
   {
    "actor": "inj1gxx3mkvrymyw5u7mdrnzjl6q8vcgvj85kfghkg",
    "roles": [
     "TestToModify"
    ]
   },
   {
    "actor": "inj1g5xj7flevr9nqn068wtenhjtlagpm3kd7hgq2x",
    "roles": [
     "Receiver"
    ]
   },
   {
    "actor": "inj12maj7ndrm0ytumcffd4hrl7jk05du69axnjndz",
    "roles": [
     "Burner",
     "Receiver"
    ]
   },
   {
    "actor": "inj1dku85qn8cs2648trk74kluck286sphrvhrfpfe",
    "roles": [
     "ModifyContractHook"
    ]
   },
   {
    "actor": "inj10zyguxjt3m0yfq4ae5s6flvudyqaev2p2nxzv7",
    "roles": [
     "SuperBurner",
     "Receiver"
    ]
   },
   {
    "actor": "inj1sn9yc5e27sd9c6334ufresn9356narlz0s9vdq",
    "roles": [
     "Receiver"
    ]
   },
   {
    "actor": "inj14enjvrdza0m495q77nk6cnl3c9r0u06wsugkdc",
    "roles": [
     "Receiver"
    ]
   },
   {
    "actor": "inj1kuhunpk695kn93twqhfvamg4tx2lcjafpmgx5s",
    "roles": [
     "TestToModify3"
    ]
   },
   {
    "actor": "inj1cr2jzsgmw4tf4t82nk7hskxpcsvd9c84nyy5rg",
    "roles": [
     "SenderAndReceiver"
    ]
   },
   {
    "actor": "inj16jtcqsyng98wk7fu87wpzgyx59ghle980cjrp8",
    "roles": [
     "Blacklisted"
    ]
   },
   {
    "actor": "inj16nj2c4j2e7scq8r5xkkgdjmwhpv7mw0trtjapf",
    "roles": [
     "SenderAndReceiver"
    ]
   },
   {
    "actor": "inj1mhgedl8exqca4mnmmh0r3tsgxcvz8kgj2tjukf",
    "roles": [
     "OtherMinter"
    ]
   },
   {
    "actor": "inj1az9uh3ytwcgjyy9akspdtaerfqca7jswfupgd7",
    "roles": [
     "ModifyRoleManagers"
    ]
   },
   {
    "actor": "inj1a0cl5hagkcncjsylsqryk8rze9m56gda60f68s",
    "roles": [
     "Blacklisted"
    ]
   },
   {
    "actor": "inj1aj6yxg97ynvyewdyf76q47yn49f6t622ftmud6",
    "roles": [
     "Minter"
    ]
   },
   {
    "actor": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "roles": [
     "Admin"
    ]
   }
  ],
  "role_managers": [
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "roles": [
     "EVERYONE",
     "Admin",
     "Minter",
     "OtherMinter",
     "Receiver",
     "SenderAndReceiver",
     "Burner",
     "SuperBurner",
     "ModifyPolicyManagers",
     "ModifyContractHook",
     "ModifyRoleManagers",
     "ModifyRolePermission",
     "TestToModify",
     "TestToModify2",
     "TestToModify3",
     "Blacklisted"
    ]
   }
  ],
  "policy_statuses": [
   {
    "action": 134217728
   },
   {
    "action": 268435456
   },
   {
    "action": 536870912
   },
   {
    "action": 1073741824
   },
   {
    "action": 1
   },
   {
    "action": 2
   },
   {
    "action": 4
   },
   {
    "action": 8
   },
   {
    "action": 16
   }
  ],
  "policy_manager_capabilities": [
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 134217728,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 268435456,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 536870912,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 1073741824,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 1,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 2,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 4,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 8,
    "can_disable": true,
    "can_seal": true
   },
   {
    "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
    "action": 16,
    "can_disable": true,
    "can_seal": true
   }
  ]
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryNamespaceResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Namespace**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/namespace.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/role.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ActorRole**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actorRole.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/roleManager.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyStatus.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyManagerCapability.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Actions**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actions.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## RolesByActor

Defines a gRPC query method that returns roles for the actor in the namespace

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/4_RolesByActor.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/4_RolesByActor/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryRolesByActorRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "roles": [
  "ModifyRolePermission"
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryRolesByActorResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

## ActorsByRole

Defines a gRPC query method that returns a namespace's roles associated with the provided actor

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/5_ActorsByRole.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/5_ActorsByRole/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryActorsByRoleRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "actors": [
  "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z"
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryActorsByRoleResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## RoleManagers

Defines a gRPC query method that returns a namespace's role managers

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/6_RoleManagers.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/6_RoleManagers/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryRoleManagersRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "role_managers": [
  {
   "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
   "roles": [
    "EVERYONE",
    "Admin",
    "Minter",
    "OtherMinter",
    "Receiver",
    "SenderAndReceiver",
    "Burner",
    "SuperBurner",
    "ModifyPolicyManagers",
    "ModifyContractHook",
    "ModifyRoleManagers",
    "ModifyRolePermission",
    "TestToModify",
    "TestToModify2",
    "TestToModify3",
    "Blacklisted"
   ]
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryRoleManagersResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/roleManager.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## RoleManager

Defines a gRPC query method that returns the roles a given role manager manages for a given namespace

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/7_RoleManager.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/7_RoleManager/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryRoleManagerRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "role_manager": {
  "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
  "roles": [
   "EVERYONE",
   "Admin",
   "Minter",
   "OtherMinter",
   "Receiver",
   "SenderAndReceiver",
   "Burner",
   "SuperBurner",
   "ModifyPolicyManagers",
   "ModifyContractHook",
   "ModifyRoleManagers",
   "ModifyRolePermission",
   "TestToModify",
   "TestToModify2",
   "TestToModify3",
   "Blacklisted"
  ]
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryRoleManagerResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/roleManager.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## PolicyStatuses

Defines a gRPC query method that returns a namespace's policy statuses

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/8_PolicyStatuses.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/8_PolicyStatuses/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryPolicyStatusesRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "policy_statuses": [
  {
   "action": 134217728
  },
  {
   "action": 268435456
  },
  {
   "action": 536870912
  },
  {
   "action": 1073741824
  },
  {
   "action": 1
  },
  {
   "action": 2
  },
  {
   "action": 4
  },
  {
   "action": 8
  },
  {
   "action": 16
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryPolicyStatusesResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyStatus.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Actions**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actions.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## PolicyManagerCapabilities

Defines a gRPC query method that returns a namespace's policy manager capabilities

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/9_PolicyManagerCapabilities.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/9_PolicyManagerCapabilities/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryPolicyManagerCapabilitiesRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
{
 "policy_statuses": [
  {
   "action": 134217728
  },
  {
   "action": 268435456
  },
  {
   "action": 536870912
  },
  {
   "action": 1073741824
  },
  {
   "action": 1
  },
  {
   "action": 2
  },
  {
   "action": 4
  },
  {
   "action": 8
  },
  {
   "action": 16
  }
 ]
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryPolicyManagerCapabilitiesResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyManagerCapability.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Actions**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actions.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## Vouchers

Defines a gRPC query method for the vouchers for a given denom

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/10_Vouchers.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/10_Vouchers/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryVouchersRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryVouchersResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AddressVoucher**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/addressVoucher.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/coin.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## Voucher

Defines a gRPC query method for the vouchers for a given denom and address

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/11_Voucher.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/11_Voucher/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryVoucherRequest.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json

```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryVoucherResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/coin.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## PermissionsModuleState

Retrieves the entire permissions module's state

**IP rate limit group:** `chain`

### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/query/12_PermissionsModuleState.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/query/12_PermissionsModuleState/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

No parameters


### Response Parameters
> Response Example:

``` json
{
 "state": {
  "params": {
   "wasm_hook_query_max_gas": 200000
  },
  "namespaces": [
   {
    "denom": "factory/inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z/reR",
    "role_permissions": [
     {
      "name": "EVERYONE",
      "permissions": 8
     },
     {
      "name": "Admin",
      "role_id": 1,
      "permissions": 2013265951
     },
     {
      "name": "Minter",
      "role_id": 2,
      "permissions": 3
     },
     {
      "name": "OtherMinter",
      "role_id": 3,
      "permissions": 1
     },
     {
      "name": "Receiver",
      "role_id": 4,
      "permissions": 2
     },
     {
      "name": "SenderAndReceiver",
      "role_id": 5,
      "permissions": 10
     },
     {
      "name": "Burner",
      "role_id": 6,
      "permissions": 4
     },
     {
      "name": "SuperBurner",
      "role_id": 7,
      "permissions": 16
     },
     {
      "name": "ModifyPolicyManagers",
      "role_id": 8,
      "permissions": 134217728
     },
     {
      "name": "ModifyContractHook",
      "role_id": 9,
      "permissions": 268435456
     },
     {
      "name": "ModifyRoleManagers",
      "role_id": 10,
      "permissions": 1073741824
     },
     {
      "name": "ModifyRolePermission",
      "role_id": 11,
      "permissions": 536870912
     },
     {
      "name": "TestToModify",
      "role_id": 12,
      "permissions": 5
     },
     {
      "name": "TestToModify2",
      "role_id": 13,
      "permissions": 7
     },
     {
      "name": "TestToModify3",
      "role_id": 14,
      "permissions": 15
     },
     {
      "name": "Blacklisted",
      "role_id": 15
     }
    ],
    "actor_roles": [
     {
      "actor": "inj1q82aa323r2vxha9mvsz5nvhc0h6unh2duk48gc",
      "roles": [
       "ModifyRolePermission"
      ]
     },
     {
      "actor": "inj1yv7jzmzcxusrvnaj86mjg59x4nc05wtz93tyhv",
      "roles": [
       "SenderAndReceiver"
      ]
     },
     {
      "actor": "inj1y5vuaw7qvltxp6vmynaf74d0gfgduk3c494x0q",
      "roles": [
       "ModifyPolicyManagers"
      ]
     },
     {
      "actor": "inj188dcnc89c5lvxvhxegju722jsnz3huls6sdw3r",
      "roles": [
       "TestToModify2",
       "OtherMinter"
      ]
     },
     {
      "actor": "inj1gxx3mkvrymyw5u7mdrnzjl6q8vcgvj85kfghkg",
      "roles": [
       "TestToModify"
      ]
     },
     {
      "actor": "inj1g5xj7flevr9nqn068wtenhjtlagpm3kd7hgq2x",
      "roles": [
       "Receiver"
      ]
     },
     {
      "actor": "inj12maj7ndrm0ytumcffd4hrl7jk05du69axnjndz",
      "roles": [
       "Burner",
       "Receiver"
      ]
     },
     {
      "actor": "inj1dku85qn8cs2648trk74kluck286sphrvhrfpfe",
      "roles": [
       "ModifyContractHook"
      ]
     },
     {
      "actor": "inj10zyguxjt3m0yfq4ae5s6flvudyqaev2p2nxzv7",
      "roles": [
       "SuperBurner",
       "Receiver"
      ]
     },
     {
      "actor": "inj1sn9yc5e27sd9c6334ufresn9356narlz0s9vdq",
      "roles": [
       "Receiver"
      ]
     },
     {
      "actor": "inj14enjvrdza0m495q77nk6cnl3c9r0u06wsugkdc",
      "roles": [
       "Receiver"
      ]
     },
     {
      "actor": "inj1kuhunpk695kn93twqhfvamg4tx2lcjafpmgx5s",
      "roles": [
       "TestToModify3"
      ]
     },
     {
      "actor": "inj1cr2jzsgmw4tf4t82nk7hskxpcsvd9c84nyy5rg",
      "roles": [
       "SenderAndReceiver"
      ]
     },
     {
      "actor": "inj16jtcqsyng98wk7fu87wpzgyx59ghle980cjrp8",
      "roles": [
       "Blacklisted"
      ]
     },
     {
      "actor": "inj16nj2c4j2e7scq8r5xkkgdjmwhpv7mw0trtjapf",
      "roles": [
       "SenderAndReceiver"
      ]
     },
     {
      "actor": "inj1mhgedl8exqca4mnmmh0r3tsgxcvz8kgj2tjukf",
      "roles": [
       "OtherMinter"
      ]
     },
     {
      "actor": "inj1az9uh3ytwcgjyy9akspdtaerfqca7jswfupgd7",
      "roles": [
       "ModifyRoleManagers"
      ]
     },
     {
      "actor": "inj1a0cl5hagkcncjsylsqryk8rze9m56gda60f68s",
      "roles": [
       "Blacklisted"
      ]
     },
     {
      "actor": "inj1aj6yxg97ynvyewdyf76q47yn49f6t622ftmud6",
      "roles": [
       "Minter"
      ]
     },
     {
      "actor": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "roles": [
       "Admin"
      ]
     }
    ],
    "role_managers": [
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "roles": [
       "EVERYONE",
       "Admin",
       "Minter",
       "OtherMinter",
       "Receiver",
       "SenderAndReceiver",
       "Burner",
       "SuperBurner",
       "ModifyPolicyManagers",
       "ModifyContractHook",
       "ModifyRoleManagers",
       "ModifyRolePermission",
       "TestToModify",
       "TestToModify2",
       "TestToModify3",
       "Blacklisted"
      ]
     }
    ],
    "policy_statuses": [
     {
      "action": 134217728
     },
     {
      "action": 268435456
     },
     {
      "action": 536870912
     },
     {
      "action": 1073741824
     },
     {
      "action": 1
     },
     {
      "action": 2
     },
     {
      "action": 4
     },
     {
      "action": 8
     },
     {
      "action": 16
     }
    ],
    "policy_manager_capabilities": [
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 134217728,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 268435456,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 536870912,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 1073741824,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 1,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 2,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 4,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 8,
      "can_disable": true,
      "can_seal": true
     },
     {
      "manager": "inj17gkuet8f6pssxd8nycm3qr9d9y699rupv6397z",
      "action": 16,
      "can_disable": true,
      "can_seal": true
     }
    ]
   }
  ]
 }
}
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/queryModuleStateResponse.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**GenesisState**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/genesisState.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Params**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/params.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Namespace**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/namespace.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**AddressVoucher**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/addressVoucher.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/role.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ActorRole**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actorRole.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/roleManager.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyStatus.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyManagerCapability.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Actions**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actions.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


<br/>

**Coin**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/coin.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


## CreateNamespace

Message to create a new namespace

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/1_MsgCreateNamespace.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/1_CreateNamespace/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/msgCreateNamespace.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">namespace</td><td class="type-td td_text">Namespace</td><td class="description-td td_text">The namespace information</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Namespace**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/namespace.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/role.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ActorRole**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actorRole.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/roleManager.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyStatus.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyManagerCapability.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Actions**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actions.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## UpdateNamespace

Message to update a namespace configuration

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/2_MsgUpdateNamespace.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain_client/permissions/2_MsgUpdateNamespace.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/msgUpdateNamespace.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**MsgUpdateNamespace_SetContractHook**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/msgUpdateNamespace_SetContractHook.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Role**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/role.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleManager**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/roleManager.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyStatus**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyStatus.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**PolicyManagerCapability**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/policyManagerCapability.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Actions**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/actions.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## UpdateActorRoles

Message to update the roles assigned to an actor

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/3_MsgUpdateActorRoles.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/3_MsgUpdateActorRoles/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/msgUpdateActorRoles.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**RoleActors**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/roleActors.json) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


### Response Parameters
> Response Example:

``` json
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->


## ClaimVoucher

Message to claim existing vouchers for a particular address

**IP rate limit group:** `chain`


### Request Parameters
> Request Example:

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-python/raw/master/examples/chain_client/permissions/4_MsgClaimVoucher.py) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://github.com/InjectiveLabs/sdk-go/raw/master/examples/chain/permissions/4_MsgClaimVoucher/example.go) -->
<!-- MARKDOWN-AUTO-DOCS:END -->

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/permissions/msgClaimVoucher.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th><th class="required-th">Required</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">sender</td><td class="type-td td_text">String</td><td class="description-td td_text">The sender's Injective address</td><td class="required-td td_text">Yes</td></tr>
<tr ><td class="parameter-td td_text">denom</td><td class="type-td td_text">String</td><td class="description-td td_text">The token denom of the voucher to claim</td><td class="required-td td_text">Yes</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

### Response Parameters
> Response Example:

``` json
```

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/tx/broadcastTxResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="paramter-th">Paramter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="paramter-td td_text">tx_response</td><td class="type-td td_text">TxResponse</td><td class="description-td td_text">Transaction details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**TxResponse**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/txResponse.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">height</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The block height</td></tr>
<tr ><td class="parameter-td td_text">tx_hash</td><td class="type-td td_text">String</td><td class="description-td td_text">Transaction hash</td></tr>
<tr ><td class="parameter-td td_text">codespace</td><td class="type-td td_text">String</td><td class="description-td td_text">Namespace for the code</td></tr>
<tr ><td class="parameter-td td_text">code</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Response code (zero for success, non-zero for errors)</td></tr>
<tr ><td class="parameter-td td_text">data</td><td class="type-td td_text">String</td><td class="description-td td_text">Bytes, if any</td></tr>
<tr ><td class="parameter-td td_text">raw_log</td><td class="type-td td_text">String</td><td class="description-td td_text">The output of the application's logger (raw string)</td></tr>
<tr ><td class="parameter-td td_text">logs</td><td class="type-td td_text">ABCIMessageLog Array</td><td class="description-td td_text">The output of the application's logger (typed)</td></tr>
<tr ><td class="parameter-td td_text">info</td><td class="type-td td_text">String</td><td class="description-td td_text">Additional information</td></tr>
<tr ><td class="parameter-td td_text">gas_wanted</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas requested for the transaction</td></tr>
<tr ><td class="parameter-td td_text">gas_used</td><td class="type-td td_text">Integer</td><td class="description-td td_text">Amount of gas consumed by the transaction</td></tr>
<tr ><td class="parameter-td td_text">tx</td><td class="type-td td_text">Any</td><td class="description-td td_text">The request transaction bytes</td></tr>
<tr ><td class="parameter-td td_text">timestamp</td><td class="type-td td_text">String</td><td class="description-td td_text">Time of the previous block. For heights > 1, it's the weighted median of the timestamps of the valid votes in the block.LastCommit. For height == 1, it's genesis time</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">Event Array</td><td class="description-td td_text">Events defines all the events emitted by processing a transaction. Note, these events include those emitted by processing all the messages and those emitted from the ante. Whereas Logs contains the events, with additional metadata, emitted only by processing the messages.</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**ABCIMessageLog**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/abciMessageLog.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">msg_index</td><td class="type-td td_text">Integer</td><td class="description-td td_text">The message index</td></tr>
<tr ><td class="parameter-td td_text">log</td><td class="type-td td_text">String</td><td class="description-td td_text">The log message</td></tr>
<tr ><td class="parameter-td td_text">events</td><td class="type-td td_text">StringEvent Array</td><td class="description-td td_text">Event objects that were emitted during the execution</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Event**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/event.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">EventAttribute Array</td><td class="description-td td_text">All event object details</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**StringEvent**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/stringEvent.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">type</td><td class="type-td td_text">String</td><td class="description-td td_text">Event type</td></tr>
<tr ><td class="parameter-td td_text">attributes</td><td class="type-td td_text">Attribute Array</td><td class="description-td td_text">Event data</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**EventAttribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/eventAttribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr>
<tr ><td class="parameter-td td_text">index</td><td class="type-td td_text">Boolean</td><td class="description-td td_text">If attribute is indexed</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->

<br/>

**Attribute**

<!-- MARKDOWN-AUTO-DOCS:START (JSON_TO_HTML_TABLE:src=./source/json_tables/chain/attribute.json) -->
<table class="JSON-TO-HTML-TABLE"><thead><tr><th class="parameter-th">Parameter</th><th class="type-th">Type</th><th class="description-th">Description</th></tr></thead><tbody ><tr ><td class="parameter-td td_text">key</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute key</td></tr>
<tr ><td class="parameter-td td_text">value</td><td class="type-td td_text">String</td><td class="description-td td_text">Attribute value</td></tr></tbody></table>
<!-- MARKDOWN-AUTO-DOCS:END -->
