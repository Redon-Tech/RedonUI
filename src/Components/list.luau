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
	Name: Fusion.UsedAs<string>?,
	BackgroundColor3: Fusion.UsedAs<Color3>?,

	PrimaryColor: Fusion.UsedAs<"Primary" | "Alternate">?,
	AlternateColor3: Fusion.UsedAs<Color3>,
	Rows: Fusion.UsedAs<{ [number]: Fusion.Child | string }>,
	CanvasGroup: boolean?,

	RowSize: Fusion.UsedAs<UDim2>,

	AlternateColor: nil,
}

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local PrimaryColor = scope.EatValue(props, "PrimaryColor") :: Fusion.UsedAs<"Primary" | "Alternate">?
	local InitialAlternateColor3 = scope.EatValue(props, "AlternateColor3") :: Fusion.UsedAs<Color3>?
	local Rows = scope.EatValue(props, "Rows") :: Fusion.UsedAs<{ [number]: Fusion.Child | string }>
	local CanvasGroup = scope.EatValue(props, "CanvasGroup") :: boolean?

	local RowSize = scope.EatValue(props, "RowSize") :: Fusion.UsedAs<UDim2>
	local AutomaticSize = scope.EatValue(props, "AutomaticSize") :: Fusion.UsedAs<Enum.AutomaticSize>?

	local AlternateColor = scope:Computed(function(use)
		return if use(PrimaryColor) ~= "Alternate" then use(InitialAlternateColor3) else use(props.BackgroundColor3)
	end)
	local OriginalColor = scope:Computed(function(use)
		return if use(PrimaryColor) ~= "Alternate" then use(props.BackgroundColor3) else use(InitialAlternateColor3)
	end)

	local Children = scope.EatValue(props, Fusion.Children) :: Fusion.Child

	return scope:base(scope.CombineProperties({
		ClassName = if CanvasGroup == false then "Frame" else "CanvasGroup",
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
					scope:ForPairs(Rows, function(_, scope: typeof(scope), key: number, value: Fusion.Child | string)
						if typeof(value) == "string" then
							value = scope:textLabel {
								Text = value :: string,
								Size = UDim2.fromScale(1, 1),
								AnchorPoint = Vector2.new(0.5, 0),
								Position = UDim2.fromScale(0.5, 0),
								TextSize = 20,
								TextWrapped = true,
								FontWeight = Enum.FontWeight.Regular,
								AutomaticSize = AutomaticSize,
								RichText = true,
							}
						end

						return key,
							scope:base {
								ClassName = "Frame",
								Size = RowSize,
								BackgroundColor3 = scope:Computed(function(use)
									return key % 2 == 0 and use(AlternateColor) or use(OriginalColor)
								end),
								AutomaticSize = AutomaticSize,
								ClipsDescendants = true,
								LayoutOrder = key,

								[Fusion.Children] = {
									value,
								},
							}
					end),

					Children,
				},
			},
		},
	}, props))
end
