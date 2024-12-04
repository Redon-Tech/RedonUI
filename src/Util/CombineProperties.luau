--[[
    "Borrowed" from https://github.com/cameronpcampbell/Ignite/blob/61cf3cc931099aed88c5cc6b9c2df10af8ad5a2d/src/Modules/CombineProps.luau

	MIT License

	Copyright (c) 2024 Cameron Campbell

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

local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)

return function(...: { [any]: any })
	local combinedProps = {}
	local combinedChildren = {}

	for i = 1, select("#", ...) do
		local propTble = select(i, ...)

		for propName, propValue in propTble do
			if propName == Fusion.Children then
				if typeof(propValue) == "table" and not propValue.kind then
					for _, child in propValue do
						table.insert(combinedChildren, child)
					end
				else
					table.insert(combinedChildren, propValue)
				end
				continue
			end

			combinedProps[propName] = propValue
		end
	end

	if #combinedChildren then
		combinedProps[Fusion.Children] = combinedChildren
	end

	return combinedProps
end
