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
	BackgroundTransparency: Fusion.UsedAs<number>?,
	Text: Fusion.UsedAs<string>?,
	TextColor3: Fusion.UsedAs<Color3>?,
	FontWeight: Fusion.UsedAs<Enum.FontWeight>?,
	TextScaled: Fusion.UsedAs<boolean>?,
	TextSize: Fusion.UsedAs<number>?,
	TextXAlignment: Fusion.UsedAs<Enum.TextXAlignment>?,
	TextYAlignment: Fusion.UsedAs<Enum.TextYAlignment>?,
	RichText: Fusion.UsedAs<boolean>?,

	TextColor: nil,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local ClassName = Util.EatValue(props, "ClassName") :: string?
	if ClassName == nil then
		ClassName = "TextLabel"
	end

	local Text = Util.EatValue(props, "Text") :: Fusion.UsedAs<string>?
	local TextColor3 = Util.EatValue(props, "TextColor3") :: Fusion.UsedAs<Color3>?
	local FontWeight = Util.EatValue(props, "FontWeight") :: Fusion.UsedAs<Enum.FontWeight>?
	local MaxTextSize = Util.EatValue(props, "MaxTextSize") :: Fusion.UsedAs<number>?

	return scope:base(scope.CombineProperties(props, {
		ClassName = ClassName,
		BackgroundTransparency = props.BackgroundTransparency or 1,
		Text = Text,
		TextScaled = props.TextScaled,
		TextSize = props.TextSize,
		TextXAlignment = props.TextXAlignment,
		TextYAlignment = props.TextYAlignment,
		TextColor3 = TextColor3 or currentTheme.colors.text,
		FontFace = scope:Computed(function(use)
			if use(FontWeight) ~= nil then
				return currentTheme.font[use(FontWeight)]
			else
				return currentTheme.font[Enum.FontWeight.SemiBold]
			end
		end),
		RichText = props.RichText,
	}))
end
