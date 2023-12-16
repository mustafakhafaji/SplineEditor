local NodeManager = {}

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Modules = script.Parent
local Node = require(Modules.Node)
local History = require(Modules.History)

local Gui = script.Parent.Parent.Gui
local ScreenGui = Gui.ScreenGui 
local PluginFrame = ScreenGui.PluginFrame
local GraphTextButton = PluginFrame.GraphTextButton
local PsuedoNodeTextButton = Gui.PsuedoNodeTextButton

local _hoveringConnection: RBXScriptConnection

local _nodes: {[number]: Node.Node} = {} -- Store left and right base nodes
local _selectedNode: Node.Node = nil

--[[

left and right most nodes 
always exist
only controlled on y axis

]]

-- PRIVATE

function determineNewSerial(x: number): (number)

    local serial = 0

    for i, node in ipairs(_nodes) do

        if x > node.x then
            serial = i
        end
    end

    return serial + 1
end


function updateSelectedNodePosition()
    -- Set position to mouse's
    -- Update serial

    --[[local mousePosition = UserInputService:GetMouseLocation()

    local newSerial = determineNewSerial(mousePosition)

    Node.updateData(_selectedNode, mousePosition.X, mousePosition.Y, newSerial)]]
end


function selectNode(serial: number): ()

    if _selectedNode then

        if serial == _selectedNode.serial then
            return
        end

        Node.unselect(_selectedNode)
    end

    _selectedNode = _nodes[serial]
    Node.select(_selectedNode)
end


function getLocalMouseLocation(): (number, number)

    local mouseLocation = UserInputService:GetMouseLocation()

    local absolutePosition = PluginFrame.AbsolutePosition
    local absoluteSize = PluginFrame.AbsoluteSize

    local leftX = absolutePosition.X - absoluteSize.X / 2
    local rightX = absolutePosition.X + absoluteSize.X / 2

    local topY = absolutePosition.Y - absoluteSize.Y / 2
    local bottomY =  absolutePosition.Y + absoluteSize.Y / 2

    local xRange = rightX - leftX
    local yRange = bottomY - topY

    -- Math wizardy, gets x y location relative local to graph
    local x = ((mouseLocation.X - leftX) * 100 / xRange) - 50
    local y = 150 - ((mouseLocation.Y - topY) * 100 / yRange)

    return x, y
end


function selectClosestNode(): ()

    local x, y = getLocalMouseLocation()

    local closestNode = _nodes[1]
    local closestDistance = (closestNode.x - x) ^ 2 + (closestNode.y - y) ^ 2

    for i = 2, #_nodes do

        local currentNode = _nodes[i]   
        local currentDistance = (currentNode.x - x) ^ 2 + (currentNode.y - y) ^ 2

        if currentDistance < closestDistance then
            closestDistance = currentDistance
            closestNode = currentNode
        end
    end

    selectNode(closestNode.serial)
end


function movePsuedoNode(): ()

    local x, y = getLocalMouseLocation() 

    if 
        x < 0 
        or y < 0
        or x > 100
        or y > 100
    then
        PsuedoNodeTextButton.BackgroundTransparency = 1
        return
    end

    PsuedoNodeTextButton.BackgroundTransparency = 0
    PsuedoNodeTextButton.Position = UDim2.new(x / 100, 0, (100 - y) / 100, 0)
end


function enableNodeHover(): ()

    _hoveringConnection = RunService.Heartbeat:Connect(function()

        selectClosestNode()
        movePsuedoNode()
    end)
    
    -- Psuedo node gui
    -- Psuedo lines
end


function disableNodeHover(): ()

    if _selectedNode then
        Node.unselect(_selectedNode)
    end

    _hoveringConnection:Disconnect()
    -- Delete psuedo node & lines gui
end


function connectNodeFunctions(node: Node.Node): ()

    node.nodeGui.MouseButton1Down:Connect(function()
        -- Move node
    end)
end


function handleGraphClick()

    local x, y = getLocalMouseLocation()
    
    NodeManager.addNode(x, y)
end


function initBaseNodes()
    
    local leftBaseNode = Node.new(0, 0, 1)
    local rightBaseNode = Node.new(100, 0, 2)

    table.insert(_nodes, leftBaseNode)
    table.insert(_nodes, rightBaseNode)

    connectNodeFunctions(leftBaseNode)
    connectNodeFunctions(rightBaseNode)
end


function NodeManager.moveNode(x: number, y: number): ()

end


--[[ 
    y = 0 represents bottom of graph
    y = 100 represents top of graph
    x = 0 represents left of graph
    x = 100 represents right of graph
    ]]
function NodeManager.addNode(x: number, y: number): ()

    x = math.clamp(math.round(x), 1, 99) -- To not override the base nodes' serial
    y = math.round(y)

    local serial = determineNewSerial(x)

    -- Update others nodes
    for i = serial, #_nodes do
        _nodes[i].serial += 1
        -- Update UI name?
    end

    local node: Node.Node = Node.new(x, y, serial)
    table.insert(_nodes, serial, node)

    selectNode(serial)
    connectNodeFunctions(node)

    -- Update lines for serial-1 to serial and serial to serial+1

    -- Click between p2 and p3
    -- Erase p2p3 line - line 2
    -- Add p3
    -- Update serials of p4+
    -- Draw p2p3 and p3p4

    History.recordAction({
        action = "addNode",
        x = x,
        y = y
    })
end


function NodeManager.deleteNode(): ()
    
    if not _selectedNode then
        return
    end

    History.recordAction({
        action = "deleteNode",
        x = _selectedNode.x,
        y = _selectedNode.y
    })

    -- Delete p3
    -- Delete p2p3 and p3p4 line
    -- Draw p2p4 line
    -- Update serials

    for i = _selectedNode.serial, #_nodes do
        _nodes[i].serial -= 1
    end
end


function NodeManager.enable(): ()
    enableNodeHover()
end


function NodeManager.disable(): ()
    disableNodeHover()
end


-- EVENTS

GraphTextButton.MouseButton1Click:Connect(handleGraphClick)

-- INIT
initBaseNodes()

return NodeManager