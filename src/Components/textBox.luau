local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local base = require(RedonUI.Components.base)
local textLabel = require(RedonUI.Components.textLabel)
local Components = {
	base = base,
}

export type props = base.baseProps & textLabel.props & {
	PlaceholderText: Fusion.UsedAs<string>?,
	PlaceholderColor: Fusion.UsedAs<theme.colors>?,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local TextColor = Util.EatValue(props, "TextColor") :: Fusion.UsedAs<theme.colors>?
	local PlaceholderColor = Util.EatValue(props, "PlaceholderColor") :: Fusion.UsedAs<string>?
	local FontWeight = Util.EatValue(props, "FontWeight") :: Fusion.UsedAs<Enum.FontWeight>?

	return scope:base(scope.CombineProperties(props, {
		ClassName = "TextBox",
		Text = props.Text,
		PlaceholderText = props.PlaceholderText,
		TextSize = props.TextSize,
		TextScaled = props.TextScaled,
		TextXAlignment = props.TextXAlignment,
		TextYAlignment = props.TextYAlignment,
		TextColor3 = scope:Computed(function(use)
			if use(TextColor) ~= nil then
				return currentTheme.colors[use(TextColor)]
			else
				return currentTheme.colors.text
			end
		end),
		PlaceholderColor3 = scope:Computed(function(use)
			if use(PlaceholderColor) ~= nil then
				return currentTheme.colors[use(PlaceholderColor)]
			else
				return currentTheme.colors.subtext0
			end
		end),
		FontFace = scope:Computed(function(use)
			if use(FontWeight) ~= nil then
				return currentTheme.font[use(FontWeight)]
			else
				return currentTheme.font[Enum.FontWeight.SemiBold]
			end
		end),

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
