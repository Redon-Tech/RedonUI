local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
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
		FontWeight = uiLabs.Choose(theme.weights, 4),
	},
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope :: Fusion.Scope<typeof(Fusion)>, Util, Components)
	local currentTheme = theme.theme:now()

	return scope:textButton {
		Parent = props.target,
		Size = UDim2.fromOffset(350, 80),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

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
		ShadowColor3 = scope:Computed(function(use)
			return currentTheme.colors[use(props.controls.ShadowColor)]
		end),
		ButtonGlow = props.controls.ButtonGlow,
		ButtonGlowColor3 = scope:Computed(function(use)
			return currentTheme.colors[use(props.controls.ButtonGlowColor)]
		end),

		Text = props.controls.Text,
		TextColor3 = scope:Computed(function(use)
			return currentTheme.colors[use(props.controls.TextColor)]
		end),
		FontWeight = scope:Computed(function(use)
			-- Yes, this ignores type checking, but we KNOW that the value is a valid enum
			return (Enum.FontWeight :: any)[use(props.controls.FontWeight)]
		end),
		TextScaled = true,

		Reactive = true,
	}
end)
