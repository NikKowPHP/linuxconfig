" General Settings
set nocompatible            " Use Vim settings, not Vi
filetype plugin indent on   " Enable file type detection, plugins, and indenting
syntax on                   " Enable syntax highlighting
set encoding=utf-8          " Use UTF-8 encoding
set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set cursorline              " Highlight the current line
set showmatch               " Briefly jump to matching bracket
set incsearch               " Highlight matches as you type
set hlsearch                " Highlight search matches
set ignorecase              " Ignore case in searches by default
set smartcase               " But case-sensitive if search contains uppercase
set autoindent              " Automatically indent new lines
set smartindent             " Smart auto indenting
set tabstop=4               " Number of spaces a tab counts for
set shiftwidth=4            " Number of spaces for indent
set expandtab               " Use spaces instead of tabs
set softtabstop=4           " Number of spaces to insert for a Tab when editing
set hidden                  " Allow switching buffers without saving
set updatetime=300          " Faster update time for diagnostics/cursorline
set signcolumn=yes:2        " Always show sign column (prevents layout shifts)
set clipboard+=unnamedplus   " Use system clipboard
set mouse=a                 " Enable mouse support
set splitbelow              " Open new splits below the current window
set splitright              " Open new splits to the right
set noshowmode              " Don't show mode in the status line (handled by status line plugin)
set shortmess+=c            " Don't show redundant messages from ins-completion-menu
set termguicolors           " Use true colors in the terminal
set scrolloff=8             " Minimum lines to keep above and below the cursor
set sidescrolloff=15        " Minimum columns to keep to the left/right of the cursor
set formatoptions-=cro      " Don't auto-format comments on enter/insert

" UI Enhancements
set cmdheight=2             " Height of the command bar
set laststatus=2            " Always show the status line
set showtabline=2           " Always show the tabline

" --- Plugins (using vim-plug) ---
call plug#begin('~/.config/nvim/plugged')

" Core
Plug 'neovim/nvim-lspconfig'                    " LSP Configuration
Plug 'williamboman/mason.nvim'                  " Package Manager for LSP, DAP, Linters, Formatters
Plug 'williamboman/mason-lspconfig.nvim'        " Bridge between Mason and nvim-lspconfig
Plug 'hrsh7th/nvim-cmp'                         " Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'                     " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'                       " Buffer source for nvim-cmp
Plug 'hrsh7th/cmp-path'                         " Path source for nvim-cmp
Plug 'hrsh7th/cmp-cmdline'                      " Command line source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'                         " Snippet Engine
Plug 'saadparwaiz1/cmp_luasnip'                 " LuaSnip source for nvim-cmp
Plug 'onsails/lspkind.nvim'                     " VS Code-like icons for nvim-cmp
Plug 'jose-elias-alvarez/null-ls.nvim'          " Inject LSP diagnostics, code actions, and more via Lua
Plug 'jay-babu/mason-null-ls.nvim'              " Bridge between Mason and null-ls
" Optional: If you want to use UltiSnips instead of LuaSnip
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'                    " Snippet collection (can be used with LuaSnip or UltiSnips)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Telescope
Plug 'nvim-lua/plenary.nvim'  " Required dependency for Telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' } "Version may differ
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } "Optional, for faster fzf

" File Tree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'             " Show Git status in NERDTree
Plug 'ryanoasis/vim-devicons'                   " Icons for NERDTree and others

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'                       " Fugitive extension for GitHub

" Status Line
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'               " LSP progress in lualine

" Colorscheme (choose one)
" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'Mofiqul/dracula.nvim'

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'                    " Collection of language packs
" Optional: Enhance HTML/CSS/JS highlighting
Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" PHP-specific
Plug 'lvht/phpcd.vim'                            " Context-aware PHP code completion
Plug 'StanAngeloff/php.vim'                     " Better PHP syntax
Plug 'prettier/vim-prettier', { 'do': 'npm install --global prettier' } " Code formatter (requires Prettier installation)

" Diagnostics
Plug 'dense-analysis/ale'

call plug#end()

" --- Plugin Configurations ---

" Set leader key
let mapleader = ","

" --- Colorscheme ---
" Enable true colors (if your terminal supports it)
if has('termguicolors')
    set termguicolors
endif
" Enable 256 colors (if your terminal supports it)
set t_Co=256
colorscheme dracula

