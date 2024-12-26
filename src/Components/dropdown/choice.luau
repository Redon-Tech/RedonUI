local RedonUI = script.Parent.Parent.Parent

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
	TextColor3: Fusion.UsedAs<Color3>?,
	FontWeight: Fusion.UsedAs<Enum.FontWeight>?,
	OnSelect: () -> (),

	TextColor: nil,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local InitialBackgroundColor3 = Util.EatValue(props, "BackgroundColor3") :: Fusion.UsedAs<Color3>
	if InitialBackgroundColor3 == nil then
		InitialBackgroundColor3 = currentTheme.colors.crust
	end
	local BackgroundColor3: Fusion.Value<Color3> = scope:Value(scope.peek(InitialBackgroundColor3))

	local Text = Util.EatValue(props, "Text") :: Fusion.UsedAs<string>
	local TextColor3 = Util.EatValue(props, "TextColor3") :: Fusion.UsedAs<Color3>?
	local FontWeight = Util.EatValue(props, "FontWeight") :: Fusion.UsedAs<Enum.FontWeight>?
	local OnSelect = Util.EatValue(props, "OnSelect") :: () -> ()

	return scope:base(scope.CombineProperties(props, {
		ClassName = "TextButton",
		BackgroundColor3 = BackgroundColor3,
		Text = Text,
		TextColor3 = TextColor3 or currentTheme.colors.text,
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
			BackgroundColor3:set(currentTheme.colors.surface0)
		end,

		[Fusion.OnEvent "MouseLeave"] = function()
			BackgroundColor3:set(scope.peek(InitialBackgroundColor3))
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
