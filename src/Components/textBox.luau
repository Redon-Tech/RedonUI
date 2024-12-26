local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local textLabel = require(RedonUI.Components.textLabel)
local Components = {
	textLabel = textLabel,
}

export type props = textLabel.props & {
	PlaceholderText: Fusion.UsedAs<string>?,
	PlaceholderColor3: Fusion.UsedAs<Color3>?,

	PlaceholderColor: nil,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local PlaceholderColor3 = Util.EatValue(props, "PlaceholderColor3") :: Fusion.UsedAs<Color3>?

	return scope:textLabel(scope.CombineProperties(props, {
		ClassName = "TextBox",
		PlaceholderColor3 = PlaceholderColor3 or currentTheme.colors.subtext0,

		[Fusion.Children] = {
			scope:New("UIPadding") {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
			},
		},
	}))
end
