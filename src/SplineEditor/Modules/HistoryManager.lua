local HistoryManager = {}

local Modules = script.Parent
local History = require(Modules.History) 
local NodesManager = require(Modules.NodesManager)

local reverseActions = {
    addNode = NodesManager.deleteNode,
    deleteNode = NodesManager.addNode,
    moveNode = NodesManager.moveNode,
}

--[[

Recordable actions:

- Place node
- Delete node
- Move node

]]


-- PUBLIC

function executeAction(action: History.Action): ()

    

    History.recordAction(action)
end


function HistoryManager.undo()

    local actionToUndo = History.popUndo()

    -- Find reverse action

    --local reverseAction: History.Action = {}

    --executeAction(reverseAction)
end


function HistoryManager.redo()

    --executeAction(History.popRedo())
end


return HistoryManager