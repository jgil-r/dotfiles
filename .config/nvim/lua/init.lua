-- nvim-express_line
local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')

local git_branch = subscribe.buf_autocmd(
  "el_git_branch",
  "BufEnter",
  function(window, buffer)
    local branch = extensions.git_branch(window, buffer)
    if branch then
      return " " .. extensions.git_icon() .. " " .. branch
    end
  end
)

local git_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
  local icon = extensions.file_icon(_, bufnr)
  if icon then
    return icon .. " "
  end
  return ""
end)

local function lsp_info()
  local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
  local errors = vim.lsp.diagnostic.get_count(0, "Error")
  local hints = vim.lsp.diagnostic.get_count(0, "Hint")

  return string.format("LSP: H %d W %d E %d", hints, warnings, errors)
end

require('el').setup {
  generator = function(_, _)
    return {
      extensions.gen_mode {
        format_string = ' %s '
      },
      git_branch,
      ' ',
      sections.split,
      git_icon,
      builtin.tail_file,
      ' | ',
      lsp_info,
      sections.split,
      '[', builtin.line, '/', builtin.number_of_lines,  ':', builtin.column, ']',
    }
  end
}

-- Neovim lsp
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.tailwindcss.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.jsonls.setup{
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = false;
    tags = true;
    snippets_nvim = false;
    treesitter = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap("n", "K", "v:lua vim.lsp.buf.hover()", opts)
