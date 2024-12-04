local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local base = require(RedonUI.Components.base)
local Components = {
	base = base,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope, Components)
	local currentTheme = theme.theme:now()

	return scope:base {
		ClassName = "Frame",
		Parent = props.target,
		Size = UDim2.new(0, 500, 0, 500),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),

		BackgroundColor = "base",

		CornerRadius = UDim.new(0, 15),

		Border = 1,
		BorderColor = "subtext1",

		[Fusion.Children] = {
			scope:New("TextLabel") {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				TextColor3 = currentTheme.colors.text,
				Text = "Hello, world!",
				TextSize = 24,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
			},
		},
	}
end)
