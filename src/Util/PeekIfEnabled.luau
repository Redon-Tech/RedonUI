local RedonUI = script.Parent.Parent
local Fusion = require(RedonUI.Parent.Fusion)

return function(scope: Fusion.Scope<typeof(Fusion)>, props: { Disabled: Fusion.UsedAs<boolean> }, func: (() -> ())?)
	if Fusion.peek(props.Disabled) == true or func == nil then
		return
	end
	return scope.peek(func)()
end
