local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local base = require(RedonUI.Components.base)
local baseButton = require(RedonUI.Components.baseButton)
local Components = {
	base = base,
	baseButton = baseButton,
}

export type props = baseButton.props & {
	Image: Fusion.UsedAs<string>,
	ImageColor3: Fusion.UsedAs<Color3>?,

	ImageColor: nil,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local Image = Util.EatValue(props, "Image") :: Fusion.UsedAs<string>
	local ImageColor3 = Util.EatValue(props, "ImageColor3") :: Fusion.UsedAs<Color3>?

	return scope:baseButton(scope.CombineProperties(props, {
		[Fusion.Children] = {
			scope:New("ImageLabel") {
				Name = "Image",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0.75, 0, 0.75, 0),
				BackgroundTransparency = 1,
				Image = Image,
				ImageColor3 = ImageColor3 or currentTheme.colors.text,
				ScaleType = Enum.ScaleType.Fit,

				ZIndex = if props.ZIndex
					then scope:Computed(function(use)
						return use(props.ZIndex) :: number + 1
					end)
					else 2,
			},
		},
	}))
end
