--!strict
--[[
File name: Event.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A resolvable for connecting to a event while building instances.
--]]

--// Superclass
local Resolvable = require(script.Parent)

--// Class
local Event = {}
Event.__index = Event
Event.__type = "Event"
Event.__extends = { "Resolvable" }
setmetatable(Event, Resolvable)
function Event:Resolve(inst, value: (...any) -> (...any))
	inst[self.Target]:Connect(value)
	return
end

local function constructor_Event(eventname: string): Event
    return setmetatable({
        Target = eventname;
    }, Event)
end

export type Event = typeof(constructor_Event(""))

return constructor_Event