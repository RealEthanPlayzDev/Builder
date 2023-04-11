--!strict
--[[
File name: Attribute.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
A resolvable for setting a attribute while building instances.
--]]

--// Superclass
local Resolvable = require(script.Parent)

--// Class
local Attribute = {}
Attribute.__index = Attribute
Attribute.__type = "Attribute"
Attribute.__extends = { "Resolvable" }
setmetatable(Attribute, Resolvable)
function Attribute:Resolve(inst, value: any)
	if (typeof(inst) == "Instance") then
		if (typeof(value) == "table") and (typeof(value["IsA"]) == "function") then
			if value:IsA("State") or value:IsA("DynamicState") then
				inst:SetAttribute(self.Target, value:Get())
				if value:IsA("State") then
					value.OnChanged:Connect(function(value: any)
						inst:SetAttribute(self.Target, value)
						return
					end)
				end
			end
		else
			inst:SetAttribute(self.Target, value)
		end
	else
		assert(false, "Attribute not supported for "..tostring(inst).." (not Instance)")
	end
	return
end

local function constructor_Attribute(attributename: string): Attribute
    return setmetatable({
        Target = attributename;
    }, Attribute)
end

export type Attribute = typeof(constructor_Attribute(""))

return constructor_Attribute