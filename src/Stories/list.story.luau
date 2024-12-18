local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local table = require(RedonUI.Components.list)
local Components = {
	table = table,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope :: Fusion.Scope<typeof(Fusion)>, Util, Components)

	local rows = {}
	for i = 1, 100 do
		local randomString = ""
		for _ = 1, math.random(1, i * 10) do
			randomString = randomString .. string.char(math.random(97, 122))
		end
		rows[i] = `Row {i}\n{randomString}`
	end

	return scope:table {
		Parent = props.target,
		Size = UDim2.fromOffset(500, 500),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundColor = "base" :: theme.colors,
		AutomaticSize = Enum.AutomaticSize.Y,

		CornerRadius = UDim.new(0, 15),

		Rows = rows,
		RowSize = UDim2.fromOffset(500, 50),
		AlternateColor = "mantle" :: theme.colors,
		PrimaryColor = "Alternate" :: "Primary" | "Alternate",
	}
end)
