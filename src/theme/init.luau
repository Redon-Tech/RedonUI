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
	"rosewater",
	"flamingo",
	"pink",
	"mauve",
	"red",
	"maroon",
	"peach",
	"yellow",
	"green",
	"teal",
	"sky",
	"sapphire",
	"blue",
	"lavender",
	"text",
	"subtext1",
	"subtext0",
	"overlay2",
	"overlay1",
	"overlay0",
	"surface2",
	"surface1",
	"surface0",
	"base",
	"mantle",
	"crust",
	"white",
	"black",
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
} :: theme

for themeName, colors in pairs(catppuccin) do
	for colorName, color in pairs(colors) do
		theme[themeName].colors[colorName] = color
	end
end

theme.theme = Fusion.Contextual(theme.mocha)

return theme
