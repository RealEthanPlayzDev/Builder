--!strict
--[[
File name: MultiStateResolvable.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A resolvable for using a state from a MultiState to set a property while building instances.
--]]

--// Superclass
local Resolvable = require(script.Parent)

--// MultiState type dependency
local MultiState = require(script.Parent.Parent.MultiState)

--// Class
local MultiStateResolvable = {}
MultiStateResolvable.__index = MultiStateResolvable
MultiStateResolvable.__type = "MultiStateResolvable"
MultiStateResolvable.__extends = { "Resolvable" }
setmetatable(MultiStateResolvable, Resolvable)
function MultiStateResolvable:Resolve(inst, property: string)
	inst[property] = self.MultiState:Get(self.Target)
	self.MultiState.OnChanged:Connect(function(name: any, value: any)
		if name == self.Target then
			inst[property] = value
		end
	end)
	return
end

local function constructor_MultiStateResolvable(multistate: MultiState.MultiState, statename: any)
    return setmetatable({
        Target = statename;
		MultiState = multistate;
    }, MultiStateResolvable)
end

export type MultiStateResolvable = typeof(constructor_MultiStateResolvable(MultiState(), ""))

return constructor_MultiStateResolvable