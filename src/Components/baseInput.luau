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

return function<T>(baseScope: Fusion.Scope<any>, props: props & { ClassName: T }): T
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)

	return scope:base(scope.CombineProperties(props, {
		[Fusion.OnEvent("MouseEnter")] = scope:PeekIfEnabled(props, props.OnMouseEnter),
		[Fusion.OnEvent("MouseLeave")] = scope:PeekIfEnabled(props, props.OnMouseLeave),
	}))
end
