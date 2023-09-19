if !exists('g:lspconfig')
  finish
endif

lua << EOF
--vim.lsp.set_log_level("debug")
EOF

lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>j', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- formatting
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    vim.api.nvim_command [[augroup END]]
  end

  --protocol.SymbolKind = { }
  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
end

-- Set up completion using nvim_cmp with LSP source
--local capabilities = require('cmp_nvim_lsp').update_capabilities(
--  vim.lsp.protocol.make_client_capabilities()
--)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- nvim_lsp.flow.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }

local dlsconfig = require 'diagnosticls-configs'

dlsconfig.init {
  -- Your custom attach function
  on_attach = on_attach,
}

local eslint_d = require 'diagnosticls-configs.linters.eslint_d'
--local standard = require 'diagnosticls-configs.linters.standard'
local prettier = require 'diagnosticls-configs.formatters.prettier'
--local prettier_standard = require 'diagnosticls-configs.formatters.prettier_standard'
dlsconfig.setup {
  ['javascript'] = {
    linter = eslint_d,
    formatter = prettier
  },
  ['json'] = {
    -- linter = { eslint_d, standard },
    -- formatter = { prettier, prettier_standard }
    linter = { eslint_d },
    formatter = { prettier }
  },
  ['typescript'] = {
    -- linter = { eslint_d, standard },
    -- formatter = { prettier, prettier_standard }
    linter = { eslint_d },
    formatter = { prettier }
  },
  ['typescriptreact'] = {
    -- Add multiple linters
    -- linter = { eslint_d, standard },
    -- Add multiple formatters
    -- formatter = { prettier, prettier_standard }
    linter = { eslint_d },
    formatter = { prettier }
  }
}

nvim_lsp.denols.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

-- require'lspconfig'.gopls.setup{}
nvim_lsp.gopls.setup{
  on_attach = on_attach,
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  single_file_support = false
}
-- "
-- " nvim_lsp.diagnosticls.setup {
-- "   on_attach = on_attach,
-- "   filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
-- "   init_options = {
-- "     linters = {
-- "       eslint = {
-- "         command = 'eslint_d',
-- "         rootPatterns = { '.git' },
-- "         debounce = 100,
-- "         args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
-- "         sourceName = 'eslint_d',
-- "         parseJson = {
-- "           errorsRoot = '[0].messages',
-- "           line = 'line',
-- "           column = 'column',
-- "           endLine = 'endLine',
-- "           endColumn = 'endColumn',
-- "           message = '[eslint] ${message} [${ruleId}]',
-- "           security = 'severity'
-- "         },
-- "         securities = {
-- "           [2] = 'error',
-- "           [1] = 'warning'
-- "         }
-- "       },
-- "     },
-- "     filetypes = {
-- "       javascript = 'eslint',
-- "       javascriptreact = 'eslint',
-- "       typescript = 'eslint',
-- "       typescriptreact = 'eslint',
-- "     },
-- "     formatters = {
-- "       eslint_d = {
-- "         command = 'eslint_d',
-- "         args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
-- "         rootPatterns = { '.git' },
-- "       },
-- "       prettier = {
-- "         command = 'prettier',
-- "         args = { '--stdin-filepath', '%filename' }
-- "       }
-- "     },
-- "     formatFiletypes = {
-- "       css = 'prettier',
-- "       javascript = 'prettier',
-- "       javascriptreact = 'prettier',
-- "       json = 'prettier',
-- "       scss = 'prettier',
-- "       less = 'prettier',
-- "       typescript = 'prettier',
-- "       typescriptreact = 'prettier',
-- "       json = 'prettier',
-- "       markdown = 'prettier',
-- "     }
-- "   }
-- " }

-- formatting
-- " vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
-- "   if err ~= nil or result == nil then
-- "     return
-- "   end
-- "   if not vim.api.nvim_buf_get_option(bufnr, "modified") then
-- "     local view = vim.fn.winsaveview()
-- "     vim.lsp.util.apply_text_edits(result, bufnr)
-- "     vim.fn.winrestview(view)
-- "     if bufnr == nil or bufnr == vim.api.nvim_get_current_buf() then
-- "       vim.api.nvim_command("noautocmd :update")
-- "     end
-- "   end
-- " end

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)

EOF
