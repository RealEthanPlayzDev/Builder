--!strict
--[[
File name: Cleaner.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 20, 2022

This script is a part of Builder.
A class for handling cleanups of objects, connections, and custom classes. Similar to one of Quenty's NevermoreEngine libraries, Maid.
--]]

--// Utils
local Utils = require(script.Parent.Utils)
local RESignal = Utils.RESignal

--// Default destroy function names
--// ClassName = "DestroyMethodName";
local DefaultDestroyFunctionNames = {
    Instance = "Destroy";
    RBXScriptConnection = "Disconnect";
}

--// Class
local Cleaner = {}
Cleaner.__index = Cleaner
Cleaner.__type = "Cleaner"
Cleaner.__tostring = function(self) return self.__type end
Cleaner.__metatable = "This metatable is locked"
Cleaner.IsA = Utils.IsA

function Cleaner:Add(... : any)
    local Objects = {...}
    for _, obj in ipairs(Objects) do
        if (typeof(obj) == "table") then
            for _, o in pairs(obj) do
                local DestroyFunctionName = DefaultDestroyFunctionNames[typeof(o)] or "Destroy"
                self.Objects[o] = DestroyFunctionName
                self.OnObjectAdded:Fire(o, DestroyFunctionName)
            end
        else
            local DestroyFunctionName = DefaultDestroyFunctionNames[typeof(obj)] or "Destroy"
            self.Objects[obj] = DestroyFunctionName
            self.OnObjectAdded:Fire(obj, DestroyFunctionName)
        end
    end
    return
end

function Cleaner:Remove(... : any)
    local Objects = {...}
    for _, obj in ipairs(Objects) do
        if (typeof(obj) == "table") then
            for _, o in pairs(obj) do
                self.OnObjectRemoving:Fire(o)
                self.Objects[o] = nil
            end
        else
            self.OnObjectRemoving:Fire(obj)
            self.Objects[obj] = nil
        end
    end
end

function Cleaner:Clean()
    self.OnCleanup:Fire(self.Objects)
    for obj, destroyfunc in pairs(self.Objects) do
        self.OnObjectCleaning:Fire(obj, destroyfunc)
        obj[destroyfunc](obj)
        self.Objects[obj] = nil
    end
    return
end

local function constructor_Cleaner(... : any)
    local CleanupObjects = {...}
    return setmetatable({
        Objects = CleanupObjects;
        OnCleanup = RESignal.new(RESignal.SignalBehavior.NewThread);
        OnObjectCleaning = RESignal.new(RESignal.SignalBehavior.NewThread);
        OnObjectAdded = RESignal.new(RESignal.SignalBehavior.NewThread);
        OnObjectRemoving = RESignal.new(RESignal.SignalBehavior.NewThread);
    }, Cleaner)
end

export type Cleaner = typeof(constructor_Cleaner())

return constructor_Cleaner