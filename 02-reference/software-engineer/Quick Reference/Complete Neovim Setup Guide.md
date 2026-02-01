---
description: Comprehensive Neovim setup guide with installation, directory structure, plugin management with Packer, LSP configuration for JavaScript/TypeScript and Python, and essential plugins.
tags: ["advanced-vim-motions", "appearance", "basic-configuration", "custom-keymaps", "directory-structure", "essential-plugins", "installation", "javascripttypescript", "language-support", "plugin-management", "python", "troubleshooting"]
---
This comprehensive guide will walk you through setting up a powerful Neovim configuration with support for JavaScript/TypeScript and Python development, enhanced appearance, and essential plugins.

## Table of Contents

- [Installation](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#installation)
- [Directory Structure](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#directory-structure)
- [Plugin Management](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#plugin-management)
- [Basic Configuration](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#basic-configuration)
- [Appearance](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#appearance)
- [Language Support](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#language-support)
    - [JavaScript/TypeScript](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#javascripttypescript)
    - [Python](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#python)
- [Essential Plugins](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#essential-plugins)
- [Advanced Vim Motions](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#advanced-vim-motions)
- [Custom Keymaps](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#custom-keymaps)
- [Troubleshooting](https://claude.ai/chat/3e44a585-fc23-4a4a-a4c7-369de289dcc1#troubleshooting)

## Installation

### macOS

```bash
brew install neovim
```

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install neovim
```

### Verify Installation

```bash
nvim --version
```

## Directory Structure

Create the necessary directory structure:

```bash
mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.config/nvim/lua/config
mkdir -p ~/.config/nvim/lua/lsp
mkdir -p ~/.config/nvim/after/plugin
```

## Plugin Management

We'll use Packer as our plugin manager:

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Basic Configuration

Create the main configuration file:

### ~/.config/nvim/init.lua

```lua
-- Set leader key (must be set before any keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configurations
require('plugins')  -- Plugin definitions
require('config')   -- General settings
require('lsp')      -- LSP configurations
```

### ~/.config/nvim/lua/config/init.lua

```lua
-- Basic settings
vim.opt.number = true               -- Line numbers
vim.opt.relativenumber = true       -- Relative line numbers
vim.opt.mouse = 'a'                 -- Enable mouse
vim.opt.ignorecase = true           -- Ignore case when searching
vim.opt.smartcase = true            -- Override ignorecase if search contains uppercase
vim.opt.hlsearch = false            -- Don't highlight all search matches
vim.opt.wrap = false                -- Don't wrap lines
vim.opt.breakindent = true          -- Preserve indentation of virtual lines
vim.opt.tabstop = 2                 -- 2 spaces for tab
vim.opt.shiftwidth = 2              -- 2 spaces for indentation
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.undofile = true             -- Persistent undo history
vim.opt.updatetime = 250            -- Faster update time
vim.opt.signcolumn = 'yes'          -- Always show sign column
vim.opt.clipboard = 'unnamedplus'   -- Use system clipboard
vim.opt.splitright = true           -- Split windows right
vim.opt.splitbelow = true           -- Split windows below
vim.opt.scrolloff = 8               -- Lines to keep above/below cursor
vim.opt.sidescrolloff = 8           -- Columns to keep left/right of cursor

-- File explorer settings
vim.g.netrw_banner = 0        -- Hide banner
vim.g.netrw_liststyle = 3     -- Tree view
vim.g.netrw_browse_split = 0  -- Open files in current window

-- Load other config modules
require('config.keymaps')
```

### ~/.config/nvim/lua/config/keymaps.lua

```lua
-- File explorer
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open file explorer' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate to right window' })

-- Resize windows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Indentation
vim.keymap.set('v', '<', '<gv', { desc = 'Outdent line' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent line' })

-- Move text up and down
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move text down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move text up' })

-- Clear search highlight
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Telescope keymaps
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Help tags' })
```

## Appearance

### ~/.config/nvim/lua/plugins.lua

```lua
-- This file can be loaded by calling `lua require('plugins')` from your init.lua

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd('colorscheme tokyonight-moon')
    end
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'tokyonight',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        }
      })
    end
  }

  -- Indentation guides
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup()
    end
  }

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup()
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
    end
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
            }
          }
        }
      })
    end
  }

  -- Treesitter for better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "vim", "javascript", "typescript", "python", "html", "css", "json" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }

  -- Autopairs
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- Comment toggle
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Git integration
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',           -- Package manager for LSP servers
      'williamboman/mason-lspconfig.nvim', -- Bridges mason with lspconfig
      'folke/neodev.nvim',                 -- Adds LSP support for Neovim lua API
    }
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    }
  }

  -- Formatting and linting
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  
  -- Additional language support
  -- JavaScript/TypeScript
  use 'jose-elias-alvarez/typescript.nvim'
  
  -- Python
  use 'vim-python/python-syntax'

  -- Which-key for keybinding help
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end
  }
