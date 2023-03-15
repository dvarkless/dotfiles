local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  b.completion.luasnip,
  b.completion.tags,

  b.diagnostics.cppcheck,
  b.diagnostics.cspell,
  b.diagnostics.cpplint,
  b.diagnostics.markdownlint,
  b.diagnostics.pycodestyle,

  -- b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.formatting.astyle,
  b.formatting.pg_format,

  b.hover.dictionary,
  b.code_actions.refactoring,

}

null_ls.setup {
  debug = true,
  sources = sources,
}
