local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local base = require(RedonUI.Components.base)
local textLabel = require(RedonUI.Components.textLabel)
local Components = {
	base = base,
	textLabel = textLabel,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
	controls = {
		Text = "Hello, World!",
		TextColor = uiLabs.Choose(theme.colors, 15),
		TextSize = 32,
		FontWeight = uiLabs.Choose(theme.weights, 4),
		AutoScaled = true,
	},
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope :: Fusion.Scope<typeof(Fusion)>, Util, Components)

	local AutomaticSize = scope:Computed(function(use)
		return if use(props.controls.AutoScaled) then Enum.AutomaticSize.XY else Enum.AutomaticSize.None
	end)

	return scope:base {
		ClassName = "Frame",
		Parent = props.target,
		Size = UDim2.new(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundColor = "base",

		CornerRadius = UDim.new(0, 15),

		Border = 1,
		BorderColor = "subtext1",
		AutomaticSize = AutomaticSize,

		[Fusion.Children] = {
			scope:textLabel {
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0, 0),
				AnchorPoint = Vector2.new(0, 0),
				BackgroundTransparency = 1,
				TextColor = props.controls.TextColor,
				Text = props.controls.Text,
				TextSize = props.controls.TextSize,
				TextWrapped = true,
				FontWeight = scope:Computed(function(use)
					-- Yes, this ignores type checking, but we KNOW that the value is a valid enum
					return (Enum.FontWeight :: any)[use(props.controls.FontWeight)]
				end),
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,
				AutomaticSize = AutomaticSize,

				[Fusion.Children] = {
					scope:New("UISizeConstraint") {
						MinSize = Vector2.new(280, 80),
						MaxSize = Vector2.new(750, math.huge),
					},

					scope:New("UIPadding") {
						PaddingLeft = UDim.new(0, 10),
						PaddingRight = UDim.new(0, 10),
					},
				},
			},
		},
	}
end)
