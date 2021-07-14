require("express_line")
require("lsp")
require("compe_nvim")

vim.o.completeopt = "menuone,noselect"

-- Theme
vim.g.material_style = 'darker'
vim.g.material_custom_colors = { bg = "#1d1f21" }
require('material').set()
