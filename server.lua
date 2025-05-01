----
-- [[ RegisterServerCallback(name, cb) ]]
----

-- Example 1: RegisterServerCallback - Get player money
exports.infinity_core:RegisterServerCallback('infinity_test:getPlayerMoney', function(source, cb)
    local playerMoney = 1000 -- Simulated for example
    cb(playerMoney)
end)

-- Example 2: RegisterServerCallback - Check item possession
exports.infinity_core:RegisterServerCallback('infinity_test:hasItem', function(source, cb, itemName)
    local hasItem = true -- Simulated for example
    cb(hasItem)
end)

-- Command to test async client callback
RegisterCommand('test_async', function(source)
    local playerId = source
    
    -- Example with basic TriggerClientCallback
    exports.infinity_core:TriggerClientCallback(playerId, 'infinity_test:getPosition', function(position)
        print(string.format('Player position: x=%s, y=%s, z=%s', position.x, position.y, position.z))
    end)
end)

-- Command to test client callback with timeout and error handling
RegisterCommand('test_timeout', function(source)
    local playerId = source
    
    -- Example with timeout and error callback
    exports.infinity_core:TriggerClientCallback(playerId, 'infinity_test:longAction',
        function(result)
            print('Action successful:', result)
        end,
        nil, -- no additional parameters
        5000, -- 5-second timeout
        function()
            print('Error: Action took too long')
        end
    )
end)

-- Command to test TriggerSyncClientCallback
RegisterCommand('test_sync', function(source)
    local playerId = source
    
    -- Example with TriggerSyncClientCallback
    local result = exports.infinity_core:TriggerSyncClientCallback(playerId, 'infinity_test:getHealth')
    print('Player health:', result)
end)

-- Command to test TriggerAwaitClientCallback
RegisterCommand('test_await', function(source)
    local playerId = source
    
    -- Example with TriggerSyncClientCallback in a thread
    Citizen.CreateThread(function()
        local inventory = exports.infinity_core:TriggerSyncClientCallback(playerId, 'infinity_test:getInventory')
        print('Player inventory:', json.encode(inventory))
    end)
end)


RegisterNetEvent('infinity_test:add_item_with_meta')
AddEventHandler('infinity_test:add_item_with_meta', function(item, quantity, meta)
    local _src = source
    exports.infinity_needs:AddInventoryItem(_src, item, quantity, 1, true, meta)
end)