--!strict
--[[
File name: PropertyChangedSignal.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A resolvable for hooking property changes while building instances.
--]]

--// Superclass
local Resolvable = require(script.Parent)

--// Class
local PropertyChangedSignal = {}
PropertyChangedSignal.__index = PropertyChangedSignal
PropertyChangedSignal.__type = "PropertyChangedSignal"
PropertyChangedSignal.__extends = { "Resolvable" }
setmetatable(PropertyChangedSignal, Resolvable)
function PropertyChangedSignal:Resolve(inst, value: (...any) -> (...any))
	if (typeof(inst) == "Instance") then
		inst:GetPropertyChangedSignal(self.Target):Connect(value)
	elseif (typeof(inst) == "table") or (typeof(inst) == "userdata") then
		assert(typeof(inst["GetPropertyChangedSignal"]) == "function", "PropertyChangedSignal not supported for "..tostring(inst).." (no GetPropertyChangedSignal function")
		inst:GetPropertyChangedSignal(self.Target):Connect(value)
	else
		assert(false, "PropertyChangedSignal not supported for "..tostring(inst).." (not Instance/table/userdata)")
	end
	return
end

local function constructor_PropertyChangedSignal(propertyname: string): PropertyChangedSignal
    return setmetatable({
        Target = propertyname;
    }, PropertyChangedSignal)
end

export type PropertyChangedSignal = typeof(constructor_PropertyChangedSignal(""))

return constructor_PropertyChangedSignal