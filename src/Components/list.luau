local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local base = require(RedonUI.Components.base)
local textLabel = require(RedonUI.Components.textLabel)
local Components = {
	base = base,
	textLabel = textLabel,
}

export type props = base.baseProps & {
	PrimaryColor: Fusion.UsedAs<"Primary" | "Alternate">?,
	AlternateColor: Fusion.UsedAs<theme.colors>?,
	Rows: { [number]: Instance | string }?,

	RowSize: Fusion.UsedAs<UDim2>,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local PrimaryColor = scope.EatValue(props, "PrimaryColor") :: Fusion.UsedAs<"Primary" | "Alternate">?
	local InitialAlternateColor = scope.EatValue(props, "AlternateColor") :: Fusion.UsedAs<theme.colors>?
	local Rows = scope.EatValue(props, "Rows") :: { [number]: Instance | string }

	local RowSize = scope.EatValue(props, "RowSize") :: Fusion.UsedAs<UDim2>

	local AlternateColor = scope:Computed(function(use)
		return if use(PrimaryColor) ~= "Alternate" then use(InitialAlternateColor) else use(props.BackgroundColor)
	end)
	local OriginalColor = scope:Computed(function(use)
		return if use(PrimaryColor) ~= "Alternate" then use(props.BackgroundColor) else use(InitialAlternateColor)
	end)

	return scope:base(scope.CombineProperties({
		ClassName = "CanvasGroup",
		Name = `TableContainer<{props.Name}>`,

		[Fusion.Children] = {
			scope:New("ScrollingFrame") {
				Name = "Table",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				ScrollBarThickness = 3,
				ScrollBarImageColor3 = currentTheme.colors.text,
				TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
				BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				CanvasSize = UDim2.new(),

				[Fusion.Children] = Fusion.Child {
					scope:New("UIListLayout") {
						SortOrder = Enum.SortOrder.LayoutOrder,
					},

					-- selene: allow(shadowing)
					scope:ForPairs(Rows, function(_, scope: typeof(scope), key: number, value: Instance | string)
						return key,
							scope:base {
								ClassName = "Frame",
								Size = RowSize,
								BackgroundColor = scope:Computed(function(use)
									return key % 2 == 0 and use(AlternateColor) or use(OriginalColor)
								end),

								[Fusion.Children] = {
									scope:Computed(function(_)
										return typeof(value) == "string"
												and scope:textLabel {
													Text = value,
													Size = UDim2.fromScale(1, 1),
													AnchorPoint = Vector2.new(0.5, 0.5),
													Position = UDim2.fromScale(0.5, 0.5),
													TextSize = 20,
													RichText = true,
												}
											or value
									end),
								},
							}
					end),
				},
			},
		},
	}, props))
end
