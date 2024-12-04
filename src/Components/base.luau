local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)

local Components = {}

export type props = {
	ClassName: Fusion.UsedAs<string>,
	Name: Fusion.UsedAs<string>,
	Parent: Fusion.UsedAs<Instance>?,

	AnchorPoint: Fusion.UsedAs<Vector2>?,
	Position: Fusion.UsedAs<UDim2>?,
	Size: Fusion.UsedAs<UDim2>?,

	BackgroundColor: Fusion.UsedAs<theme.colors>?,
	BackgroundTransparency: Fusion.UsedAs<number>?,
	Visible: Fusion.UsedAs<boolean>?,

	Gradient: Fusion.UsedAs<ColorSequence>?,
	GradientTransparency: Fusion.UsedAs<NumberSequence>?,
	GradientRotation: Fusion.UsedAs<number>?,

	Border: Fusion.UsedAs<number>?,
	BorderColor: Fusion.UsedAs<theme.colors>?,
	CornerRadius: Fusion.UsedAs<UDim>?,

	[typeof(Fusion.Children)]: typeof(Fusion.Children),
}

return function<T>(baseScope: Fusion.Scope<any>, props: props & { ClassName: T }): T
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)
	local currentTheme = theme.theme:now()

	return scope:New(props.ClassName) {
		Name = props.Name,
		Parent = props.Parent,

		AnchorPoint = props.AnchorPoint,
		Position = props.Position,
		Size = props.Size,

		BackgroundColor3 = currentTheme.colors[props.BackgroundColor],
		BackgroundTransparency = props.BackgroundTransparency,
		Visible = props.Visible,

		[Fusion.Children] = {
			scope:Computed(function(use)
				return if use(props.CornerRadius) ~= nil
					then scope:New("UICorner") {
						CornerRadius = use(props.CornerRadius),
					}
					else nil
			end),

			scope:Computed(function(use)
				return if use(props.Border) ~= nil
					then scope:New("UIStroke") {
						Thickness = use(props.Border),
						Color = if use(props.BorderColor) ~= nil
							then currentTheme.colors[use(props.BorderColor)]
							else currentTheme.colors.white,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					}
					else nil
			end),

			scope:Computed(function(use)
				return if use(props.Gradient) ~= nil
					then scope:New("UIGradient") {
						Color = use(props.Gradient),
						Transparency = use(props.GradientTransparency),
						Rotation = use(props.GradientRotation),
					}
					else nil
			end),

			props[Fusion.Children],
		},
	}
end
