local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local checkBox = require(RedonUI.Components.checkBox)
local Components = {
	checkBox = checkBox,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
	controls = {
		Enabled = false,
		BackgroundColor = uiLabs.Choose(theme.colors, 26),
		SelectedColor = uiLabs.Choose(theme.colors, 13),
		SelectedCheckColor = uiLabs.Choose(theme.colors, 15),
	},
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope :: Fusion.Scope<typeof(Fusion)>, Util, Components)

	return scope:checkBox {
		Parent = props.target,
		Size = UDim2.fromOffset(80, 80),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundColor = props.controls.BackgroundColor,
		Border = 1,
		CornerRadius = UDim.new(0, 10),
		Shadow = false,
		ButtonGlow = false,

		Enabled = props.controls.Enabled,
		SelectedColor = props.controls.SelectedColor,
		SelectedCheckColor = props.controls.SelectedCheckColor,

		Reactive = true,

		[Fusion.OnEvent "Activated"] = function()
			props.controls.Enabled:set(not scope.peek(props.controls.Enabled))
		end,
	}
end)
