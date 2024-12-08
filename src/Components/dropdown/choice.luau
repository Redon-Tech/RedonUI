local RedonUI = script.Parent.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)

local base = require(RedonUI.Components.base)
local components = {
	base = base,
}

export type props = base.baseProps & {
	Text: Fusion.UsedAs<string>,
	TextColor: Fusion.UsedAs<theme.colors>?,
	FontWeight: Fusion.UsedAs<Enum.FontWeight>?,
	OnSelect: () -> (),
}

return function(baseScope: Fusion.Scope<any>, props: props)
	local scope = Fusion.innerScope(baseScope, Fusion, components, Util)
	local currentTheme = theme.theme:now()

	local InitialBackgroundColor = Util.EatValue(props, "BackgroundColor") :: Fusion.UsedAs<theme.colors>
	if InitialBackgroundColor == nil then
		InitialBackgroundColor = "crust"
	end
	print(InitialBackgroundColor)
	local BackgroundColor = scope:Value(scope.peek(InitialBackgroundColor))
	print(BackgroundColor)

	local Text = Util.EatValue(props, "Text") :: Fusion.UsedAs<string>
	local TextColor = Util.EatValue(props, "TextColor") :: Fusion.UsedAs<theme.colors>?
	local FontWeight = Util.EatValue(props, "FontWeight") :: Fusion.UsedAs<Enum.FontWeight>?
	local OnSelect = Util.EatValue(props, "OnSelect") :: () -> ()

	return scope:base(scope.CombineProperties(props, {
		ClassName = "TextButton",
		BackgroundColor = BackgroundColor,
		Text = Text,
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
				return currentTheme.font[Enum.FontWeight.Regular]
			end
		end),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true,

		[Fusion.OnEvent "Activated"] = OnSelect,

		[Fusion.OnEvent "MouseEnter"] = function()
			BackgroundColor:set("surface0")
		end,

		[Fusion.OnEvent "MouseLeave"] = function()
			BackgroundColor:set(scope.peek(InitialBackgroundColor))
		end,

		[Fusion.Children] = {
			scope:New("UIPadding") {
				PaddingLeft = UDim.new(0, 9),
				PaddingRight = UDim.new(0, 9),
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
			},
		},
	}))
end
