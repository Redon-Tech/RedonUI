local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)

local Components = {}

export type props = {
	Name: Fusion.UsedAs<string>,
	Border: Fusion.UsedAs<number>?,
	BorderColor: Fusion.UsedAs<string>?,
	CornerRadius: Fusion.UsedAs<UDim>?,
}

return function<T>(scope: Fusion.Scope<any>, props: props & { ClassName: T }): T
	local Scope = Fusion.innerScope(scope, Fusion, Components, Util)

	return Scope:New(props.ClassName) {
		Name = props.Name,

		[Fusion.Children] = {},
	}
end
