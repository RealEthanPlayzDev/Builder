--!strict
--[[
File name: Builder.luau
Author: RadiatedExodus (RealEthanPlayzDev)
Created at: December 19, 2022

This script is a part of Builder.
The root and static class for Builder, exporting all class constructors, types, and some utility functions.
--]]

--// Descriptor
local Descriptor = require(script.Descriptor)

--// Resolvables
local Attribute = require(script.Resolvable.Attribute)
local AttributeChangedSignal = require(script.Resolvable.AttributeChangedSignal)
local Event = require(script.Resolvable.Event)
local Method = require(script.Resolvable.Method)
local MultiStateResolvable = require(script.Resolvable.MultiStateResolvable)
local PropertyChangedSignal = require(script.Resolvable.PropertyChangedSignal)

--// State objects
local State = require(script.State)
local MultiState = require(script.MultiState)

local Builder = {}

--// Descriptor
Builder.Descriptor = Descriptor

--// Resolvables
Builder.Attribute = Attribute
Builder.AttributeChangedSignal = AttributeChangedSignal
Builder.Event = Event
Builder.Method = Method
Builder.MultiStateResolvable = MultiStateResolvable
Builder.PropertyChangedSignal = PropertyChangedSignal

--// State objects
Builder.State = State
Builder.MultiState = MultiState

--// Types
export type Description = Descriptor.Description
export type Descriptor = Descriptor.Descriptor
export type Attribute = Attribute.Attribute
export type AttributeChangedSignal = AttributeChangedSignal.AttributeChangedSignal
export type Event = Event.Event
export type Method = Method.Method
export type MultiStateResolvable = MultiStateResolvable.MultiStateResolvable
export type PropertyChangedSignal = PropertyChangedSignal.PropertyChangedSignal
export type State = State.State
export type MultiState = MultiState.MultiState

return Builder