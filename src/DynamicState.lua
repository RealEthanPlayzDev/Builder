--!strict
--[[
File name: DynamicState.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A object to store a value, like a variable, but this version calls a function everytime DynamicState:Get() is called
--]]

local Utils = require(script.Parent.Utils)

local DynamicState = {}
DynamicState.__index = DynamicState
DynamicState.__type = "DynamicState"
DynamicState.__tostring = function(self) return self.__type end
DynamicState.__metatable = "This metatable is locked"
DynamicState.IsA = Utils.IsA

function DynamicState:Get()
	return self.Function()
end

local function constructor_DynamicState(f: () -> (any)): DynamicState
    return setmetatable({
        Function = f;
    }, DynamicState)
end

export type DynamicState = typeof(constructor_DynamicState(function() return end))

return constructor_DynamicState