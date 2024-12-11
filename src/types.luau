--# selene: allow(unused_variable)

local RedonUI = script.Parent
local Fusion = require(RedonUI.Parent.Fusion)
local Utils = require(RedonUI.Util)

export type Scope = Fusion.Scope<typeof(Fusion) & typeof(Utils)>

return nil
