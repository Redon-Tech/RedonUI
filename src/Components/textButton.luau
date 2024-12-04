local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)

local base = require(RedonUI.Components.base)
local baseButton = require(RedonUI.Components.baseButton)
local Components = {
	base = base,
	baseButton = baseButton,
}

export type props = baseButton.props & {
	Text: Fusion.UsedAs<string>,
	TextColor: Fusion.UsedAs<theme.colors>?,
	FontWeight: Fusion.UsedAs<Enum.FontWeight>?,
}

return function(baseScope: Fusion.Scope<any>, props: props): TextButton
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)
	local currentTheme = theme.theme:now()

	local Text = Util.EatValue(props, "Text")
	local TextColor = Util.EatValue(props, "TextColor")
	local FontWeight = Util.EatValue(props, "FontWeight")

	return scope:baseButton(scope.CombineProperties(props, {
		[Fusion.Children] = {
			scope:New("TextLabel") {
				Name = "Text",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0.8, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = Text,
				TextColor3 = scope:Computed(function(use)
					if use(TextColor) ~= nil then
						return currentTheme.colors[use(TextColor)]
					else
						return currentTheme.colors.text
					end
				end),
				TextScaled = true,
				FontFace = scope:Computed(function(use)
					if use(FontWeight) ~= nil then
						return currentTheme.font[use(FontWeight)]
					else
						return currentTheme.font[Enum.FontWeight.SemiBold]
					end
				end),
			},
		},
	}))
end
