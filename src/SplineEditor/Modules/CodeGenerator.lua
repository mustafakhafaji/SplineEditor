local CodeGenerator = {}

local Modules = script.Parent
local Node = require(Modules.Node) 

--[[

Given anchor points
Given control points

Generate code

]]

local functions = [[
function connectPoints(points: {a: Node.Node, b: Node.Node})
    
    for t = 1, MAX_T do

        local position = Vector2.new()

        position.x = (1 - t) * points.a.x + t * points.b.x
        position.y = (1 - t) * points.a.y + t * points.b.y
    end
end


function connectCubicCurve(anchorNodes: {a: Node.Node, b: Node.Node}, controlNodes: {[number]: Node.Node})

    for t = 1, MAX_T do

        local position = Vector2.new()

        position.x = (1 - t) ^ 2 * anchorNodes.a.x + 2 * (1 - t) * t * controlNodes[1].x + t ^ 2 * anchorNodes.b.x
        position.y = (1 - t) ^ 2 * anchorNodes.a.y + 2 * (1 - t) * t * controlNodes[1].y + t ^ 2 * anchorNodes.b.y
    end
end


function connectQuadraticCurve(anchorNodes: {a: Node.Node, b: Node.Node}, controlNodes: {[number]: Node.Node})

    for t = 1, MAX_T do

        local position = Vector2.new()

        position.x = (1 - t) ^ 3 * anchorNodes.a.x + 3 * (1 - t) ^ 2 * t * controlNodes[1].x + 3 * (1 - t) * t ^ 2 * controlNodes[2].x + t ^ 3 * anchorNodes.b.x
        position.y = (1 - t) ^ 3 * anchorNodes.a.y + 3 * (1 - t) ^ 2 * t * controlNodes[1].y + 3 * (1 - t) * t ^ 2 * controlNodes[2].y + t ^ 3 * anchorNodes.b.y
    end
end
]]

function CodeGenerator.generate(anchorNodes: {[number]: Node.Node}, controlNodes: {[number]: Node.Node}): ()

    local code = functions

    for i, anchorNode in ipairs(anchorNodes) do
        

        code += ""
    end
end

return CodeGenerator