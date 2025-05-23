local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local types = require(RedonUI.types)

local baseButton = require(RedonUI.Components.baseButton)
local textLabel = require(RedonUI.Components.textLabel)
local Components = {
	textLabel = textLabel,
	baseButton = baseButton,
}

export type props = baseButton.props & textLabel.props & {
	TextLabelSize: Fusion.UsedAs<UDim2>?,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)

	local Text = Util.EatValue(props, "Text") :: Fusion.UsedAs<string>
	local TextColor3 = Util.EatValue(props, "TextColor3") :: Fusion.UsedAs<Color3>?
	local FontWeight = Util.EatValue(props, "FontWeight") :: Fusion.UsedAs<Enum.FontWeight>?
	local TextScaled = Util.EatValue(props, "TextScaled") :: Fusion.UsedAs<boolean>?
	local TextSize = Util.EatValue(props, "TextSize") :: Fusion.UsedAs<number>?
	local TextXAlignment = Util.EatValue(props, "TextXAlignment") :: Fusion.UsedAs<Enum.TextXAlignment>?
	local TextYAlignment = Util.EatValue(props, "TextYAlignment") :: Fusion.UsedAs<Enum.TextYAlignment>?
	local RichText = Util.EatValue(props, "RichText") :: Fusion.UsedAs<boolean>?
	local MaxTextSize = Util.EatValue(props, "MaxTextSize") :: Fusion.UsedAs<number>?

	local TextLabelSize = Util.EatValue(props, "TextLabelSize") :: Fusion.UsedAs<UDim2>?

	return scope:baseButton(scope.CombineProperties(props, {
		[Fusion.Children] = {
			scope:textLabel {
				Name = "Text",
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = TextLabelSize or UDim2.fromScale(0.8, 1),
				BackgroundTransparency = 1,
				Text = Text,
				TextColor3 = TextColor3,
				TextScaled = TextScaled,
				FontWeight = FontWeight,
				TextSize = TextSize,
				TextXAlignment = TextXAlignment,
				TextYAlignment = TextYAlignment,
				RichText = RichText,
				MaxTextSize = MaxTextSize,
				ZIndex = if props.ZIndex
					then scope:Computed(function(use)
						return use(props.ZIndex) :: number + 2
					end)
					else 3,
			},
		},
	}))
end
