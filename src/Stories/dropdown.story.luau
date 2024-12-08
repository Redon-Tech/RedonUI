local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local base = require(RedonUI.Components.base)
local dropdown = require(RedonUI.Components.dropdown)
local Components = {
	base = base,
	dropdown = dropdown,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
	controls = {
		BackgroundColor = uiLabs.Choose(theme.colors, 26),
		Border = 1,
		CornerRadius = 10,

		TextColor = uiLabs.Choose(theme.colors, 15),
		FontWeight = uiLabs.Choose(theme.weights, 4),
	},
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope, Components)

	return scope:base {
		ClassName = "Frame",
		Parent = props.target,
		Size = UDim2.new(0, 250, 0, 250),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),

		BackgroundColor = "base",

		CornerRadius = UDim.new(0, 15),

		Border = 1,
		BorderColor = "subtext1",

		[Fusion.Children] = {
			--selene: allow(shadowing)
			scope:ForValues({ 1, 2 }, function(_, scope, value)
				local text = scope:Value("test1")
				return scope:dropdown {
					Size = UDim2.fromOffset(150, 42),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0.5, 0, 0.5, if value == 2 then 40 else -40),
					DropdownHeight = 126,

					BackgroundColor = props.controls.BackgroundColor,
					Border = props.controls.Border,
					CornerRadius = scope:Computed(function(use)
						return UDim.new(0, use(props.controls.CornerRadius))
					end),

					Text = text,
					Options = {
						"test1",
						"test2",
						"test3",
						"test4",
						"test5",
					},
					OnOptionSelected = function(_, value)
						text:set(value)
					end,

					TextColor = props.controls.TextColor,
					FontWeight = scope:Computed(function(use)
						-- Yes, this ignores type checking, but we KNOW that the value is a valid enum
						return (Enum.FontWeight :: any)[use(props.controls.FontWeight)]
					end),

					Reactive = true,
				}
			end),
		},
	}
end)
