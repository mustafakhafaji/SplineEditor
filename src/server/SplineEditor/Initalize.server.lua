local Modules = script.Parent.Modules
local test = require(Modules.Test)

local Toolbar = plugin:CreateToolbar('SplineEditor')
local PluginButton = Toolbar:CreateButton('SplineEditor', 'Create & export spline piecewise functions', '')

local isActive = false

function handlePluginButtonClick()
    if isActive then

        test.deactivate()
        isActive = false
    else
        
        test.activate()
        isActive = true
    end
end
--[[

structure

module for visuals
module for logic


left side, list of splines



]]


PluginButton.Click:Connect(handlePluginButtonClick)