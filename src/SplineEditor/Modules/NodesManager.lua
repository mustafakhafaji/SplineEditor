local NodeManager = {}

local CoreGui = game:GetService('CoreGui')
local UserInputService = game:GetService("UserInputService")

local Modules = script.Parent
local Node = require(Modules.Node)

local Gui = script.Parent.Parent.Gui
local PluginFrame = Gui.PluginFrame
local GraphFrame = PluginFrame.GraphFrame

local _nodes: {[number]: Node.Node} = {}
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


function addNode(): ()

    local mouseLocation = UserInputService:GetMouseLocation()

    -- Convert mouse location to 0-1

    local x = mouseLocation.X
    local y = mouseLocation.Y
    local serial = determineNewSerial(x)

    local node = Node.new(x, y, serial)

    node.MouseButton1Down:Connect(function()
        selectNode(serial)
    end)

    -- Update lines for serial-1 to serial and serial to serial+1

    -- Click between p2 and p3
    -- Erase p2p3 line - line 2
    -- Add p3
    -- Update serials of p4+
    -- Draw p2p3 and p3p4

    for i = serial, #_nodes do
        _nodes[i].serial += 1
    end

    table.insert(_nodes, serial, node)
end


function updateSelectedNodePosition()
    -- Set position to mouse's
    -- Update serial

    local mousePosition = UserInputService:GetMouseLocation()

    local newSerial = determineNewSerial(mousePosition)

    Node.updateData(_selectedNode, mousePosition.X, mousePosition.Y, newSerial)
end


function selectNode(serial: number): ()

    _selectedNode = _nodes[serial]
end


function deleteNode(): ()
    
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


function enableNodeHover(): ()

    -- Psuedo node gui
    -- Psuedo lines
end


function disableNodeHover(): ()

    -- Delete psuedo node & lines gui
end


-- EVENTS

GraphFrame.MouseButton1Click:Connect(addNode)
GraphFrame.MouseEnter:Connect(enableNodeHover)
GraphFrame.MouseLeave:Connect(disableNodeHover)


return NodeManager