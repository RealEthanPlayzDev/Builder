--!strict
--[[
File name: State.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A object to store a value, like a variable
--]]

local Utils = require(script.Parent.Utils)
local RESignal = Utils.RESignal

local State = {}
State.__index = State
State.__type = "State"
State.__tostring = function(self) return self.__type end
State.__metatable = "This metatable is locked"
State.IsA = Utils.IsA

function State:Get()
	return self.Value
end

function State:Set(value: any)
	local OldValue = self.Value
	self.Value = value
	self.OnChanged:Fire(value, OldValue)
	return
end

local function constructor_State(value: any): State
    return setmetatable({
        Value = value;
        OnChanged = RESignal.new(RESignal.SignalBehavior.NewThread);
    }, State)
end

export type State = typeof(constructor_State())

return constructor_State