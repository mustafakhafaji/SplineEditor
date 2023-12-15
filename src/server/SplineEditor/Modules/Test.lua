local a = {}

local CoreGui = game:GetService('CoreGui')

local Modules = script.Parent

local Gui = script.Parent.Parent.Gui
local ScreenGui = Gui.ScreenGui

function a.activate()
    ScreenGui.Parent = CoreGui
end

function a.deactivate()
    ScreenGui.Parent = script
end

return a