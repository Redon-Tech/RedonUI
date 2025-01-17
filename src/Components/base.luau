local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local shadow = require(script.Parent.shadow)
local Components = {
	shadow = shadow,
}

export type baseProps = shadow.props & {
	ClassName: string?,

	Gradient: Fusion.UsedAs<ColorSequence>?,
	GradientTransparency: Fusion.UsedAs<NumberSequence>?,
	GradientRotation: Fusion.UsedAs<number>?,

	Border: Fusion.UsedAs<number>?,
	BorderColor3: Fusion.UsedAs<Color3>?,
	CornerRadius: Fusion.UsedAs<UDim>?,

	Shadow: Fusion.UsedAs<boolean>?,

	MaxSize: Fusion.UsedAs<Vector2>?,
	MinSize: Fusion.UsedAs<Vector2>?,

	[Fusion.SpecialKey]: unknown,

	BackgroundColor: nil,
	BorderColor: nil,
}

return function(baseScope: types.Scope, props: baseProps)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local ClassName = Util.EatValue(props, "ClassName") :: string
	if ClassName == nil then
		ClassName = "Frame"
	end

	local Gradient = Util.EatValue(props, "Gradient") :: Fusion.UsedAs<ColorSequence>?
	local GradientTransparency = Util.EatValue(props, "GradientTransparency") :: Fusion.UsedAs<NumberSequence>?
	local GradientRotation = Util.EatValue(props, "GradientRotation") :: Fusion.UsedAs<number>?

	local Border = Util.EatValue(props, "Border") :: Fusion.UsedAs<number>?
	local BorderColor3 = Util.EatValue(props, "BorderColor3") :: Fusion.UsedAs<Color3>?
	local CornerRadius = Util.EatValue(props, "CornerRadius") :: Fusion.UsedAs<UDim>?

	local Shadow = Util.EatValue(props, "Shadow") :: Fusion.UsedAs<boolean>?
	local ShadowColor3 = Util.EatValue(props, "ShadowColor3") :: Fusion.UsedAs<Color3>?

	local MaxSize = Util.EatValue(props, "MaxSize") :: Fusion.UsedAs<Vector2>?
	local MinSize = Util.EatValue(props, "MinSize") :: Fusion.UsedAs<Vector2>?

	return scope:New(ClassName)(scope.CombineProperties({
		[Fusion.Children] = {
			if CornerRadius ~= nil
				then scope:New("UICorner") {
					CornerRadius = CornerRadius,
				}
				else {},

			if Border ~= nil
				then scope:New("UIStroke") {
					Thickness = Border,
					Color = BorderColor3 or currentTheme.colors.white,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				}
				else {},

			if Gradient ~= nil
				then scope:New("UIGradient") {
					Color = Gradient,
					Transparency = GradientTransparency,
					Rotation = GradientRotation,
				}
				else {},

			scope:Computed(function(use)
				return if use(Shadow) == true
					then scope:shadow {
						ShadowColor3 = ShadowColor3,
					}
					else nil
			end),

			if MaxSize ~= nil or MinSize ~= nil
				then scope:New("UISizeConstraint") {
					MaxSize = MaxSize,
					MinSize = MinSize,
				}
				else {},
		},
	}, props))
end
