local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)

local baseButton = require(RedonUI.Components.baseButton)
local textLabel = require(RedonUI.Components.textLabel)
local Components = {
	textLabel = textLabel,
	baseButton = baseButton,
}

export type props = baseButton.props & textLabel.props

return function(baseScope: Fusion.Scope<any>, props: props)
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)

	local Text = Util.EatValue(props, "Text")
	local TextColor = Util.EatValue(props, "TextColor")
	local FontWeight = Util.EatValue(props, "FontWeight")

	return scope:baseButton(scope.CombineProperties(props, {
		[Fusion.Children] = {
			scope:textLabel {
				Name = "Text",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0.8, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = Text,
				TextColor = TextColor,
				TextScaled = true,
				FontWeight = FontWeight,
			},
		},
	}))
end
