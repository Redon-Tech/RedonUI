local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)

local base = require(RedonUI.Components.base)
local baseButton = require(RedonUI.Components.baseButton)
local Components = {
	base = base,
	baseButton = baseButton,
}

export type props = baseButton.props & {
	Image: Fusion.UsedAs<string>,
	ImageColor: Fusion.UsedAs<theme.colors>?,
}

return function(baseScope: Fusion.Scope<any>, props: props)
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)
	local currentTheme = theme.theme:now()

	local Image = Util.EatValue(props, "Image") :: Fusion.UsedAs<string>
	local ImageColor = Util.EatValue(props, "ImageColor") :: Fusion.UsedAs<theme.colors>?

	return scope:baseButton(scope.CombineProperties(props, {
		[Fusion.Children] = {
			scope:New("ImageLabel") {
				Name = "Image",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0.75, 0, 0.75, 0),
				BackgroundTransparency = 1,
				Image = Image,
				ImageColor3 = scope:Computed(function(use)
					if use(ImageColor) ~= nil then
						return currentTheme.colors[use(ImageColor)]
					else
						return currentTheme.colors.text
					end
				end),

				ZIndex = 1,
			},
		},
	}))
end
