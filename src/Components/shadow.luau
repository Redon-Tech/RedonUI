local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)

local base = require(RedonUI.Components.base)
local Components = {
	base = base,
}

export type props = base.props & {
	shadowBlur: Fusion.UsedAs<number>?,
	shadowSize: Fusion.UsedAs<number>?,
	shadowTransparency: Fusion.UsedAs<number>?,
}

return function(baseScope: Fusion.Scope<any>, props: props)
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)
end
