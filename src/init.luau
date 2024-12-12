local types = require(script.types)

export type Scope = types.Scope

local components = script.Components

return {
	Components = {
		-- Base
		base = require(components.base),
		baseButton = require(components.baseButton),
		textLabel = require(components.textLabel),
		shadow = require(components.shadow),

		-- Buttons
		textButton = require(components.textButton),
		iconButton = require(components.iconButton),

		-- Inputs
		textBox = require(components.textBox),
		checkBox = require(components.checkBox),
		dropdown = require(components.dropdown),
	},
	theme = require(script.theme),
	Util = require(script.Util),
}
