local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)

local baseInput = require(RedonUI.Components.baseInput)
local Components = {
	baseInput = baseInput,
}

export type props = baseInput.props & {
	Text: Fusion.UsedAs<string>,
	TextColor: Fusion.UsedAs<string>,
}

return function(scope: Fusion.Scope<any>, props: props): TextButton
	local Scope = Fusion.innerScope(scope, Fusion, Components, Util)

	return Scope:baseInput("TextButton")(Scope:CombineProperties(props, {}))
end
