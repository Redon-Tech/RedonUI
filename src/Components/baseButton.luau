local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)
local theme = require(RedonUI.theme)
local types = require(RedonUI.types)

local base = require(RedonUI.Components.base)
local Components = {
	base = base,
}

export type props = base.baseProps & {
	MouseEnter: (() -> ())?,
	MouseLeave: (() -> ())?,
	MouseButton1Down: (() -> ())?,
	MouseButton1Up: (() -> ())?,

	ButtonGlow: Fusion.UsedAs<boolean>?,
	ButtonGlowColor: Fusion.UsedAs<theme.colors>?,

	Reactive: Fusion.UsedAs<boolean>?,
	TriggerHover: Fusion.UsedAs<boolean>?,

	ForceSpeed: number?,
	ForceDamping: number?,
}

local SPRING_SPEED = 30
local SPRING_DAMPING = 1

return function(baseScope: types.Scope, props: props)
	local scope = Fusion.innerScope(baseScope, Components)
	local currentTheme = theme.theme:now()

	local ForceSpeed = Util.EatValue(props, "ForceSpeed") :: number?
	local ForceDamping = Util.EatValue(props, "ForceDamping") :: number?
	if ForceSpeed ~= nil then
		SPRING_SPEED = ForceSpeed
	end
	if ForceDamping ~= nil then
		SPRING_DAMPING = ForceDamping
	end

	local Parent = Util.EatValue(props, "Parent") :: Fusion.UsedAs<Instance>?

	local Size = Util.EatValue(props, "Size") :: Fusion.UsedAs<UDim2>?
	local Position = Util.EatValue(props, "Position") :: Fusion.UsedAs<UDim2>?
	local AnchorPoint = Util.EatValue(props, "AnchorPoint") :: Fusion.UsedAs<Vector2>?
	local LayoutOrder = Util.EatValue(props, "LayoutOrder") :: Fusion.UsedAs<number>?
	local ZIndex = Util.EatValue(props, "ZIndex") :: Fusion.UsedAs<number>?

	local Reactive = Util.EatValue(props, "Reactive") :: Fusion.UsedAs<boolean>?

	local ButtonGlow = Util.EatValue(props, "ButtonGlow") :: Fusion.UsedAs<boolean>?
	local ButtonGlowColor = Util.EatValue(props, "ButtonGlowColor") :: Fusion.UsedAs<theme.colors>?

	local MouseEnter = Util.EatValue(props, "MouseEnter") :: (() -> ())?
	local MouseLeave = Util.EatValue(props, "MouseLeave") :: (() -> ())?
	local MouseButton1Down = Util.EatValue(props, "MouseButton1Down") :: (() -> ())?
	local MouseButton1Up = Util.EatValue(props, "MouseButton1Up") :: (() -> ())?
	local events = Util.StealEvents(props)

	local desiredButtonPosition = scope:Value(UDim2.fromScale(0.5, 0.5))
	local animatedButtonPosition = scope:Spring(desiredButtonPosition, SPRING_SPEED, SPRING_DAMPING)
	local desiredButtonSize = scope:Value(UDim2.fromScale(1, 1))
	local animatedButtonSize = scope:Spring(desiredButtonSize, SPRING_SPEED, SPRING_DAMPING)
	local isHovered = scope:Value(false)

	local TriggerHover = Util.EatValue(props, "TriggerHover") :: Fusion.UsedAs<boolean>?
	if TriggerHover ~= nil then
		scope:Observer(TriggerHover):onChange(function()
			if scope.peek(TriggerHover) == true then
				desiredButtonPosition:set(UDim2.fromScale(0.5, 0.4))
				desiredButtonSize:set(UDim2.fromScale(1.05, 1.05))
				isHovered:set(true)
			else
				desiredButtonPosition:set(UDim2.fromScale(0.5, 0.5))
				desiredButtonSize:set(UDim2.fromScale(1, 1))
				isHovered:set(false)
			end
		end)
	end

	return scope:New("Frame") {
		Parent = Parent,
		Name = `Container<{props.Name}>`,
		BackgroundTransparency = 1,

		Size = Size,
		Position = Position,
		AnchorPoint = AnchorPoint,
		LayoutOrder = LayoutOrder,
		ZIndex = ZIndex,

		[Fusion.Children] = {
			scope:base(scope.CombineProperties(props, {
				ClassName = "ImageButton",
				Name = props.Name,
				Size = animatedButtonSize,
				Position = animatedButtonPosition,
				AnchorPoint = Vector2.new(0.5, 0.5),

				[Fusion.OnEvent "MouseEnter"] = function()
					if Reactive then
						desiredButtonPosition:set(UDim2.fromScale(0.5, 0.4))
						desiredButtonSize:set(UDim2.fromScale(1.05, 1.05))
						isHovered:set(true)
					end
					if scope.peek(MouseEnter) ~= nil then
						scope.peek(MouseEnter)()
					end
				end,

				[Fusion.OnEvent "MouseLeave"] = function()
					desiredButtonPosition:set(UDim2.fromScale(0.5, 0.5))
					desiredButtonSize:set(UDim2.fromScale(1, 1))
					isHovered:set(false)
					if scope.peek(MouseLeave) ~= nil then
						scope.peek(MouseLeave)()
					end
				end,

				[Fusion.OnEvent "MouseButton1Down"] = function()
					if Reactive then
						desiredButtonPosition:set(UDim2.fromScale(0.5, 0.6))
						desiredButtonSize:set(UDim2.fromScale(0.95, 0.95))
					end
					if scope.peek(MouseButton1Down) ~= nil then
						scope.peek(MouseButton1Down)()
					end
				end,

				[Fusion.OnEvent "MouseButton1Up"] = function()
					if Reactive and scope.peek(isHovered) == true then
						desiredButtonPosition:set(UDim2.fromScale(0.5, 0.4))
						desiredButtonSize:set(UDim2.fromScale(1.05, 1.05))
					else
						desiredButtonPosition:set(UDim2.fromScale(0.5, 0.5))
						desiredButtonSize:set(UDim2.fromScale(1, 1))
					end
					if scope.peek(MouseButton1Up) ~= nil then
						scope.peek(MouseButton1Up)()
					end
				end,

				[Fusion.Children] = {
					scope:Computed(function(use)
						return if use(ButtonGlow) == true
							then scope:New("ImageLabel") {
								Name = "Glow",
								BackgroundTransparency = 1,
								ImageTransparency = 0.3,
								Image = "rbxassetid://131257669960828",
								-- selene: allow(shadowing)
								ImageColor3 = scope:Computed(function(use)
									return if use(ButtonGlowColor) ~= nil
										then currentTheme.colors[use(ButtonGlowColor)]
										else Color3.new(1, 1, 1)
								end),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(1, 1),
								ZIndex = -1,

								[Fusion.Children] = {
									-- selene: allow(shadowing)
									scope:Computed(function(use)
										return if use(props.CornerRadius) ~= nil
											then scope:New("UICorner") {
												CornerRadius = use(props.CornerRadius),
											}
											else nil
									end),

									-- selene: allow(shadowing)
									scope:Computed(function(use)
										return if use(props.Gradient) ~= nil and use(ButtonGlowColor) == nil
											then scope:New("UIGradient") {
												Color = use(props.Gradient),
												Transparency = use(props.GradientTransparency),
												Rotation = use(props.GradientRotation),
											}
											else nil
									end),
								},
							}
							else nil
					end),
				},
			}, events)),
		},
	}
end
