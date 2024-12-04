local RedonUI = script.Parent.Parent

local Fusion = require(RedonUI.Parent.Fusion)
local Util = require(RedonUI.Util)

local baseInput = require(RedonUI.Components.baseInput)
local Components = {
	baseInput = baseInput,
}

export type props = baseInput.props & {
	OnActivated: (() -> ())?,
	OnMouseButton1Click: (() -> ())?,
	OnMouseButton1Down: (() -> ())?,
	OnMouseButton1Up: (() -> ())?,
	OnMouseButton2Click: (() -> ())?,
	OnMouseButton2Down: (() -> ())?,
	OnMouseButton2Up: (() -> ())?,
}

return function(baseScope: Fusion.Scope<any>, props: props): TextButton
	local scope = Fusion.innerScope(baseScope, Fusion, Components, Util)
	local class = "TextButton"

	return scope:baseInput(scope.CombineProperties(props, {
		ClassName = class,
		[Fusion.OnEvent "Activated"] = scope:PeekIfEnabled(props, props.OnActivated),
		[Fusion.OnEvent "MouseButton1Click"] = scope:PeekIfEnabled(props, props.OnMouseButton1Click),
		[Fusion.OnEvent "MouseButton1Down"] = scope:PeekIfEnabled(props, props.OnMouseButton1Down),
		[Fusion.OnEvent "MouseButton1Up"] = scope:PeekIfEnabled(props, props.OnMouseButton1Up),
		[Fusion.OnEvent "MouseButton2Click"] = scope:PeekIfEnabled(props, props.OnMouseButton2Click),
		[Fusion.OnEvent "MouseButton2Down"] = scope:PeekIfEnabled(props, props.OnMouseButton2Down),
		[Fusion.OnEvent "MouseButton2Up"] = scope:PeekIfEnabled(props, props.OnMouseButton2Up),
	}))
end
