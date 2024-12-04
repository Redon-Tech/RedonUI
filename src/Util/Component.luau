--[[
    insert credits here
]]

local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local CombineProperties = require(RedonUI.Util.CombineProperties)

export type Scope = Fusion.Scope<typeof(Fusion) & any>

return function<props>(fn: (scope: Scope, props: Fusion.PropertyTable & props) -> Instance)
	return function(scope: Scope, ...: props & Fusion.PropertyTable)
		local combinedProps = CombineProperties(...) :: Fusion.PropertyTable & props
		return fn(scope, combinedProps)
	end
end
