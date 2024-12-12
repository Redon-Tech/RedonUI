local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local shadow = require(script.Parent.shadow)
local Components = {
	shadow = shadow,
}

export type baseProps = {
	ClassName: string?,
	Name: Fusion.UsedAs<string>?,
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

	Shadow: Fusion.UsedAs<boolean>?,
	ShadowColor: Fusion.UsedAs<theme.colors>?,
}

return function(baseScope: types.Scope, props: baseProps)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local ClassName = Util.EatValue(props, "ClassName") :: string
	if ClassName == nil then
		ClassName = "Frame"
	end

	local BackgroundColor = Util.EatValue(props, "BackgroundColor") :: Fusion.UsedAs<theme.colors>?

	local Gradient = Util.EatValue(props, "Gradient") :: Fusion.UsedAs<ColorSequence>?
	local GradientTransparency = Util.EatValue(props, "GradientTransparency") :: Fusion.UsedAs<NumberSequence>?
	local GradientRotation = Util.EatValue(props, "GradientRotation") :: Fusion.UsedAs<number>?

	local Border = Util.EatValue(props, "Border") :: Fusion.UsedAs<number>?
	local BorderColor = Util.EatValue(props, "BorderColor") :: Fusion.UsedAs<theme.colors>?
	local CornerRadius = Util.EatValue(props, "CornerRadius") :: Fusion.UsedAs<UDim>?

	local Shadow = Util.EatValue(props, "Shadow") :: Fusion.UsedAs<boolean>?
	local ShadowColor = Util.EatValue(props, "ShadowColor") :: Fusion.UsedAs<theme.colors>?

	return scope:New(ClassName)(scope.CombineProperties({
		Name = props.Name,
		Parent = props.Parent,

		AnchorPoint = props.AnchorPoint,
		Position = props.Position,
		Size = props.Size,

		BackgroundColor3 = scope:Computed(function(use)
			if use(BackgroundColor) ~= nil then
				return currentTheme.colors[use(BackgroundColor)]
			else
				return currentTheme.colors.white
			end
		end),
		BackgroundTransparency = props.BackgroundTransparency,
		Visible = props.Visible,

		[Fusion.Children] = {
			scope:Computed(function(use)
				return if use(CornerRadius) ~= nil
					then scope:New("UICorner") {
						CornerRadius = use(CornerRadius),
					}
					else nil
			end),

			scope:Computed(function(use)
				return if use(Border) ~= nil
					then scope:New("UIStroke") {
						Thickness = use(Border),
						Color = if use(BorderColor) ~= nil
							then currentTheme.colors[use(BorderColor)]
							else currentTheme.colors.white,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					}
					else nil
			end),

			scope:Computed(function(use)
				return if use(Gradient) ~= nil
					then scope:New("UIGradient") {
						Color = use(Gradient),
						Transparency = use(GradientTransparency),
						Rotation = use(GradientRotation),
					}
					else nil
			end),

			scope:Computed(function(use)
				return if use(Shadow) == true
					then scope:shadow {
						ShadowColor = use(ShadowColor),
					}
					else nil
			end),

			props[Fusion.Children],
		},
	}, props))
end
