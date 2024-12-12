local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local base = require(RedonUI.Components.base)
local baseButton = require(RedonUI.Components.baseButton)
local Components = {
	base = base,
	baseButton = baseButton,
}

export type props = baseButton.props & {
	Enabled: Fusion.UsedAs<boolean>,
	SelectedColor: Fusion.UsedAs<theme.colors>?,
	SelectedCheckColor: Fusion.UsedAs<theme.colors>?,
}

local SPRING_SPEED = 25
local SPRING_DAMPING = 0.5

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local Enabled = scope.EatValue(props, "Enabled") :: Fusion.UsedAs<boolean>
	local SelectedColor = scope.EatValue(props, "SelectedColor") :: Fusion.UsedAs<theme.colors>?
	local SelectedCheckColor = scope.EatValue(props, "SelectedCheckColor") :: Fusion.UsedAs<theme.colors>?

	return scope:baseButton(scope.CombineProperties(props, {
		[Fusion.Children] = {
			scope:base {
				ClassName = "Frame",
				Size = scope:Spring(
					scope:Computed(function(use)
						if use(Enabled) then
							return UDim2.fromScale(1, 1)
						else
							return UDim2.new()
						end
					end),
					SPRING_SPEED,
					1
				),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor = SelectedColor :: Fusion.UsedAs<theme.colors>?,
				CornerRadius = props.CornerRadius,
			},

			scope:New("ImageLabel") {
				Name = "Image",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = scope:Spring(
					scope:Computed(function(use)
						if use(Enabled) then
							return UDim2.fromScale(0.75, 0.75)
						else
							return UDim2.fromScale(0, 0)
						end
					end),
					SPRING_SPEED,
					SPRING_DAMPING
				),
				Rotation = scope:Spring(
					scope:Computed(function(use)
						if use(Enabled) then
							return 0
						else
							return 180
						end
					end),
					SPRING_SPEED,
					SPRING_DAMPING
				),
				BackgroundTransparency = 1,
				Image = "rbxassetid://109702476150696",
				ImageColor3 = scope:Computed(function(use)
					if use(SelectedCheckColor) ~= nil then
						return currentTheme.colors[use(SelectedCheckColor)]
					else
						return currentTheme.colors.text
					end
				end),
				Visible = Enabled,
				ScaleType = Enum.ScaleType.Fit,

				ZIndex = 1,
			},
		},
	}))
end
