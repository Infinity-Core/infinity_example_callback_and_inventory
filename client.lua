----
-- [[ RegisterClientCallback(name, cb) ]]
----

-- Get player position
exports.infinity_core:RegisterClientCallback('infinity_test:getPosition', function(cb)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    cb(coords)
end)

-- Simulate a long action
exports.infinity_core:RegisterClientCallback('infinity_test:longAction', function(cb)
    -- Simulate long processing
    Wait(3000)
    cb('Action completed successfully')
end)

-- Get player health
exports.infinity_core:RegisterClientCallback('infinity_test:getHealth', function(cb)
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    cb(health)
end)

-- Get player inventory
exports.infinity_core:RegisterClientCallback('infinity_test:getInventory', function(cb)
    -- Simulate inventory data for testing
    local inventory = {
        items = {
            {name = 'pain', quantity = 2},
            {name = 'eau', quantity = 3},
            {name = 'pomme', quantity = 1}
        },
        weight = 6,
        maxWeight = 30
    }
    cb(inventory)
end)

-- Inventory Management Commands
-- Command to close inventory
RegisterCommand('closeinv', function()
    exports.infinity_needs:OpenInventory(false)
end, false)

-- Command to open inventory with player source
RegisterCommand('openinvtest', function()
    local source = GetPlayerServerId(PlayerId())
    exports.infinity_needs:OpenInventory(true, source)
end, false)

-- Inventory Test Commands with Metadata
-- Test adding an item with unique metadata
RegisterCommand('test_meta_item', function()
    local meta = { serial = 'ABC1234', quality = 99, custom = 'CascadeTest' }
    TriggerServerEvent('infinity_test:add_item_with_meta', 'water', 1, meta)
end, false)

-- Test adding a water item with specific metadata (80% full)
RegisterCommand('test_water_item', function()
    local meta = { water = '80%' }
    TriggerServerEvent('infinity_test:add_item_with_meta', 'water', 1, meta)
end, false)

-- Display metadata of items in inventory
RegisterCommand('show_meta', function()
    exports.infinity_core:TriggerServerCallback('infinity_needs:getPlayerInventory', function(inventory)
        for _, item in pairs(inventory) do
            if item.meta then
                TriggerEvent('chat:addMessage', {
                    color = {255, 255, 0},
                    multiline = true,
                    args = {"[META]", ("Item: %s | Meta: %s"):format(item.name, json.encode(item.meta))}
                })
            end
        end
    end)
end, false)

-- Server Callback Test Commands
-- Example of an asynchronous server callback to get player money
RegisterCommand('test_server_async', function()
    exports.infinity_core:TriggerServerCallback('infinity_test:getPlayerMoney', function(money)
        print('Player Money:', money)
    end)
end, false)

-- Example of server callback call (sync)
RegisterCommand('test_server_sync', function()
    Citizen.CreateThread(function()
        local hasItem = exports.infinity_core:TriggerAwaitServerCallback('infinity_test:hasItem', 'bread')
        print('Player has bread:', hasItem)
    end)
end, false)

-- Notification to inform that callbacks are ready
Citizen.CreateThread(function()
    Wait(1000) -- Wait for everything to be initialized
    print('^2[INFINITY TEST]^7 Client callbacks ready!')
    
    -- Test instructions
    print('^3To test callbacks, use these commands:^7')
    print('/test_async - Test async callback (position)')
    print('/test_timeout - Test callback with timeout')
    print('/test_sync - Test sync callback (health)')
    print('/test_await - Test callback with await (inventory)')
    print('/test_server_async - Test async server call')
    print('/test_server_sync - Test sync server call')
end)
