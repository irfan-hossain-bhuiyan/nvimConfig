local ls    = require("luasnip")
local s     = ls.snippet
local t     = ls.text_node
local i     = ls.insert_node
local rep   = require('luasnip.extras').rep
local cHeader=s({trig="ifndef", descr="Create c header condition"}, {
    t("#ifndef "),
    i(1, "HEADER_H"),
    t({"","#define "}),
    rep(1),
    t({"","","#endif"})
  })

ls.add_snippets('c', {cHeader})
ls.add_snippets('h', {cHeader})
-- local ts_utils=require("nvim")
