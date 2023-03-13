local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  b.completion.spell,

  b.diagnostics.codespell,
  b.diagnostics.cppcheck,
  b.diagnostics.cpplint,
  b.diagnostics.markdownlint,
  b.diagnostics.mypy,
  b.diagnostics.pycodestyle,

  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.formatting.stylua,
  b.formatting.autopep8,
  b.formatting.astyle,
  b.formatting.codespell,
  b.formatting.isort,
  b.formatting.pg_format,

  b.hover.dictionary,

}

null_ls.setup {
  debug = true,
  sources = sources,
}
