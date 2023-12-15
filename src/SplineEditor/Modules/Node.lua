local Node = {}

local Gui = script.Parent.Parent.Gui
local NodeGui = Gui.NodeTextButton

-- PRIVATE

function generateNodeGui(x: number, y: number, serial: number): (GuiBase)

    local nodeGuiClone = NodeGui:Clone()

    nodeGuiClone.Position.X.Scale = x
    nodeGuiClone.Position.X.Scale = y
    nodeGuiClone.Name = serial

    return nodeGuiClone
end


-- PUBLIC

function Node.new(x: number, y: number, serial: number): ({})

    local node = {}

    node.x = x
    node.y = y
    node.serial = serial
    node.nodeGui = generateNodeGui(x, y, serial)

    return node
end

return Node