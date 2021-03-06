nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"map <c-p> to manually trigger completion
imap <silent> <c-p> <Plug>(completion_trigger)

lua << EOF
    local on_attach = require'completion'.on_attach 

    require'lspconfig'.tsserver.setup{ on_attach=on_attach }
    require'lspconfig'.vimls.setup{ on_attach=on_attach }
    require'lspconfig'.cssls.setup{ on_attach=on_attach }
    require'lspconfig'.jsonls.setup {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
                end
            }
        }
    }

    function goimports(timeoutms)
        local context = { source = { organizeImports = true } }
        vim.validate { context = { context, "t", true } }

        local params = vim.lsp.util.make_range_params()
        params.context = context

        -- See the implementation of the textDocument/codeAction callback
        -- (lua/vim/lsp/handler.lua) for how to do this properly.
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
        if not result or next(result) == nil then return end
        local actions = result[1].result
        if not actions then return end
        local action = actions[1]

        -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
        -- is a CodeAction, it can have either an edit, a command or both. Edits
        -- should be executed first.
        if action.edit or type(action.command) == "table" then
            if action.edit then
                vim.lsp.util.apply_workspace_edit(action.edit)
            end
            if type(action.command) == "table" then
                vim.lsp.buf.execute_command(action.command)
            end
        else
            vim.lsp.buf.execute_command(action)
        end
    end

    require'lspconfig'.gopls.setup{ 
        on_attach=on_attach,
        cmd = {"gopls", "serve"},
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    }
EOF

autocmd BufWritePre *.go lua goimports(1000)
