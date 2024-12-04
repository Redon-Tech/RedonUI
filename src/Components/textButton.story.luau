local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local uiLabs = require(RedonUI.Parent["ui-labs"])
local theme = require(RedonUI.theme)

local textButton = require(RedonUI.Components.textButton)
local Components = {
	textButton = textButton,
}

return uiLabs.CreateFusionStory({
	fusion = Fusion,
}, function(props: uiLabs.FusionProps)
	local scope = Fusion.innerScope(props.scope, Components)
	local currentTheme = theme.theme:now()

	return scope:textButton {
		Parent = props.target,
		Size = UDim2.new(0, 350, 0, 80),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),

		-- BackgroundColor = "sapphire",
		Gradient = ColorSequence.new(currentTheme.colors.sky, currentTheme.colors.sapphire),
		Border = 3,
		CornerRadius = UDim.new(0, 25),

		Text = "TextButton",
		TextColor = "mantle",

		OnMouseEnter = function()
			print("MouseEnter")
		end,

		OnActivated = function()
			print("Activated")
		end,
		OnMouseButton1Click = function()
			print("MouseButton1Click")
		end,
		OnMouseButton1Down = function()
			print("MouseButton1Down")
		end,
		OnMouseButton1Up = function()
			print("MouseButton1Up")
		end,
		OnMouseButton2Click = function()
			print("MouseButton2Click")
		end,
		OnMouseButton2Down = function()
			print("MouseButton2Down")
		end,
		OnMouseButton2Up = function()
			print("MouseButton2Up")
		end,
	}
end)
