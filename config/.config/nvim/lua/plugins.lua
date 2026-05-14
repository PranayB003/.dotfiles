local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function lsp_attach_keymaps()
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      local opts = { buffer = event.buf }

      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "x" }, "<leader>fm", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
  })
end

local function nonempty(value)
  return value ~= nil and value ~= "" and value or nil
end

local function find_ade_view_root(path)
  path = nonempty(path)
  if not path then
    return nil
  end

  path = vim.fs.normalize(path)
  local stat = vim.loop.fs_stat(path)
  local dir = stat and stat.type == "directory" and path or vim.fs.dirname(path)

  if not dir then
    return nil
  end

  if vim.fn.filereadable(vim.fs.joinpath(dir, "ade_info.vmd")) == 1 then
    return dir
  end

  for parent in vim.fs.parents(dir) do
    if vim.fn.filereadable(vim.fs.joinpath(parent, "ade_info.vmd")) == 1 then
      return parent
    end
  end

  return nil
end

local function product_from_path(view_root, path)
  path = nonempty(path)
  if not view_root or not path then
    return nil
  end

  local root = vim.fs.normalize(view_root)
  local normalized = vim.fs.normalize(path)

  if not vim.startswith(normalized, root .. "/") then
    return nil
  end

  local product = normalized:sub(#root + 2):match("^([^/]+)")
  if product == ".ade_path" or product == "utl" then
    return nil
  end

  return product
end

local function ade_context()
  local bufname = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.getcwd()
  local view_root = nonempty(vim.env.ADE_VIEW_ROOT)
    or nonempty(vim.env.SRCHOME)
    or find_ade_view_root(bufname)
    or find_ade_view_root(cwd)

  local product = nonempty(vim.env.NDE_PRODUCT)
    or product_from_path(view_root, bufname)
    or product_from_path(view_root, cwd)

  return view_root, product
end

local function ade_cscope_db_files()
  local view_root, product = ade_context()
  if not view_root or not product then
    return { "./cscope.out" }
  end

  local product_root = vim.fs.joinpath(view_root, product)
  local db_file = vim.fs.joinpath(product_root, "utl", "cscope.out")

  vim.env.CSCOPE_DB2 = db_file

  return {
    db_file .. "::" .. product_root,
  }
end

local function ade_cscope_build_cmd()
  local view_root, product = ade_context()
  if not view_root then
    return { script = "default", args = { "-bqkv" } }
  end

  vim.env.ADE_VIEW_ROOT = nonempty(vim.env.ADE_VIEW_ROOT) or view_root
  vim.env.SRCHOME = nonempty(vim.env.SRCHOME) or view_root
  if product then
    vim.env.NDE_PRODUCT = nonempty(vim.env.NDE_PRODUCT) or product
  end

  return {
    script = "sh",
    args = { "-c", 'exec "$ADE_VIEW_ROOT/utl/csrebuild"' },
  }
end

local function prefer_usr_local_cscope()
  if vim.fn.executable("/usr/local/bin/cscope") ~= 1 then
    return
  end

  local path = vim.env.PATH or ""
  if not vim.startswith(path, "/usr/local/bin:") then
    vim.env.PATH = "/usr/local/bin:" .. path
  end
end

return require("lazy").setup({
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFocus",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh",
      "NvimTreeCollapse",
    },
    keys = {
      { "<Leader>tt", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file tree" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          relativenumber = true,
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "gruvbox",
        },
      })
    end,
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "/tmp", "/" },
      session_lens = {
        load_on_setup = false,
      },
      -- Allow saving a session even when launched with a file argument 
      -- (or multiple files/dirs). It does not load any existing session first.
      args_allow_files_auto_save = true,
      custom_session_tag = function ()
        local view_name = vim.env.ADE_VIEW_NAME
        if not view_name or view_name == "" then
          return nil
        end
        return view_name
      end
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "cpp",
          "markdown",
          "dockerfile",
          "go",
          "rust",
          "make",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Telescope",
    keys = {
      { "<Leader>tl", "<cmd>Telescope<CR>", desc = "Telescope" },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ hidden = true })
        end,
        desc = "Find files",
      },
      {
        "<leader>ft",
        function()
          require("telescope.builtin").treesitter()
        end,
        desc = "Treesitter symbols",
      },
      {
        "<leader>fz",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Fuzzy find in buffer",
      },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "dhananjaylatkar/cscope_maps.nvim",
    cmd = { "Cscope", "Cs", "Cstag", "CsPrompt", "CsStackView" },
    -- LHS-only lazy.nvim triggers. cscope_maps.nvim creates the real default
    -- maps after loading, then lazy.nvim replays the key that triggered it.
    keys = {
      { "<leader>cs", mode = { "n", "v" } },
      { "<leader>cg", mode = { "n", "v" } },
      { "<leader>cc", mode = { "n", "v" } },
      { "<leader>ct", mode = { "n", "v" } },
      { "<leader>ce", mode = { "n", "v" } },
      { "<leader>cf", mode = { "n", "v" } },
      { "<leader>ci", mode = { "n", "v" } },
      { "<leader>cd", mode = { "n", "v" } },
      { "<leader>ca", mode = { "n", "v" } },
      { "<leader>cb", mode = { "n", "v" } },
      { "<C-]>", mode = { "n", "v" } },
    },
    dependencies = { "nvim-telescope/telescope.nvim" },
    main = "cscope_maps",
    opts = function()
      prefer_usr_local_cscope()

      return {
        cscope = {
          db_file = ade_cscope_db_files,
          picker = "telescope",
          db_build_cmd = ade_cscope_build_cmd(),
        },
      }
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "RyanMillerC/better-vim-tmux-resizer",
    lazy = false,
    init = function()
      vim.g.tmux_resizer_resize_count = 2
      vim.g.tmux_resizer_vertical_resize_count = 2
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    cmd = {
      "LspInfo",
      "LspInstall",
      "LspLog",
      "LspRestart",
      "LspStart",
      "LspStop",
      "LspUninstall",
    },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")

      vim.opt.signcolumn = "yes"
      lsp_attach_keymaps()

      lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig.util.default_config.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      require("mason-lspconfig").setup({
        ensure_installed = {
          -- "clangd",
          -- "cmake",
          -- "lua_ls",
          -- "pylsp",
        },
        -- mason-lspconfig's default calls vim.lsp.enable(), which needs Nvim 0.11+.
        automatic_enable = false,
      })

      for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
        lspconfig[server_name].setup({})
      end
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "nvim_lua" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
})
