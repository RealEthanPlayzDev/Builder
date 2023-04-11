--!strict
--[[
File name: Descriptor.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A object containing the description of a object used to build instances.
--]]

--// Utils
local Utils = require(script.Parent.Utils)

--// Resolvables
local Attribute = require(script.Parent.Resolvable.Attribute)
local AttributeChangedSignal = require(script.Parent.Resolvable.AttributeChangedSignal)
local Event = require(script.Parent.Resolvable.Event)
local Method = require(script.Parent.Resolvable.Method)
local MultiStateResolvable = require(script.Parent.Resolvable.MultiStateResolvable)
local PropertyChangedSignal = require(script.Parent.Resolvable.PropertyChangedSignal)

--// Class
local Descriptor = {}
Descriptor.__index = Descriptor
Descriptor.__type = "Descriptor"
Descriptor.__tostring = function(self) return self.__type end
Descriptor.__metatable = "This metatable is locked"
Descriptor.IsA = Utils.IsA

function Descriptor:Build()
	local PreventTimeout = Utils.CreateTimeoutPreventer()
	local Inst = Utils.InstanceNewWrapped(self.Class, self.CustomClassesLocation)
	for property, value in pairs(self.Description) do
		PreventTimeout()
		if (typeof(property) == "string") then
			if (typeof(value["IsA"]) == "function") then
				if value:IsA("State") or value:IsA("DynamicState") then
					Inst[property] = value:Get()
					if value:IsA("State") then
						value.OnChanged:Connect(function(value: any)
							Inst[property] = value
							return
						end)
					end
				elseif value:IsA("MultiStateResolvable") then
					value:Resolve(Inst, property)
				end
			else
				Inst[property] = value
			end
			continue
		elseif (typeof(value) == "Instance") and (typeof(property) == nil) then
			value.Parent = Inst
			continue
		elseif (typeof(value) == "table") and (typeof(value["IsA"]) == "function") and value:IsA("Descriptor") then
			value:Build().Parent = Inst
			continue
		elseif (typeof(property) == "table") and (typeof(property["IsA"]) == "function") and property:IsA("Resolvable") then
			property:Resolve(Inst, value)
			continue
		end
	end
	return Inst
end

local function constructor_Descriptor(classname: string, description: Description?, customclasseslocation: Instance?): Descriptor
	return setmetatable({
		Class = classname;
		Description = description or {};
		CustomClassesLocation = customclasseslocation;
	}, Descriptor)
end

export type Descriptor = typeof(constructor_Descriptor(""))
export type Description = {[string | number | Event.Event | Method.Method | PropertyChangedSignal.PropertyChangedSignal | Attribute.Attribute | AttributeChangedSignal.AttributeChangedSignal | MultiStateResolvable.MultiStateResolvable]: any}

return constructor_Descriptor