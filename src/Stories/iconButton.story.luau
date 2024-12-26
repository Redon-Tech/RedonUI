local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local iconButton = require(RedonUI.Components.iconButton)
local Components = {
	iconButton = iconButton,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
	controls = {
		BackgroundColor = uiLabs.Choose(theme.colors, 25),
		Border = 3,
		CornerRadius = 25,
		Shadow = true,
		ShadowColor = uiLabs.Choose(theme.colors, 28),
		ButtonGlow = true,
		ButtonGlowColor = uiLabs.Choose(theme.colors, 24),
		Reactive = true,
		Image = "rbxassetid://80323595668024",
		ImageColor = uiLabs.Choose(theme.colors, 15),
	},
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope :: Fusion.Scope<typeof(Fusion)>, Util, Components)
	local currentTheme = theme.theme:now()

	return scope:iconButton {
		Parent = props.target,
		Size = UDim2.fromOffset(80, 80),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundColor3 = scope:Computed(function(use)
			return currentTheme.colors[use(props.controls.BackgroundColor)]
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

		Image = props.controls.Image,
		ImageColor3 = scope:Computed(function(use)
			return currentTheme.colors[use(props.controls.ImageColor)]
		end),

		Reactive = true,
	}
end)
