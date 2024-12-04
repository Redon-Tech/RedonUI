return function<I, V>(props: { [I]: V })
	local events = {}

	for i, v in props do
		if typeof(i) == "table" and i.kind == "OnEvent" then
			props[i] = nil
			events[i] = v
		end
	end

	return events
end
