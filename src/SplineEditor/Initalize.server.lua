local Modules = script.Parent.Modules
local Gui = script.Parent.Gui

require(Modules.KeyboardHandler)

local Toolbar = plugin:CreateToolbar('SplineEditor')
local PluginButton = Toolbar:CreateButton('SplineEditor', 'Create & export spline piecewise functions', '')

local ScreenGui = Gui.ScreenGui

local isActive = false

function handlePluginButtonClick()
    isActive = not isActive
    ScreenGui.Enabled = isActive
end

PluginButton.Click:Connect(handlePluginButtonClick)