local Modules = script.Parent.Modules
local Gui = script.Parent.Gui
local ScreenGui = Gui.ScreenGui
local PluginFrame = ScreenGui.PluginFrame
local TopbarFrame = PluginFrame.TopbarFrame
local CloseTextButton = TopbarFrame.CloseTextButton

require(Modules.KeyboardHandler)
require(Modules.NodesManager)

local Toolbar = plugin:CreateToolbar('SplineEditor')
local PluginButton = Toolbar:CreateButton('SplineEditor', 'Create & export spline piecewise functions', '')

local ScreenGui = Gui.ScreenGui

local isActive = false

function handlePluginButtonClick()
    isActive = not isActive
    ScreenGui.Enabled = isActive
end

-- EVENTS

PluginButton.Click:Connect(handlePluginButtonClick)
CloseTextButton.MouseButton1Click:Connect(handlePluginButtonClick)

-- Init
ScreenGui.Enabled = false
ScreenGui.Parent = game:GetService("CoreGui")