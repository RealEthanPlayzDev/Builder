--!nocheck
--[[
File name: Event.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A resolvable for calling a method while building instances.
--]]

--// Superclass
local Resolvable = require(script.Parent)

--// Class
local Method = {}
Method.__index = Method
Method.__type = "Method"
Method.__extends = { "Resolvable" }
setmetatable(Method, Resolvable)
function Method:Resolve(inst, value: {any})
	if (typeof(inst) == "Instance") or (typeof(inst) == "table") or (typeof(inst) == "userdata") then
		assert(typeof(inst[self.Target]) == "function", "Method not supported for "..tostring(inst).." (function does not exist)")
		inst[self.Target](inst, table.unpack(value))
	else
		assert(false, "Method not supported for "..tostring(inst).." (not Instance/table/userdata)")
	end
	return
end

local function constructor_Method(methodname: string): Method
    return setmetatable({
        Target = methodname;
    }, Method)
end

export type Method = typeof(constructor_Method(""))

return constructor_Method