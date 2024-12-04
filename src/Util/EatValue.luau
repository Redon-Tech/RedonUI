return function<I, V>(props: { [I]: V }, value: I)
	local newValue = props[value]
	props[value] = nil
	return newValue
end
