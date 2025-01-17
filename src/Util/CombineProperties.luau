--[[
	Inspiration https://github.com/cameronpcampbell/Ignite/blob/61cf3cc931099aed88c5cc6b9c2df10af8ad5a2d/src/Modules/CombineProps.luau

	Wrote it to be more readable
]]

local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)

return function(...: { [any]: any })
	local combinedProps = {}
	local combinedChildren = {}

	for _, data in { ... } do
		if typeof(data) == "table" and not data.kind then
			for propName, propValue in data do
				if propName == Fusion.Children then
					if typeof(propValue) == "table" and not propValue.kind then
						for _, child in propValue do
							table.insert(combinedChildren, child)
						end
					else
						table.insert(combinedChildren, propValue)
					end
				end

				combinedProps[propName] = propValue
			end
		end
	end

	if #combinedChildren then
		combinedProps[Fusion.Children] = combinedChildren
	end

	return combinedProps
end