end)
```

## Language Support

### ~/.config/nvim/lua/lsp/init.lua

```lua
-- Language Server setup
local lsp_setup = function()
  require('lsp.options')    -- General LSP settings
  require('lsp.servers')    -- Server-specific settings
  require('lsp.handlers')   -- LSP handlers
  require('lsp.completion') -- Completion setup
  require('lsp.formatter')  -- Formatting setup
end

-- Execute LSP setup if all required modules are available
local status_ok = pcall(lsp_setup)
if not status_ok then
  print("LSP setup failed - make sure all required plugins are installed")
end

return status_ok
```

### ~/.config/nvim/lua/lsp/options.lua

```lua
-- Global diagnostic settings
vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- Could be '■', '▎', 'x'
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Setup diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Set keybindings for LSP functionality
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings
    local opts = { buffer = ev.buf }
    
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'Go to declaration' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'Go to definition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Hover documentation' })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = 'Go to implementation' })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = 'Signature help' })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = 'Add workspace folder' })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = 'Remove workspace folder' })
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = ev.buf, desc = 'List workspace folders' })
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = 'Type definition' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = 'Rename' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Code action' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = 'Go to references' })
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { buffer = ev.buf, desc = 'Format code' })
  end,
})
```

### ~/.config/nvim/lua/lsp/servers.lua

```lua
-- Mason setup for LSP servers, formatters, and linters
require('mason').setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Mason-lspconfig setup
require('mason-lspconfig').setup({
  -- Ensure these servers are available
  ensure_installed = {
    'tsserver',    -- JavaScript/TypeScript
    'eslint',      -- ESLint
    'pyright',     -- Python
    'lua_ls',      -- Lua
    'html',        -- HTML
    'cssls',       -- CSS
    'jsonls',      -- JSON
  },
  automatic_installation = true,
})

-- Configure Lua language server for Neovim
require('neodev').setup()

-- LSP server configurations
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- JavaScript/TypeScript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
})

-- ESLint
lspconfig.eslint.setup({
  capabilities = capabilities,
  settings = {
    packageManager = 'npm',
    useESLintClass = true,
  }
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      }
    }
  }
})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    }
  }
})

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
})

-- JSON
lspconfig.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})
```

### ~/.config/nvim/lua/lsp/completion.lua

```lua
-- Configure completion with nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

-- Load friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
    
    -- Navigate between snippet placeholders
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Source
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
})
```

### ~/.config/nvim/lua/lsp/formatter.lua

```lua
-- Formatter setup using null-ls
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- JavaScript/TypeScript
    null_ls.builtins.formatting.prettier.with({
      filetypes = { 
        "javascript", 
        "typescript", 
        "javascriptreact", 
        "typescriptreact", 
        "css", 
        "html", 
        "json", 
        "yaml", 
        "markdown"
      },
    }),
    
    -- Python
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length", "88" }
    }),
    null_ls.builtins.formatting.isort,
    
    -- Diagnostics
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.flake8.with({
      extra_args = { "--max-line-length", "88" }
    }),
    
    -- Code Actions
    null_ls.builtins.code_actions.eslint,
  },
  
  -- Format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
