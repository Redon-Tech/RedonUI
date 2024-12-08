local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local baseButton = require(RedonUI.Components.baseButton)
local Components = {
	baseButton = baseButton,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
	controls = {
		BackgroundColor = uiLabs.Choose(theme.colors, 5),
		Border = 3,
		CornerRadius = 25,
		Shadow = true,
		ShadowColor = uiLabs.Choose(theme.colors, 5),
		ButtonGlow = true,
		ButtonGlowColor = uiLabs.Choose(theme.colors, 5),
		Reactive = true,
	},
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope, Components)
	local _currentTheme = theme.theme:now()

	return scope:baseButton {
		Parent = props.target,
		Size = UDim2.fromOffset(80, 80),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundColor = props.controls.BackgroundColor,
		Border = props.controls.Border,
		CornerRadius = scope:Computed(function(use)
			return UDim.new(0, use(props.controls.CornerRadius))
		end),
		Shadow = props.controls.Shadow,
		ShadowColor = props.controls.ShadowColor,
		ButtonGlow = props.controls.ButtonGlow,
		ButtonGlowColor = props.controls.ButtonGlowColor,

		Reactive = true,
	}
end)
