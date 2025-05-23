--[[
    Taken and modified from https://github.com/catppuccin/lua/blob/main/catppuccin-amalg.lua
    modified for Roblox color3 support
    and typing

    MIT License

    Copyright (c) 2021 Catppuccin

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]

export type accents<T> = {
	rosewater: T,
	flamingo: T,
	pink: T,
	mauve: T,
	red: T,
	maroon: T,
	peach: T,
	yellow: T,
	green: T,
	teal: T,
	sky: T,
	sapphire: T,
	blue: T,
	lavender: T,
}

export type neutrals<T> = {
	text: T,
	subtext1: T,
	subtext0: T,
	overlay2: T,
	overlay1: T,
	overlay0: T,
	surface2: T,
	surface1: T,
	surface0: T,
	base: T,
	mantle: T,
	crust: T,
}

export type catppuccinColors = accents<Color3> & neutrals<Color3> & {
	name: string,
}

local mocha = {
	name = "mocha",
	rosewater = Color3.fromHex("#f5e0dc"),
	flamingo = Color3.fromHex("#f2cdcd"),
	pink = Color3.fromHex("#f5c2e7"),
	mauve = Color3.fromHex("#cba6f7"),
	red = Color3.fromHex("#f38ba8"),
	maroon = Color3.fromHex("#eba0ac"),
	peach = Color3.fromHex("#fab387"),
	yellow = Color3.fromHex("#f9e2af"),
	green = Color3.fromHex("#a6e3a1"),
	teal = Color3.fromHex("#94e2d5"),
	sky = Color3.fromHex("#89dceb"),
	sapphire = Color3.fromHex("#74c7ec"),
	blue = Color3.fromHex("#89b4fa"),
	lavender = Color3.fromHex("#b4befe"),
	text = Color3.fromHex("#cdd6f4"),
	subtext1 = Color3.fromHex("#bac2de"),
	subtext0 = Color3.fromHex("#a6adc8"),
	overlay2 = Color3.fromHex("#9399b2"),
	overlay1 = Color3.fromHex("#7f849c"),
	overlay0 = Color3.fromHex("#6c7086"),
	surface2 = Color3.fromHex("#585b70"),
	surface1 = Color3.fromHex("#45475a"),
	surface0 = Color3.fromHex("#313244"),
	base = Color3.fromHex("#1e1e2e"),
	mantle = Color3.fromHex("#181825"),
	crust = Color3.fromHex("#11111b"),
}
local macchiato = {
	name = "macchiato",
	rosewater = Color3.fromHex("#f4dbd6"),
	flamingo = Color3.fromHex("#f0c6c6"),
	pink = Color3.fromHex("#f5bde6"),
	mauve = Color3.fromHex("#c6a0f6"),
	red = Color3.fromHex("#ed8796"),
	maroon = Color3.fromHex("#ee99a0"),
	peach = Color3.fromHex("#f5a97f"),
	yellow = Color3.fromHex("#eed49f"),
	green = Color3.fromHex("#a6da95"),
	teal = Color3.fromHex("#8bd5ca"),
	sky = Color3.fromHex("#91d7e3"),
	sapphire = Color3.fromHex("#7dc4e4"),
	blue = Color3.fromHex("#8aadf4"),
	lavender = Color3.fromHex("#b7bdf8"),
	text = Color3.fromHex("#cad3f5"),
	subtext1 = Color3.fromHex("#b8c0e0"),
	subtext0 = Color3.fromHex("#a5adcb"),
	overlay2 = Color3.fromHex("#939ab7"),
	overlay1 = Color3.fromHex("#8087a2"),
	overlay0 = Color3.fromHex("#6e738d"),
	surface2 = Color3.fromHex("#5b6078"),
	surface1 = Color3.fromHex("#494d64"),
	surface0 = Color3.fromHex("#363a4f"),
	base = Color3.fromHex("#24273a"),
	mantle = Color3.fromHex("#1e2030"),
	crust = Color3.fromHex("#181926"),
}
local latte = {
	name = "latte",
	rosewater = Color3.fromHex("#dc8a78"),
	flamingo = Color3.fromHex("#dd7878"),
	pink = Color3.fromHex("#ea76cb"),
	mauve = Color3.fromHex("#8839ef"),
	red = Color3.fromHex("#d20f39"),
	maroon = Color3.fromHex("#e64553"),
	peach = Color3.fromHex("#fe640b"),
	yellow = Color3.fromHex("#df8e1d"),
	green = Color3.fromHex("#40a02b"),
	teal = Color3.fromHex("#179299"),
	sky = Color3.fromHex("#04a5e5"),
	sapphire = Color3.fromHex("#209fb5"),
	blue = Color3.fromHex("#1e66f5"),
	lavender = Color3.fromHex("#7287fd"),
	text = Color3.fromHex("#4c4f69"),
	subtext1 = Color3.fromHex("#5c5f77"),
	subtext0 = Color3.fromHex("#6c6f85"),
	overlay2 = Color3.fromHex("#7c7f93"),
	overlay1 = Color3.fromHex("#8c8fa1"),
	overlay0 = Color3.fromHex("#9ca0b0"),
	surface2 = Color3.fromHex("#acb0be"),
	surface1 = Color3.fromHex("#bcc0cc"),
	surface0 = Color3.fromHex("#ccd0da"),
	base = Color3.fromHex("#eff1f5"),
	mantle = Color3.fromHex("#e6e9ef"),
	crust = Color3.fromHex("#dce0e8"),
}
local frappe = {
	name = "frappe",
	rosewater = Color3.fromHex("#f2d5cf"),
	flamingo = Color3.fromHex("#eebebe"),
	pink = Color3.fromHex("#f4b8e4"),
	mauve = Color3.fromHex("#ca9ee6"),
	red = Color3.fromHex("#e78284"),
	maroon = Color3.fromHex("#ea999c"),
	peach = Color3.fromHex("#ef9f76"),
	yellow = Color3.fromHex("#e5c890"),
	green = Color3.fromHex("#a6d189"),
	teal = Color3.fromHex("#81c8be"),
	sky = Color3.fromHex("#99d1db"),
	sapphire = Color3.fromHex("#85c1dc"),
	blue = Color3.fromHex("#8caaee"),
	lavender = Color3.fromHex("#babbf1"),
	text = Color3.fromHex("#c6d0f5"),
	subtext1 = Color3.fromHex("#b5bfe2"),
	subtext0 = Color3.fromHex("#a5adce"),
	overlay2 = Color3.fromHex("#949cbb"),
	overlay1 = Color3.fromHex("#838ba7"),
	overlay0 = Color3.fromHex("#737994"),
	surface2 = Color3.fromHex("#626880"),
	surface1 = Color3.fromHex("#51576d"),
	surface0 = Color3.fromHex("#414559"),
	base = Color3.fromHex("#303446"),
	mantle = Color3.fromHex("#292c3c"),
	crust = Color3.fromHex("#232634"),
}

local colors: {
	latte: catppuccinColors,
	frappe: catppuccinColors,
	macchiato: catppuccinColors,
	mocha: catppuccinColors,
} =
	{
		latte = latte,
		frappe = frappe,
		macchiato = macchiato,
		mocha = mocha,
	}

return colors