```

## Advanced Vim Motions

Understanding advanced Vim motions will significantly improve your editing efficiency:

### Text Objects

Vim's text objects allow you to select and operate on chunks of text:

- `iw` - Inside word
- `aw` - Around word (includes surrounding whitespace)
- `is` - Inside sentence
- `as` - Around sentence
- `ip` - Inside paragraph
- `ap` - Around paragraph
- `i(` or `i)` - Inside parentheses
- `a(` or `a)` - Around parentheses
- `i{` or `i}` - Inside curly braces
- `a{` or `a}` - Around curly braces
- `i[` or `i]` - Inside square brackets
- `a[` or `a]` - Around square brackets
- `i<` or `i>` - Inside angle brackets
- `a<` or `a>` - Around angle brackets
- `i"` - Inside double quotes
- `a"` - Around double quotes
- `i'` - Inside single quotes
- `a'` - Around single quotes
- `it` - Inside HTML/XML tag
- `at` - Around HTML/XML tag

### Operator + Motion Combinations

- `d` (delete) + motion:
    
    - `dw` - Delete to next word
    - `db` - Delete to previous word
    - `diw` - Delete inner word
    - `di(` - Delete inside parentheses
    - `da{` - Delete around curly braces (includes the braces)
- `c` (change) + motion:
    
    - `cw` - Change to next word
    - `ciw` - Change inner word
    - `ci"` - Change inside quotes
- `y` (yank/copy) + motion:
    
    - `yy` - Yank current line
    - `yiw` - Yank inner word
    - `yi(` - Yank inside parentheses

### Jump Motions

- `%` - Jump to matching bracket
- `gd` - Go to definition of local variable
- `gf` - Go to file under cursor
- `gg` - Go to top of file
- `G` - Go to bottom of file
- `{` - Jump to previous paragraph
- `}` - Jump to next paragraph
- `Ctrl-o` - Jump to previous location
- `Ctrl-i` - Jump to next location
- `Ctrl-]` - Jump to tag definition

### Block Operations

- `V` - Select entire lines
- `Ctrl-v` - Visual block mode (select columns)
- `I` in visual block - Insert text at beginning of each line in selection
- `A` in visual block - Append text at end of each line in selection
- `c` in visual block - Change text in each line of selection
- `d` in visual block - Delete text in each line of selection

### Registers

- `"{register}y` - Yank into specific register
- `"{register}p` - Paste from specific register
- `"0p` - Paste from yank register
- `:reg` - View all registers

### Macros

- `q{register}` - Start recording to register
- `q` - Stop recording
- `@{register}` - Play macro from register
- `@@` - Repeat last macro

## Troubleshooting

### Common Issues

1. **Plugin installation failures**
    
    - Run `:checkhealth` to identify issues
    - Check your Packer installation
    - Try running `:PackerSync` multiple times
2. **LSP server not working**
    
    - Run `:LspInfo` to check status
    - Ensure the server is installed: `:Mason`
    - Check if the language server is supported on your system
3. **Keybindings not working**
    
    - Check for conflicts using `:verbose map <key>`
    - Verify leader key is set correctly
    - Check plugin loading order
4. **Slow startup time**
    
    - Use `:TSModuleInfo` to check Treesitter module status
    - Disable unused plugins
    - Use `:PackerCompile` after changing plugins

### Performance Tuning

1. Lazy-load plugins:
    
    ```lua
    use {
      'plugin/name',
      ft = {'javascript', 'typescript'}, -- Load only for specific filetypes
      cmd = {'CommandName'},            -- Load only on specific commands
      event = {'BufReadPost', 'BufNewFile'} -- Load on specific events
    }
    ```
    
2. Optimize LSP settings:
    
    ```lua
    -- Reduce update frequency
    vim.opt.updatetime = 300
    
    -- Limit diagnostic signs
    vim.diagnostic.config({
      underline = false,
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    })
    ```
    

## Helpful Commands

- `:checkhealth` - Check Neovim health
- `:PackerSync` - Update and sync plugins
- `:TSUpdate` - Update Treesitter parsers
- `:Mason` - Open Mason package manager
- `:WhichKey` - Show available keybindings
- `:Telescope keymaps` - Search through keymaps