" --- File Tree (NERDTree) ---
nnoremap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeIgnore=['\.pyc$', '\~$']
let g:NERDTreeStatusline = ''
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'✹',
    \ 'Staged'    :'✚',
    \ 'Untracked' :'✭',
    \ 'Renamed'   :'➜',
    \ 'Unmerged'  :'═',
    \ 'Deleted'   :'✖',
    \ 'Dirty'     :'✗',
    \ 'Clean'     :'✔︎',
    \ 'Unknown'   :'?',
    \ }

" --- Fuzzy Finder (fzf) ctrlp ---
function! FindProjectRoot()
  let project_root = finddir('.git', '.;..')
  if !empty(project_root)
    let project_root = fnamemodify(project_root, ':h') " Get parent directory of .git
  else
    let project_root = getcwd()
  endif
  return project_root
endfunction


command! ProjectFiles execute 'Files ' . FindProjectRoot()
nnoremap <C-p> :ProjectFiles<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>b :Buffers<CR>
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --no-ignore-vcs'
let g:fzf_preview_window = 'right:60%'


" --- Git (vim-fugitive) ---
nnoremap <leader>gs :G<CR>
nnoremap <leader>gc :Git commit -v<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>ga :Git add .<CR>       " Git add all changes
nnoremap <leader>gA :Git add -u<CR>      " Git add updated/deleted (not untracked)
nnoremap <leader>gd :Gdiff<CR>          " Git diff (view changes)
nnoremap <leader>gD :Gvdiff<CR>          " Git diff (view changes in vertical mode)
nnoremap <leader>gb :Git checkout<Space> " Git checkout (start typing branch name)
nnoremap <leader>gl :Git log<CR>         " Git log
nnoremap <leader>gL :Git log --oneline --graph --all<CR>  " Git log pretty
nnoremap <leader>gm :Gblame<CR>          " Git blame
nnoremap <leader>gB :Telescope git_branches<CR> " List/create git branches with telescope.
nnoremap <leader>gss :Telescope git_status<CR>


nnoremap <leader>th :sp term://zsh<CR> " Open terminal in horizontal split
nnoremap <leader>tv :vsp term://zsh<CR> " Open terminal in vertical split
nnoremap <leader>tt :tabnew term://zsh<CR> " Open terminal in new tab

" --- Terminal Mappings ---
nnoremap <leader>th :sp term://zsh<CR> " Open terminal in horizontal split
nnoremap <leader>tv :vsp term://zsh<CR> " Open terminal in vertical split
nnoremap <leader>tt :tabnew term://zsh<CR> " Open terminal in new tab

"Improved terminal navigation and exit.
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l


nnoremap <leader>w :w<CR>                 " Save file
nnoremap <leader>q :q!<CR>                " Quit without saving
nnoremap <leader>cn :cnext<CR>            " Next quickfix item
nnoremap <leader>cp :cprevious<CR>        " Previous quickfix item
nnoremap <leader>co :copen<CR>            " Open quickfix window
nnoremap <leader>cc :cclose<CR>           " Close quickfix window
nnoremap <leader>ln :lnext<CR>            " Next location list item
nnoremap <leader>lp :lprevious<CR>        " Previous location list item
nnoremap <leader>lo :lopen<CR>            " Open location list window
nnoremap <leader>lc :lclose<CR>           " Close location list window
nnoremap <leader>s :set spell!<CR>        " Toggle spell checking
nnoremap <C-h> <C-w>h                    " Easier window navigation (left)
nnoremap <C-j> <C-w>j                    " Easier window navigation (down)
nnoremap <C-k> <C-w>k                    " Easier window navigation (up)
nnoremap <C-l> <C-w>l                    " Easier window navigation (right)
nnoremap <leader><space> :noh<CR>          " Clear search highlights
nnoremap <leader>y "+y                   " Yank to system clipboard
nnoremap <leader>p "+p                   " Paste from system clipboard
vnoremap <leader>y "+y                   " Yank selection to system clipboard
vnoremap <leader>p "+p                   " Paste over selection from system clipboard

" Open a new, empty tab.
nnoremap <leader>tn :tabnew<CR>
" Reload the vimrc file.
nnoremap <leader>so :source $MYVIMRC<CR>


