local KeyboardHandler = {}

local UserInputService = game:GetService("UserInputService")

local Modules = script.Parent
local HistoryManager = require(Modules.HistoryManager)

-- PRIVATE

function handleInputBegan(input: InputObject, isTyping: boolean): ()
    if 
        isTyping 
        or input.UserInputType ~= Enum.UserInputType.Keyboard 
    then
        return
    end

    if input.KeyCode == Enum.KeyCode.Z then
        HistoryManager.undo()

    elseif input.KeyCode == Enum.KeyCode.Y then
        HistoryManager.redo()
    end
end

-- EVENTS

UserInputService.InputBegan:Connect(handleInputBegan)

return KeyboardHandler