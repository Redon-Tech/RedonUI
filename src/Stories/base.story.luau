local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local uiLabs = require(RedonUI.Parent["ui-labs"])

local base = require(RedonUI.Components.base)
local Components = {
	base = base,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope :: Fusion.Scope<typeof(Fusion)>, Util, Components)

	return scope:base {
		ClassName = "Frame",
		Parent = props.target,
		Size = UDim2.fromOffset(500, 500),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundColor = "base",

		CornerRadius = UDim.new(0, 15),

		Border = 1,
		BorderColor = "subtext1",
	}
end)
