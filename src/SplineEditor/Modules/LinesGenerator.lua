local LinesManager = {}

local Modules = script.Parent
local Node = require(Modules.Node) 

export type line = {[number]: GuiBase}

local _lines: {[number]: line} = {}

local MAX_T = 100

--[[

TODO
- Create function determining any n degree bezier curves mathematically

]]


-- PRIVATE

function connectPoints(points: {a: Node.Node, b: Node.Node})
    
    for t = 1, MAX_T do

        local x = (1 - t) * points.a.x + t * points.b.x
        local y = (1 - t) * points.a.y + t * points.b.y
    end
end


function connectCubicCurve(anchorNodes: {a: Node.Node, b: Node.Node}, controlNodes: {[number]: Node.Node})

    for t = 1, MAX_T do

        local x = (1 - t) ^ 2 * anchorNodes.a.x + 2 * (1 - t) * t * controlNodes[1].x + t ^ 2 * anchorNodes.b.x
        local y = (1 - t) ^ 2 * anchorNodes.a.y + 2 * (1 - t) * t * controlNodes[1].y + t ^ 2 * anchorNodes.b.y
    end
end


function connectQuadraticCurve(anchorNodes: {a: Node.Node, b: Node.Node}, controlNodes: {[number]: Node.Node})

    for t = 1, MAX_T do

        local x = (1 - t) ^ 3 * anchorNodes.a.x + 3 * (1 - t) ^ 2 * t * controlNodes[1].x + 3 * (1 - t) * t ^ 2 * controlNodes[2].x + t ^ 3 * anchorNodes.b.x
        local y = (1 - t) ^ 3 * anchorNodes.a.y + 3 * (1 - t) ^ 2 * t * controlNodes[1].y + 3 * (1 - t) * t ^ 2 * controlNodes[2].y + t ^ 3 * anchorNodes.b.y
    end
end


-- PUBLIC

function LinesManager.connectNodes(anchorNodes: {a: Node.Node, b: Node.Node}, controlNodes: {[number]: Node.Node}): ()

    if #controlNodes == 0 then
        connectPoints(anchorNodes)

    elseif #controlNodes == 1 then
        connectCubicCurve(anchorNodes, controlNodes)

    elseif #controlNodes == 2 then
        connectQuadraticCurve(anchorNodes, controlNodes)

    else
        warn(`Too many control nodes in bezier curve, # of control nodes: {#controlNodes}`)
    end
end

return LinesManager