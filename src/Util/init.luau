local CombineProperties = require(script.CombineProperties)
local Component = require(script.Component)
local EatValue = require(script.EatValue)
local StealEvents = require(script.StealEvents)

export type Scope = Component.Scope

return {
	CombineProperties = CombineProperties,
	Component = Component,
	EatValue = EatValue,
	StealEvents = StealEvents,
}
