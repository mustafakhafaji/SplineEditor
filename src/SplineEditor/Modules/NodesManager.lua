local NodeManager = {}

local CoreGui = game:GetService('CoreGui')
local UserInputService = game:GetService("UserInputService")

local Modules = script.Parent
local Node = require(Modules.Node)

local Gui = script.Parent.Parent.Gui
local Graphbackground = Gui.soemthing

local _nodes = {}
local _selectedNode = nil

--[[

left and right most nodes 
always exist
only controlled on y axis

]]

-- PRIVATE

function addNode(): ()

    local x
    local y
    local serial

    local node = Node.new(x, y, serial)

    node.MouseButton1Down:Connect(function()
        selectNode(serial)
    end)

    -- Update lines for serial-1 to serial and serial to serial+1

    table.insert(_nodes, serial, node)
end


function updateSelectedNodePosition()
    -- Set position to mouse's
end


function selectNode(serial: number): ()
    
end


function deleteNode(): ()
    
    if not _selectedNode then
        return
    end

    
end


function enableNodeHover(): ()

end


function disableNodeHover(): ()

end


-- EVENTS

Graphbackground.MouseButton1Click:Connect(addNode)
Graphbackground.MouseEnter:Connect(enableNodeHover)
Graphbackground.MouseLeave:Connect(disableNodeHover)


return NodeManager