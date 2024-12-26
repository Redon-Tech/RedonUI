local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local types = require(RedonUI.types)

local Components = {}

export type props = {
	ShadowColor3: Fusion.UsedAs<Color3>?,

	ShadowColor: nil,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)

	return scope:New("ImageLabel") {
		Name = "Shadow",
		BackgroundTransparency = 1,
		ImageTransparency = 0.5,
		Image = "rbxassetid://102719652753943",
		ImageColor3 = props.ShadowColor3 or Color3.new(0, 0, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, 56, 1, 56),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(256, 256, 256, 256),
		SliceScale = 0.2,
		ZIndex = -1,
	}
end
