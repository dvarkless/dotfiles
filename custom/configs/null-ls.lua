local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.completion.tags,
  b.completion.spell,

  b.diagnostics.clang_check,
  b.diagnostics.cspell,
  b.diagnostics.markdownlint,
  b.diagnostics.pycodestyle,
  b.diagnostics.pylama,
  b.diagnostics.codespell,

  -- b.formatting.astyle,
  b.formatting.pg_format,
  b.formatting.black,
  b.formatting.isort,
  b.formatting.stylua,

  b.hover.dictionary,
  b.code_actions.refactoring,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
