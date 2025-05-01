# Infinity Test Callback

This resource provides a complete example of using the Infinity Core callback system. It demonstrates various ways to use callbacks between client and server.

## Installation

1. Ensure `infinity_core` is installed.
2. Place the `infinity_test_callback` folder in your `resources` directory.
3. Add `ensure infinity_test_callback` to your `server.cfg`.

## Available Examples

### Server Side (`server.lua`)

#### Registered Server Callbacks
- `infinity_test:getPlayerMoney`: Simulates fetching a player's money.
- `infinity_test:hasItem`: Simulates checking if a player has a specific item.

#### Test Commands (Server to Client)
- `/test_async`: Tests asynchronous client callback (fetching position).
- `/test_timeout`: Tests callback with a timeout (5s) and error handling.
- `/test_sync`: Tests synchronous client callback (fetching health).
- `/test_await`: Tests client callback with await (fetching inventory).

### Client Side (`client.lua`)

#### Registered Client Callbacks
- `infinity_test:getPosition`: Fetches the player's position.
- `infinity_test:longAction`: Simulates a long action (3 seconds).
- `infinity_test:getHealth`: Fetches the player's health.
- `infinity_test:getInventory`: Simulates an inventory.

#### Test Commands (Client to Server)
- `/test_server_async`: Tests asynchronous server callback (fetching money).
- `/test_server_sync`: Tests synchronous server callback (checking for item).

#### Inventory Management Commands
- `/closeinv`: Closes the inventory.
- `/openinvtest`: Opens the inventory with player source.

#### Inventory Test Commands with Metadata
- `/test_meta_item`: Tests adding an item with unique metadata.
- `/test_water_item`: Tests adding a water item with specific metadata (80% full).
- `/show_meta`: Displays metadata of items in the inventory.

## Usage Guide

### Registering a Callback (Server)
```lua
exports.infinity_core:RegisterServerCallback('name:callback', function(source, cb, ...)
    -- Your code here
    cb(result)
end)
```

### Registering a Callback (Client)
```lua
exports.infinity_core:RegisterClientCallback('name:callback', function(cb, ...)
    -- Your code here
    cb(result)
end)
```

### Calling a Server Callback from Client
#### Asynchronous Method
```lua
exports.infinity_core:TriggerServerCallback('name:callback', function(result)
    -- Process the result
end, param1, param2)
```

#### Synchronous Method (Await)
```lua
Citizen.CreateThread(function()
    local result = exports.infinity_core:TriggerAwaitServerCallback('name:callback', param1, param2)
    -- Process the result
end)
```

### Calling a Client Callback from Server
#### Asynchronous Method
```lua
exports.infinity_core:TriggerClientCallback(playerId, 'name:callback', function(result)
    -- Process the result
end, param1, param2, timeout, errorCallback)
```

#### Synchronous Method
```lua
local result = exports.infinity_core:TriggerSyncClientCallback(playerId, 'name:callback', param1, param2, timeout)
-- Process the result
```

## Important Notes

1. Asynchronous callbacks are recommended for non-blocking operations.
2. Synchronous callbacks should be used within a Citizen thread.
3. Proper timeout handling is crucial to avoid blocking.
4. Use error callbacks to handle failure cases.

## Support

For any questions or issues, please contact the Infinity Core team.
