--!strict
--[[
File name: Utils.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
This is a superclass.
A object to resolve custom fields in descriptions.
--]]

local Utils = require(script.Parent.Utils)

local Resolvable = {}
Resolvable.__index = Resolvable
Resolvable.__type = "Resolvable"
Resolvable.__tostring = function(self) return self.__type end
Resolvable.__metatable = "This metatable is locked"
Resolvable.IsA = Utils.IsA
function Resolvable:Resolve(inst, value: any) return end

return Resolvable