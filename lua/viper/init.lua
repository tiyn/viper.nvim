local M = {}

function M.setup()
  local group = vim.api.nvim_create_augroup("ViperSyntax", { clear = true })

  local function enable_viper_syntax()
    if vim.b.viper_syntax_loaded then
      return
    end
    vim.b.viper_syntax_loaded = true

    vim.cmd("syntax enable")
    vim.cmd("syntax clear")

    vim.cmd([[
      syntax keyword viperKeyword method function returns requires ensures invariant
      syntax keyword viperKeyword if else while var field predicate
      syntax keyword viperKeyword assert assume inhale exhale fold unfold

      syntax keyword viperType Int Bool Ref

      syntax match viperComment "//.*$"
      syntax match viperNumber "\v\d+"
    ]])

    vim.api.nvim_set_hl(0, "viperKeyword", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "viperType", { link = "Type" })
    vim.api.nvim_set_hl(0, "viperComment", { link = "Comment" })
    vim.api.nvim_set_hl(0, "viperNumber", { link = "Number" })
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "viper",
    callback = enable_viper_syntax,
  })

  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = group,
    pattern = "*.vpr",
    callback = enable_viper_syntax,
  })
end

return M
