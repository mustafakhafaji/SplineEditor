local History = {}

local _undoStack = {}
local _redoStack = {}

local MAX_RECORDED_ACTIONS = 50

export type Action = {
    action: "addNode" | "deleteNode" | "moveNode", 
    x: number?, 
    y: number?
}

-- PUBLIC

function History.recordAction(action: Action): ()

    if #_undoStack > MAX_RECORDED_ACTIONS then
        table.remove(_undoStack, 1)
    end

    table.insert(_undoStack, action)
end


function History.popUndo(): ({})

    local action = _undoStack[#_undoStack]

    table.remove(_undoStack, #_undoStack)
    table.insert(_redoStack, action)

    return action
end


function History.popRedo(): ({})

    local action = _redoStack[#_redoStack]

    table.remove(_redoStack, #_redoStack)

    return action
end


return History