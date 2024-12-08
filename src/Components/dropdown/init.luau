local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)

local base = require(RedonUI.Components.base)
local baseButton = require(RedonUI.Components.baseButton)
local textLabel = require(RedonUI.Components.textLabel)
local choice = require(script.choice)
local Components = {
	base = base,
	textLabel = textLabel,
	baseButton = baseButton,
	choice = choice,
}

export type props<I, V> = baseButton.props & textLabel.props & {
	Options: Fusion.UsedAs<{ [I]: V }>,
	OnOptionSelected: (I, V) -> (),

	DropdownHeight: Fusion.UsedAs<number>,
}

local SPRING_SPEED = 20
local SPRING_DAMPING = 1

return function<I, V>(baseScope: Fusion.Scope<any>, props: props<I, V>)
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)
	local currenTheme = theme.theme:now()

	local Text = Util.EatValue(props, "Text") :: Fusion.UsedAs<string>
	local TextColor = Util.EatValue(props, "TextColor") :: Fusion.UsedAs<theme.colors>
	local FontWeight = Util.EatValue(props, "FontWeight") :: Fusion.UsedAs<Enum.FontWeight>

	local Options = Util.EatValue(props, "Options") :: Fusion.UsedAs<{ [I]: V }>
	local OnOptionSelected = Util.EatValue(props, "OnOptionSelected") :: (I, V) -> ()

	local DropdownHeight = Util.EatValue(props, "DropdownHeight") :: Fusion.UsedAs<number>

	local Reactive = Util.EatValue(props, "Reactive")
	local ButtonGlow = Util.EatValue(props, "ButtonGlow")
	local ButtonGlowColor = Util.EatValue(props, "ButtonGlowColor")
	local MouseEnter = Util.EatValue(props, "MouseEnter")
	local MouseLeave = Util.EatValue(props, "MouseLeave")
	local MouseButton1Down = Util.EatValue(props, "MouseButton1Down")
	local MouseButton1Up = Util.EatValue(props, "MouseButton1Up")
	local events = Util.StealEvents(props)

	local isOpen = scope:Value(false)
	local buttonSize = scope:Value()
	local dropdownSize = scope:Value()
	local triggerHover = scope:Value(false)

	return {
		scope:baseButton(scope.CombineProperties(props, {
			Reactive = Reactive,
			ButtonGlow = ButtonGlow,
			ButtonGlowColor = ButtonGlowColor,
			MouseEnter = MouseEnter,
			MouseLeave = MouseLeave,
			MouseButton1Up = MouseButton1Up,
			TriggerHover = triggerHover,
			ForceDamping = 0.6,

			[Fusion.Out "AbsoluteSize"] = buttonSize,

			MouseButton1Down = function()
				isOpen:set(not scope.peek(isOpen))
				if scope.peek(MouseButton1Down) ~= nil then
					scope.peek(MouseButton1Down)()
				end
			end,

			[Fusion.Children] = {
				scope:textLabel {
					Name = "Text",
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 10, 0.5, 0),
					Size = UDim2.new(1, -45, 0, 20),
					BackgroundTransparency = 1,
					Text = Text,
					TextColor = TextColor,
					TextScaled = true,
					FontWeight = FontWeight,
					TextXAlignment = Enum.TextXAlignment.Left,
				},

				scope:New("ImageLabel") {
					Name = "Arrow",
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.fromScale(0.9, 0.5),
					Size = UDim2.fromOffset(20, 12),
					BackgroundTransparency = 1,
					Image = "rbxassetid://110726366161984",
					Rotation = scope:Spring(
						scope:Computed(function(use)
							return use(isOpen) and 180 or 0
						end),
						SPRING_SPEED,
						SPRING_DAMPING
					),
					ScaleType = Enum.ScaleType.Fit,
				},
			},
		}, events)),

		scope:base(scope.CombineProperties(props, {
			ClassName = "CanvasGroup",
			Name = `DropdownFrame<{props.Name}>`,
			AnchorPoint = scope:Computed(function(use)
				local baseAnchorPoint = use(props.AnchorPoint) :: Vector2?
				if baseAnchorPoint ~= nil then
					return Vector2.new(baseAnchorPoint.X, 0)
				end

				return Vector2.new(0, 0)
			end),
			Position = scope:Computed(function(use)
				local basePosition = use(props.Position) :: UDim2?
				local baseSize = use(buttonSize) :: Vector2?
				if basePosition ~= nil and baseSize ~= nil then
					return basePosition + UDim2.fromOffset(0, (baseSize.Y / 2) + 5)
				elseif baseSize ~= nil then
					return UDim2.fromOffset(0, (baseSize.Y / 2) + 5)
				end

				return UDim2.fromOffset(0, 0)
			end),
			Size = scope:Spring(
				scope:Computed(function(use)
					local baseSize = use(buttonSize) :: Vector2?
					if use(isOpen) and baseSize ~= nil then
						return UDim2.fromOffset(baseSize.X, use(DropdownHeight))
					else
						return UDim2.fromOffset(0, 0)
					end
				end),
				SPRING_SPEED,
				SPRING_DAMPING
			),
			ZIndex = 2,
			[Fusion.Out "AbsoluteSize"] = dropdownSize,

			Visible = scope:Computed(function(use)
				local size = use(dropdownSize) :: Vector2?
				if size ~= nil and size.Y > 0 then
					return true
				end

				return false
			end),

			[Fusion.Children] = {
				scope:New("ScrollingFrame") {
					Name = "Options",
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					ScrollBarThickness = 3,
					ScrollBarImageColor3 = currenTheme.colors.text,
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					CanvasSize = UDim2.new(),

					[Fusion.Children] = {
						scope:New("UIListLayout") {},

						--selene: allow(shadowing)
						scope:ForPairs(Options, function(use, scope, index, value)
							return index,
								scope:choice {
									Size = UDim2.fromOffset(150, 42),
									BackgroundColor = props.BackgroundColor,
									Text = use(value),
									TextColor = TextColor,
									FontWeight = scope:Computed(function(use)
										if use(value) == use(Text) then
											return Enum.FontWeight.Bold
										else
											return Enum.FontWeight.Regular
										end
									end),
									OnSelect = function()
										triggerHover:set(true)
										OnOptionSelected(index, use(value))
										isOpen:set(false)
										task.delay(0.15, function()
											triggerHover:set(false)
										end)
									end,
								}
						end),
					},
				},
			},
		})),
	}
end
