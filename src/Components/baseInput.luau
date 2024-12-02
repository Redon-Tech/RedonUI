local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)

local base = require(RedonUI.Components.base)
local Components = {
	base = base,
}

export type props = base.props & {
	Disabled: Fusion.UsedAs<boolean>,

	OnMouseEnter: Fusion.UsedAs<() -> ()>,
	OnMouseLeave: Fusion.UsedAs<() -> ()>,

	IsHovering: Fusion.UsedAs<boolean>,
}

return function<T>(scope: Fusion.Scope<any>, props: props & { ClassName: T }): T
	local Scope = Fusion.innerScope(scope, Fusion, Components, Util)

	return Scope:base(props.ClassName)(Scope:CombineProperties(props, {
		[Fusion.OnEvent "MouseEnter"] = function()
			if props.Disabled then
				return
			end
			Scope:peek(props.OnMouseEnter)()
		end,

		[Fusion.OnEvent "MouseLeave"] = function()
			if props.Disabled then
				return
			end
			Scope:peek(props.OnMouseLeave)()
		end,
	}))
end
