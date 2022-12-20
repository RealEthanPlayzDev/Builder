--!strict
--[[
File name: MultiState.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A object to store multiple states attached to a key/name.
--]]

--// Utils
local Utils = require(script.Parent.Utils)
local RESignal = Utils.RESignal

--// Class
local MultiState = {}
MultiState.__index = MultiState
MultiState.__type = "MultiState"
MultiState.__tostring = function(self) return self.__type end
MultiState.__metatable = "This metatable is locked"
MultiState.IsA = Utils.IsA

function MultiState:Get(name: any)
	return self.States[name]
end

function MultiState:Set(name: any, value: any)
	local OldValue = self.States[name]
	self.States[name] = value
	self.OnChanged:Fire(name, value, OldValue)
	return
end

local function constructor_MultiState(initialstates: {[any]: any}?): MultiState
    local InitialStates do
        if typeof(initialstates) == "table" then
            InitialStates = initialstates
        else
            InitialStates = {}
        end
    end
    return setmetatable({
        States = InitialStates;
        OnChanged = RESignal.new(RESignal.SignalBehavior.NewThread);
    }, MultiState)
end

export type MultiState = typeof(constructor_MultiState())

return constructor_MultiState