local HistoryManager = {}

local Modules = script.Parent
local History = Modules.History


--[[

Recordable actions:

- Place node
- Delete node
- Move node

]]


-- PUBLIC

function executeAction(action: {}): ()

    

    History.recordAction(action)
end


function HistoryManager.undo()

    local actionToUndo = History.popUndo()

    -- Find reverse action

    local reverseAction = {}

    executeAction(reverseAction)
end


function HistoryManager.redo()

    executeAction(History.popRedo())
end


return HistoryManager