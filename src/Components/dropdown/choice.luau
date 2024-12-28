local RedonUI = script.Parent.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local textLabel = require(RedonUI.Components.textLabel)
local Components = {
	textLabel = textLabel,
}

export type props = textLabel.props & {
	OnSelect: () -> (),
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local InitialBackgroundColor3 = Util.EatValue(props, "BackgroundColor3") :: Fusion.UsedAs<Color3>
	if InitialBackgroundColor3 == nil then
		InitialBackgroundColor3 = currentTheme.colors.crust
	end
	local BackgroundColor3: Fusion.Value<Color3> = scope:Value(scope.peek(InitialBackgroundColor3))

	local OnSelect = Util.EatValue(props, "OnSelect") :: () -> ()

	return scope:textLabel(scope.CombineProperties(props, {
		ClassName = "TextButton",
		BackgroundColor3 = BackgroundColor3,
		BackgroundTransparency = 0,

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
