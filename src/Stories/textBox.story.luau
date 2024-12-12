local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local textBox = require(RedonUI.Components.textBox)
local Components = {
	textBox = textBox,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
	controls = {
		BackgroundColor = uiLabs.Choose(theme.colors, 26),
		Border = 1,
		CornerRadius = 10,

		Text = "https://youtube.com/watch?video=",
		PlaceholderText = "",
		TextColor = uiLabs.Choose(theme.colors, 15),
		PlaceHolderColor = uiLabs.Choose(theme.colors, 17),
		FontWeight = uiLabs.Choose(theme.weights, 4),
	},
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope :: Fusion.Scope<typeof(Fusion)>, Util, Components)

	return scope:textBox {
		Parent = props.target,
		Size = UDim2.fromOffset(380, 42),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundColor = props.controls.BackgroundColor,
		Border = props.controls.Border,
		CornerRadius = scope:Computed(function(use)
			return UDim.new(0, use(props.controls.CornerRadius))
		end),

		TextScaled = true,
		TextSize = 20,

		Text = props.controls.Text,
		PlaceholderText = props.controls.PlaceholderText,
		TextColor = props.controls.TextColor,
		PlaceholderColor = props.controls.PlaceHolderColor,
		FontWeight = scope:Computed(function(use)
			-- Yes, this ignores type checking, but we KNOW that the value is a valid enum
			return (Enum.FontWeight :: any)[use(props.controls.FontWeight)]
		end),

		TextXAlignment = Enum.TextXAlignment.Left,
	}
end)
