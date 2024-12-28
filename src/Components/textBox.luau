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

	PaddingTop: Fusion.UsedAs<UDim>?,
	PaddingBottom: Fusion.UsedAs<UDim>?,
	PaddingLeft: Fusion.UsedAs<UDim>?,
	PaddingRight: Fusion.UsedAs<UDim>?,

	PlaceholderColor: nil,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local PlaceholderColor3 = Util.EatValue(props, "PlaceholderColor3") :: Fusion.UsedAs<Color3>?
	local PaddingTop = Util.EatValue(props, "PaddingTop") :: Fusion.UsedAs<UDim>?
	local PaddingBottom = Util.EatValue(props, "PaddingBottom") :: Fusion.UsedAs<UDim>?
	local PaddingLeft = Util.EatValue(props, "PaddingLeft") :: Fusion.UsedAs<UDim>?
	local PaddingRight = Util.EatValue(props, "PaddingRight") :: Fusion.UsedAs<UDim>?

	return scope:textLabel(scope.CombineProperties(props, {
		ClassName = "TextBox",
		PlaceholderColor3 = PlaceholderColor3 or currentTheme.colors.subtext0,
		BackgroundTransparency = props.BackgroundTransparency or 0,

		[Fusion.Children] = {
			scope:New("UIPadding") {
				PaddingLeft = PaddingLeft or UDim.new(0, 10),
				PaddingRight = PaddingRight or UDim.new(0, 10),
				PaddingTop = PaddingTop or UDim.new(0, 10),
				PaddingBottom = PaddingBottom or UDim.new(0, 10),
			},
		},
	}))
end
