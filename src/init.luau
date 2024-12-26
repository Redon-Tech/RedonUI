local types = require(script.types)

export type Scope = types.Scope

local components = script.Components
local base = require(components.base)
local theme = require(script.theme)

export type baseProps = base.baseProps
export type colors = theme.colors
export type fontWeights = theme.fontWeights

return {
	Components = {
		-- Base
		base = base,
		baseButton = require(components.baseButton),
		textLabel = require(components.textLabel),
		shadow = require(components.shadow),
		list = require(components.list),

		-- Buttons
		textButton = require(components.textButton),
		iconButton = require(components.iconButton),

		-- Inputs
		textBox = require(components.textBox),
		checkBox = require(components.checkBox),
		dropdown = require(components.dropdown),
	},
	theme = theme,
	Util = require(script.Util),
}
