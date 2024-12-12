local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local base = require(RedonUI.Components.base)
local Components = {
	base = base,
}

export type props = base.baseProps & {
	Text: Fusion.UsedAs<string>,
	TextColor: Fusion.UsedAs<theme.colors>?,
	FontWeight: Fusion.UsedAs<Enum.FontWeight>?,
	TextScaled: Fusion.UsedAs<boolean>?,
	TextSize: Fusion.UsedAs<number>?,
	TextXAlignment: Fusion.UsedAs<Enum.TextXAlignment>?,
	TextYAlignment: Fusion.UsedAs<Enum.TextYAlignment>?,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local Text = Util.EatValue(props, "Text") :: Fusion.UsedAs<string>
	local TextColor = Util.EatValue(props, "TextColor") :: Fusion.UsedAs<theme.colors>?
	local FontWeight = Util.EatValue(props, "FontWeight") :: Fusion.UsedAs<Enum.FontWeight>?

	return scope:base(scope.CombineProperties(props, {
		ClassName = "TextLabel",
		BackgroundTransparency = 1,
		Text = Text,
		TextScaled = props.TextScaled,
		TextSize = props.TextSize,
		TextXAlignment = props.TextXAlignment,
		TextYAlignment = props.TextYAlignment,
		TextColor3 = scope:Computed(function(use)
			if use(TextColor) ~= nil then
				return currentTheme.colors[use(TextColor)]
			else
				return currentTheme.colors.text
			end
		end),
		FontFace = scope:Computed(function(use)
			if use(FontWeight) ~= nil then
				return currentTheme.font[use(FontWeight)]
			else
				return currentTheme.font[Enum.FontWeight.SemiBold]
			end
		end),
	}))
end
