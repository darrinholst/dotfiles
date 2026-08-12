local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local opts = { delimiters = "[]" }

return {
  s("cl", fmt("console.log([]);", { i(0) }, opts)),

  s(
    "desc",
    fmt(
      [[
describe("[]", () => {
  []
});]],
      { i(1, "The Thing"), i(0) },
      opts
    )
  ),

  s(
    "be",
    fmt(
      [[
beforeEach(() => {
  []
});]],
      { i(0) },
      opts
    )
  ),

  s(
    "bea",
    fmt(
      [[
beforeEach(async () => {
  []
});]],
      { i(0) },
      opts
    )
  ),

  s(
    "it",
    fmt(
      [[
it("should []", () => {
  []
});]],
      { i(1, "do something"), i(0) },
      opts
    )
  ),

  s(
    "ita",
    fmt(
      [[
it("should []", async () => {
  []
});]],
      { i(1, "do something"), i(0) },
      opts
    )
  ),

  s("eoc", fmt("expect.objectContaining([])", { i(1, "{}") }, opts)),
}
