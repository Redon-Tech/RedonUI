local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)

local baseButton = require(RedonUI.Components.baseButton)
local Components = {
	baseButton = baseButton,
}

export type props = baseButton.props & {
	Text: Fusion.UsedAs<string>,
	TextColor: Fusion.UsedAs<theme.colors>?,
	FontWeight: Fusion.UsedAs<Enum.FontWeight>?,
}

return function<T>(baseScope: Fusion.Scope<any>, props: props): TextButton
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)
	local currentTheme = theme.theme:now()

	return scope:baseButton(scope.CombineProperties(props, {
		[Fusion.Children] = {
			scope:New("TextLabel") {
				Name = "Text",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0.8, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = props.Text,
				TextColor3 = currentTheme.colors[props.TextColor or "text"],
				TextScaled = true,
				FontFace = currentTheme.font[props.FontWeight or Enum.FontWeight.Regular],
			},
		},
	}))
end
