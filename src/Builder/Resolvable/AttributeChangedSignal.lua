--!strict
--[[
File name: AttributeChangedSignal.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A resolvable for hooking attribute changes while building instances.
--]]

--// Superclass
local Resolvable = require(script.Parent)

--// Class
local AttributeChangedSignal = {}
AttributeChangedSignal.__index = AttributeChangedSignal
AttributeChangedSignal.__type = "AttributeChangedSignal"
AttributeChangedSignal.__extends = { "Resolvable" }
setmetatable(AttributeChangedSignal, Resolvable)
function AttributeChangedSignal:Resolve(inst, value: (...any) -> (...any))
	if (typeof(inst) == "Instance") then
		inst:GetAttributeChangedSignal(self.Target):Connect(value)
	else
		assert(false, "AttributeChangedSignal not supported for "..tostring(inst).." (not Instance)")
	end
	return
end

local function constructor_AttributeChangedSignal(attributename: string): AttributeChangedSignal
    return setmetatable({
        Target = attributename;
    }, AttributeChangedSignal)
end

export type AttributeChangedSignal = typeof(constructor_AttributeChangedSignal(""))

return constructor_AttributeChangedSignal