" --- Status Line (lualine) ---
lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
        {
            'filename',
            file_status = true, -- displays file status
            path = 1            -- 1: relative path, 2: absolute path, 0: filename only
        },
        {
            require('lspkind').cmp_format()
        }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype', require('lsp-progress').progress},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}
EOF


" --- PHP-specific (phpcd.vim) ---
let g:phpcd_enable_default_mapping = 0 " Disable default mappings

" --- ALE Configuration ---
let g:ale_linters = {
\   'php': ['psalm', 'phpstan', 'phan', 'phpmd', 'phpp'],
\   'javascript': ['eslint', 'tsserver'],
\   'typescript': ['eslint'],
\   'css': ['stylelint'],
\   'html': ['htmlhint'],
\}
let g:ale_fixers = {
\   'php': ['phpcbf', 'php-cs-fixer'],
\   'javascript': ['eslint', 'tsserver'],
\   'typescript': ['eslint'],
\   'css': ['stylelint'],
\   'html': ['prettier'],
\}

" ...


" --- Linting (ALE) ---
let g:ale_fix_on_save = 1
" Automatically open location list after linting if there are errors
let g:ale_open_list = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0


" (Optional) Customize ALE diagnostic signs
highlight clear SignColumn
highlight ALEErrorSign text=E ctermbg=NONE
highlight ALEWarningSign text=W ctermbg=NONE
highlight ALEInfoSign text=i ctermbg=NONE



" --- LSP, Mason, Autocompletion (nvim-lspconfig, mason, nvim-cmp) ---
lua << EOF
-- Lua configuration for LSP, Mason, and nvim-cmp
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mason (package manager for LSP servers, linters, etc.)
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "intelephense",    -- PHP
        "tsserver",         -- TypeScript
        "eslint",           -- JavaScript/TypeScript linting
        "stylelint",        -- CSS linting
        "html",             -- HTML
        "cssls",            -- CSS
        "jsonls",           -- JSON
        "tailwindcss",      -- Correct Tailwind CSS server name
        "phplint",          -- PHP linting (basic)
        "phpcs",            -- PHP CodeSniffer
        "phpcbf",           -- PHP Code Beautifier and Fixer
        "phpstan",          -- PHP Static Analysis Tool
        "phan",             -- PHP Static Analyzer
        "psalm",            -- PHP Static Analysis Tool
        "php_cs_fixer",     -- PHP Coding Standards Fixer
    },
    automatic_installation = true,
}

-- null-ls (for formatters, etc.)
local null_ls = require("null-ls")
require("mason-null-ls").setup {
    ensure_installed = {
        "prettier",         -- Code formatter
    },
    automatic_installation = true,
}

require("mason-null-ls").setup_handlers {
    function (source_name, methods)
        if source_name == "prettier" then
            null_ls.register(require("null-ls").builtins.formatting.prettierd.with({ -- Use prettierd for faster formatting
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "less",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                    "json",
                    "jsonc",
                    "yaml",
                    "markdown",
                },
            }))
        else
            null_ls.register(require("null-ls").builtins.formatting[source_name])
        end
    end,
}

-- null-ls diagnostics
for _, source in ipairs(require("null-ls").builtins.diagnostics) do
    local handler = function(source_name)
        null_ls.register(require("null-ls").builtins.diagnostics[source_name])
    end
    handler(source.name)
end

-- Mappings for LSP (can be customized in on_attach)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover information' })
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { desc = 'Find references' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Actions' })
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { desc = 'Format Document' })

-- Customize LSP diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Set up completion using nvim-cmp
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
        })
    }
})

-- Customize on_attach function (add more mappings, etc.)
local on_attach = function(client, bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Add buffer-local mappings here if needed


      -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        vim.api.nvim_command [[augroup END]]
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
end

-- Configure language servers
require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["tsserver"] = function()
        require("lspconfig").tsserver.setup {
            on_attach = on_attach,
            root_dir = function(fname) 
                return lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git")(fname) 
                    or lspconfig.util.path.dirname(fname)
            end,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = {
                completions = {
                    completeFunctionCalls = true
                },
                javascript = {
                    format = {
                        semicolons = "remove"
                    }
                },
                typescript = {
                    format = {
                        semicolons = "remove"
                    }
                }
            }
        }
    end,
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "tsx", "javascript", "html", "css", "json" },
  highlight = {
    enable = true,
  },
}
EOF

