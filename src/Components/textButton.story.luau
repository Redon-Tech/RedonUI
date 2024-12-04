local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local textButton = require(RedonUI.Components.textButton)
local Components = {
	textButton = textButton,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
	controls = {
		gradientBegin = uiLabs.Choose(theme.colors, 11),
		gradientEnd = uiLabs.Choose(theme.colors, 12),
		Border = 3,
		CornerRadius = 25,
		Shadow = true,
		ShadowColor = uiLabs.Choose(theme.colors, 11),
		ButtonGlow = true,
		ButtonGlowColor = uiLabs.Choose(theme.colors, 15),
		Reactive = true,
		Text = "TextButton",
		TextColor = uiLabs.Choose(theme.colors, 25),
		FontWeight = uiLabs.Choose({
			"Thin",
			"ExtraLight",
			"Light",
			"Regular",
			"Medium",
			"SemiBold",
			"Bold",
			"ExtraBold",
			"Heavy",
		}, 4),
	},
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope, Components)
	local currentTheme = theme.theme:now()

	return scope:textButton {
		Parent = props.target,
		Size = UDim2.new(0, 350, 0, 80),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),

		-- BackgroundColor = "sapphire",
		Gradient = scope:Computed(function(use)
			return ColorSequence.new(
				currentTheme.colors[use(props.controls.gradientBegin)],
				currentTheme.colors[use(props.controls.gradientEnd)]
			)
		end),
		Border = props.controls.Border,
		CornerRadius = scope:Computed(function(use)
			return UDim.new(0, use(props.controls.CornerRadius))
		end),
		Shadow = props.controls.Shadow,
		ShadowColor = props.controls.ShadowColor,
		ButtonGlow = props.controls.ButtonGlow,
		ButtonGlowColor = props.controls.ButtonGlowColor,

		Text = props.controls.Text,
		TextColor = props.controls.TextColor,
		FontWeight = scope:Computed(function(use)
			return Enum.FontWeight[use(props.controls.FontWeight)]
		end),

		Reactive = true,
	}
end)
