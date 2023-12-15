local NodeManager = {}

local CoreGui = game:GetService('CoreGui')
local UserInputService = game:GetService("UserInputService")

local Modules = script.Parent
local Node = require(Modules.Node)
local History = require(Modules.History)

local Gui = script.Parent.Parent.Gui
local ScreenGui = Gui.ScreenGui 
local PluginFrame = ScreenGui.PluginFrame
local GraphTextButton = PluginFrame.GraphTextButton

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


function enableNodeHover(): ()

    -- Psuedo node gui
    -- Psuedo lines
end


function disableNodeHover(): ()

    -- Delete psuedo node & lines gui
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

    node.nodeGui.MouseButton1Down:Connect(function()
        -- Move node
    end)

    node.nodeGui.MouseEnter:Connect(function()
        selectNode(node.serial)
    end)

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
    
    print(_nodes)
end


function NodeManager.deleteNode(): ()
    
    if not _selectedNode then
        return
    end

    -- Delete p3
    -- Delete p2p3 and p3p4 line
    -- Draw p2p4 line
    -- Update serials

    for i = _selectedNode.serial, #_nodes do
        _nodes[i].serial -= 1
    end
end


function handleGraphClick()

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
    
    NodeManager.addNode(x, y)
end


function initBaseNodes()
    
    local leftBaseNode = Node.new(0, 0, 1)
    local rightBaseNode = Node.new(100, 0, 2)

    table.insert(_nodes, leftBaseNode)
    table.insert(_nodes, rightBaseNode)
end


-- EVENTS

GraphTextButton.MouseButton1Click:Connect(handleGraphClick)
GraphTextButton.MouseEnter:Connect(enableNodeHover)
GraphTextButton.MouseLeave:Connect(disableNodeHover)

-- INIT
initBaseNodes()

return NodeManager