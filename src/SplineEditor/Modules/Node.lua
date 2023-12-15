local Node = {}

local Gui = script.Parent.Parent.Gui
local NodeGui = Gui.NodeTextButton
local PluginFrame = Gui.PluginFrame
local GraphFrame = PluginFrame.GraphFrame
local NodesFrame = GraphFrame.NodesFrame
local SelectedCenterLineFrame = Gui.SelectedCenterLineFrame
local SelectedNodeUIStroke = Gui.SelectedNodeUIStroke

local _selectedNodeColor = Color3.fromRGB(226, 96, 98)
local _defaultNodeColor = Color3.fromRGB(199, 118, 118)

export type Node = {
    x: number,
    y: number, 
    serial: number, 
    nodeGui: TextButton
}

-- PRIVATE

function generateNodeGui(x: number, y: number, serial: number): (TextButton)

    local nodeGuiClone = NodeGui:Clone()

    nodeGuiClone.Position.X.Scale = x
    nodeGuiClone.Position.X.Scale = y
    nodeGuiClone.Name = serial

    nodeGuiClone.Position = UDim2.new(x, 0, y, 0)
    nodeGuiClone.Parent = NodesFrame

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

    if node.nodeGui:FindFirstChild('SelectedCenterLineFrame') then
        node.nodeGui:FindFirstChild('SelectedCenterLineFrame'):Destroy()
        node.nodeGui:FindFirstChild('SelectedNodeUIStroke'):Destroy()
    end
end


return Node