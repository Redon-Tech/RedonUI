local RedonUI = script.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local catppuccin = require(script.catppuccin)

export type colors =
	"rosewater"
	| "flamingo"
	| "pink"
	| "mauve"
	| "red"
	| "maroon"
	| "peach"
	| "yellow"
	| "green"
	| "teal"
	| "sky"
	| "sapphire"
	| "blue"
	| "lavender"
	| "text"
	| "subtext1"
	| "subtext0"
	| "overlay2"
	| "overlay1"
	| "overlay0"
	| "surface2"
	| "surface1"
	| "surface0"
	| "base"
	| "mantle"
	| "crust"

local colorNames = {
	"rosewater", -- 1
	"flamingo", -- 2
	"pink", -- 3
	"mauve", -- 4
	"red", -- 5
	"maroon", -- 6
	"peach", -- 7
	"yellow", -- 8
	"green", -- 9
	"teal", -- 10
	"sky", -- 11
	"sapphire", -- 12
	"blue", -- 13
	"lavender", -- 14
	"text", -- 15
	"subtext1", -- 16
	"subtext0", -- 17
	"overlay2", -- 18
	"overlay1", -- 19
	"overlay0", -- 20
	"surface2", -- 21
	"surface1", -- 22
	"surface0", -- 23
	"base", -- 24
	"mantle", -- 25
	"crust", -- 26
	"white", -- 27
	"black", -- 28
}

export type fontWeights =
	"Thin"
	| "ExtraLight"
	| "Light"
	| "Regular"
	| "Medium"
	| "SemiBold"
	| "Bold"
	| "ExtraBold"
	| "Heavy"

local fontWeights = {
	"Thin", -- 1
	"ExtraLight", -- 2
	"Light", -- 3
	"Regular", -- 4
	"Medium", -- 5
	"SemiBold", -- 6
	"Bold", -- 7
	"ExtraBold", -- 8
	"Heavy", -- 9
}

type colorTypes = catppuccin.neutrals<Color3> & catppuccin.accents<Color3> & {
	white: Color3,
	black: Color3,
}

type actualTheme = {
	colors: colorTypes,
	font: {
		[Enum.FontWeight]: Font,
	},
}

type theme = {
	latte: actualTheme,
	frappe: actualTheme,
	macchiato: actualTheme,
	mocha: actualTheme,
	theme: Fusion.Contextual<actualTheme>,
	colors: { string },
	weights: { string },
}

local baseFont = "rbxassetid://12187365364"
local fonts = {}
for _, name: Enum.FontWeight in pairs(Enum.FontWeight:GetEnumItems()) do
	fonts[name] = Font.new(baseFont, name, Enum.FontStyle.Normal)
end

local theme = {
	latte = {
		colors = { white = Color3.fromRGB(0, 0, 0), black = Color3.fromRGB(255, 255, 255) },
		font = fonts,
	},
	frappe = {
		colors = { white = Color3.fromRGB(255, 255, 255), black = Color3.fromRGB(0, 0, 0) },
		font = fonts,
	},
	macchiato = {
		colors = { white = Color3.fromRGB(255, 255, 255), black = Color3.fromRGB(0, 0, 0) },
		font = fonts,
	},
	mocha = {
		colors = { white = Color3.fromRGB(255, 255, 255), black = Color3.fromRGB(0, 0, 0) },
		font = fonts,
	},
	colors = colorNames,
	weights = fontWeights,
} :: theme

for themeName, colors in pairs(catppuccin) do
	for colorName, color in pairs(colors) do
		theme[themeName].colors[colorName] = color
	end
end

theme.theme = Fusion.Contextual(theme.mocha)

return theme
