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
	SelectedColor3: Fusion.UsedAs<Color3>?,
	SelectedCheckColor3: Fusion.UsedAs<Color3>?,

	SelectedColor: nil,
	SelectedCheckColor: nil,
}

local SPRING_SPEED = 30
local SPRING_DAMPING = 1

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local Enabled = scope.EatValue(props, "Enabled") :: Fusion.UsedAs<boolean>
	local SelectedColor3 = scope.EatValue(props, "SelectedColor3") :: Fusion.UsedAs<Color3>?
	local SelectedCheckColor3 = scope.EatValue(props, "SelectedCheckColor3") :: Fusion.UsedAs<Color3>?

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
				BackgroundColor3 = SelectedColor3,
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
					0.6
				),
				BackgroundTransparency = 1,
				Image = "rbxassetid://109702476150696",
				ImageColor3 = SelectedCheckColor3 or currentTheme.colors.text,
				Visible = Enabled,
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
