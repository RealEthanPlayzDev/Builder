--!nocheck
--// Library to be exported to the utils
local RESignal = require(script.Parent.RESignal)

--// Wrapper around Instance.new that just sets the type of the class to any (to prevent luau-lsp from complaining about overloads)
local function InstanceNew(class: any)
    return Instance.new(class)
end

--// Wrapper version of typeof that supports our own custom classes
local function TypeofWrapped(class: any): string
	if not class then return "nil" end
	if typeof(class) ~= "table" then return typeof(class) end
	if not class["__type"] then return typeof(class) end
	return class["__type"]
end

--// Static IsA handler
local function IsA(self: { __type: string, __extends: {string}? }, class: string): boolean
	if self.__extends then
		if table.find(self.__extends, class) then
			return true
		end
	end
	return class == self.__type
end

--// Static instance constructor to also handle constructing custom classes
local function InstanceNewWrapped(classname: string, customclasslocation: Instance?)
	local CustomClassLocation = customclasslocation or script:FindFirstChild("CustomClasses")
	if CustomClassLocation and CustomClassLocation:FindFirstChild(classname) and CustomClassLocation:FindFirstChild(classname):IsA("ModuleScript") then
		local Class = require(CustomClassLocation:FindFirstChild(classname) :: ModuleScript)
		if Class["new"] then
			return Class["new"]()
		end
	end
	return InstanceNew(classname)
end

--// A function to create a timeout preventer function to prevent script time exhaustion
local function CreateTimeoutPreventer()
	local CTime = os.clock()
	return function()
		if (os.clock() - CTime) >= 5 then
			CTime = os.clock()
			task.defer(task.spawn, coroutine.running())
			return coroutine.yield()
		end
        return
	end
end

return {
    TypeofWrapped = TypeofWrapped;
    IsA = IsA;
    InstanceNewWrapped = InstanceNewWrapped;
    CreateTimeoutPreventer = CreateTimeoutPreventer;
    RESignal = RESignal;
}