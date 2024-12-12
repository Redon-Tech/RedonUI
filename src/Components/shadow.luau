local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local Components = {}

export type props = {
	ShadowColor: Fusion.UsedAs<string>?,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	return scope:New("ImageLabel") {
		Name = "Shadow",
		BackgroundTransparency = 1,
		ImageTransparency = 0.5,
		Image = "rbxassetid://102719652753943",
		ImageColor3 = scope:Computed(function()
			return if props.ShadowColor ~= nil then currentTheme.colors[props.ShadowColor] else Color3.new()
		end),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, 56, 1, 56),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(256, 256, 256, 256),
		SliceScale = 0.2,
		ZIndex = -1,
	}
end
