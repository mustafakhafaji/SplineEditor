local Node = {}

local Gui = script.Parent.Parent.Gui
local NodeGui = Gui.NodeTextButton
local ScreenGui = Gui.ScreenGui
local PluginFrame = ScreenGui.PluginFrame
local GraphTextButton = PluginFrame.GraphTextButton
local NodesFrame = GraphTextButton.NodesFrame
local SelectedCenterLineFrame = Gui.SelectedCenterLineFrame
local SelectedNodeUIStroke = Gui.SelectedNodeUIStroke

local _selectedNodeColor = Color3.fromRGB(226, 96, 98)
local _defaultNodeColor = Color3.fromRGB(255, 255, 255)

export type Node = {
    x: number,
    y: number, 
    serial: number, 
    isBase: boolean?,
    nodeGui: TextButton
}

-- PRIVATE

function generateNodeGui(x: number, y: number, serial: number): (TextButton)

    local nodeGuiClone = NodeGui:Clone()

    nodeGuiClone.Position = UDim2.new(x / 100, 0, (100 - y) / 100, 0)
    nodeGuiClone.Name = serial

    nodeGuiClone.Parent = NodesFrame

    return nodeGuiClone
end


-- PUBLIC

function Node.new(x: number, y: number, serial: number, isBase: boolean?): (Node)

    local node = {}

    node.x = x
    node.y = y
    node.serial = serial
    node.isBase = isBase
    node.nodeGui = generateNodeGui(x, y, serial)

    return node
end


function Node.updateData(node: Node, x: number, y: number, serial: number): ()

    node.x = x
    node.y = y
    node.serial = serial

    node.nodeGui.Position.X.Scale = x
    node.nodeGui.Position.X.Scale = y
end


function Node.select(node: Node): ()

    node.nodeGui.BackgroundColor3 = _selectedNodeColor

    local selectedCenterLineFrameClone = SelectedCenterLineFrame:Clone()
    selectedCenterLineFrameClone.Parent = node.nodeGui

    local selectedNodeUIStrokeClone = SelectedCenterLineFrame:Clone()
    selectedNodeUIStrokeClone.Parent = node.nodeGui
end


function Node.unselect(node: Node): ()

    node.nodeGui.BackgroundColor3 = _defaultNodeColor

    for _, child in node.nodeGui:GetChildren() do
        child:Destroy()
    end
end


return Node