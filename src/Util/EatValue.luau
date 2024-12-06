local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)

return function(props: Fusion.PropertyTable, value: string | Fusion.SpecialKey): any
	local newValue = props[value]
	props[value] = nil
	return newValue
end
