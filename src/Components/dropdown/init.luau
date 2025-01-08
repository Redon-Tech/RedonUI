local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

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
	Size: Fusion.UsedAs<UDim2>?,
	AnchorPoint: Fusion.UsedAs<Vector2>?,
	Position: Fusion.UsedAs<UDim2>?,
	BackgroundColor3: Fusion.UsedAs<Color3>?,

	Options: Fusion.UsedAs<{ [I]: V }>,
	OnOptionSelected: (I, V) -> (),

	DropdownHeight: Fusion.UsedAs<number>,
	DropdownYOffset: Fusion.UsedAs<UDim>?,
	RemoveForPadding: Fusion.UsedAs<UDim2>?,
	ScaleChoicesUpBy: Fusion.UsedAs<number>?,
}

local SPRING_SPEED = 30
local SPRING_DAMPING = 1

return function<I, V>(baseScope: types.Scope, props: props<I, V>)
	local scope = Fusion.innerScope(baseScope, Components)
	local currenTheme = theme.theme:now()

	local Text = Util.EatValue(props, "Text") :: Fusion.UsedAs<string>
	local TextColor3 = Util.EatValue(props, "TextColor3") :: Fusion.UsedAs<Color3>?
	local FontWeight = Util.EatValue(props, "FontWeight") :: Fusion.UsedAs<Enum.FontWeight>?
	local TextScaled = Util.EatValue(props, "TextScaled") :: Fusion.UsedAs<boolean>?
	local TextSize = Util.EatValue(props, "TextSize") :: Fusion.UsedAs<number>?
	local TextXAlignment = Util.EatValue(props, "TextXAlignment") :: Fusion.UsedAs<Enum.TextXAlignment>?
	local TextYAlignment = Util.EatValue(props, "TextYAlignment") :: Fusion.UsedAs<Enum.TextYAlignment>?
	local RichText = Util.EatValue(props, "RichText") :: Fusion.UsedAs<boolean>?
	local MaxTextSize = Util.EatValue(props, "MaxTextSize") :: Fusion.UsedAs<number>?

	local Options = Util.EatValue(props, "Options") :: Fusion.UsedAs<{ [I]: V }>
	local OnOptionSelected = Util.EatValue(props, "OnOptionSelected") :: (I, V) -> ()

	local DropdownHeight = Util.EatValue(props, "DropdownHeight") :: Fusion.UsedAs<number>
	local DropdownYOffset = Util.EatValue(props, "DropdownYOffset") :: Fusion.UsedAs<UDim>?
	local RemoveForPadding = Util.EatValue(props, "RemoveForPadding") :: Fusion.UsedAs<UDim2>?
	local ScaleChoicesUpBy = Util.EatValue(props, "ScaleChoicesUpBy") :: Fusion.UsedAs<number>?

	local Reactive = Util.EatValue(props, "Reactive") :: Fusion.UsedAs<boolean>?
	local ButtonGlow = Util.EatValue(props, "ButtonGlow") :: Fusion.UsedAs<boolean>?
	local ButtonGlowColor3 = Util.EatValue(props, "ButtonGlowColor3") :: Fusion.UsedAs<Color3>?
	local MouseEnter = Util.EatValue(props, "MouseEnter") :: (() -> ())?
	local MouseLeave = Util.EatValue(props, "MouseLeave") :: (() -> ())?
	local MouseButton1Down = Util.EatValue(props, "MouseButton1Down") :: (() -> ())?
	local MouseButton1Up = Util.EatValue(props, "MouseButton1Up") :: (() -> ())?
	local events = Util.StealEvents(props)

	local isOpen = scope:Value(false)
	local buttonSize = scope:Value(nil)
	local dropdownSize = scope:Value(nil)
	local triggerHover = scope:Value(false)
	local isFullyClosed = scope:Computed(function(use)
		return use(isOpen) == false and use(dropdownSize) == Vector2.new()
	end)

	return {
		scope:baseButton(scope.CombineProperties(props, {
			Reactive = Reactive,
			ButtonGlow = ButtonGlow,
			ButtonGlowColor3 = ButtonGlowColor3,
			MouseEnter = MouseEnter,
			MouseLeave = MouseLeave,
			MouseButton1Up = MouseButton1Up,
			TriggerHover = triggerHover,

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
					TextColor3 = TextColor3,
					FontWeight = FontWeight,
					TextScaled = TextScaled,
					TextSize = TextSize,
					TextXAlignment = TextXAlignment,
					TextYAlignment = TextYAlignment,
					RichText = RichText,
					MaxTextSize = MaxTextSize,
				},

				scope:New("ImageLabel") {
					Name = "Arrow",
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.fromScale(0.9, 0.5),
					Size = UDim2.fromOffset(20, 12),
					BackgroundTransparency = 1,
					Image = "rbxassetid://110726366161984",
					ImageColor3 = currenTheme.colors.text,
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

		scope:base {
			ClassName = "Frame",
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
				if use(isFullyClosed) == true then
					return basePosition or UDim2.new()
				end
				local baseSize = use(buttonSize) :: Vector2?
				local additionalYOffset = use(DropdownYOffset) :: UDim?
				if basePosition ~= nil and baseSize ~= nil then
					return basePosition
						+ UDim2.fromOffset(0, (baseSize.Y / 2) + 5)
						+ UDim2.new(UDim.new(), additionalYOffset or UDim.new())
				elseif baseSize ~= nil then
					return UDim2.fromOffset(0, (baseSize.Y / 2) + 5)
						+ UDim2.new(UDim.new(), additionalYOffset or UDim.new())
				end

				return UDim2.fromOffset(0, 0)
			end),
			Size = scope:Spring(
				scope:Computed(function(use)
					local baseSize = use(props.Size) :: UDim2?
					if use(isOpen) and baseSize ~= nil then
						return UDim2.new(baseSize.X, UDim.new(0, use(DropdownHeight)))
					elseif baseSize ~= nil then
						return UDim2.new(baseSize.X, UDim.new())
					end

					return UDim2.new()
				end),
				SPRING_SPEED,
				SPRING_DAMPING
			),
			ZIndex = 2,
			BackgroundTransparency = 1,

			[Fusion.Children] = Fusion.Child {
				scope:base(scope.CombineProperties(props, {
					ClassName = "CanvasGroup",
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size = scope:Spring(
						scope:Computed(function(use)
							local baseSize = use(props.Size) :: UDim2?
							local removeForPadding = UDim2.new()
							if RemoveForPadding ~= nil then
								removeForPadding = use(RemoveForPadding) :: UDim2
							end

							if use(isOpen) and baseSize ~= nil then
								return UDim2.fromScale(1, 1) - removeForPadding
							else
								return UDim2.fromScale(0, 0) - removeForPadding
							end
						end),
						SPRING_SPEED,
						SPRING_DAMPING
					),

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

							[Fusion.Children] = Fusion.Child {
								scope:New("UIListLayout") {},

								--selene: allow(shadowing)
								scope:ForPairs(Options, function(use, scope: typeof(scope), index, value)
									local size = use(buttonSize) :: Vector2?
									if size == nil then
										size = Vector2.new(150, 42)
									end
									if ScaleChoicesUpBy ~= nil then
										local by = use(ScaleChoicesUpBy)
										size = size :: Vector2 * Vector2.new(by, by)
									end
									return index,
										scope:choice {
											Size = UDim2.fromOffset((size :: Vector2).X, (size :: Vector2).Y), --UDim2.fromOffset(150, 42),
											BackgroundColor3 = props.BackgroundColor3,
											Text = use(value),
											FontWeight = scope:Computed(function(use)
												if use(value) == use(Text) then
													return Enum.FontWeight.Bold
												else
													return Enum.FontWeight.Regular
												end
											end),

											TextColor3 = TextColor3,
											TextScaled = TextScaled,
											TextSize = TextSize,
											TextXAlignment = TextXAlignment,
											TextYAlignment = TextYAlignment,
											RichText = RichText,
											MaxTextSize = MaxTextSize,

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
			},
		},
	}
end
