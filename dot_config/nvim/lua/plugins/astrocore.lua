--if true then return {} end  REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<C-S-s>"] = {
          ":%s///gc<left><left><left>",
          desc = "Search and Replace All (with confirmation)",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
        -- Shift + Arrows to start a visual selection
        ["<S-Left>"] = { "v<Left>", desc = "Start selection left" },
        ["<S-Right>"] = { "v<Right>", desc = "Start selection right" },
        ["<S-Up>"] = { "v<Up>", desc = "Start selection up" },
        ["<S-Down>"] = { "v<Down>", desc = "Start selection down" },
        -- Ctrl + Shift + Arrows to start a word-wise visual selection
        ["<C-S-Left>"] = { "v<C-Left>", desc = "Start word-wise selection left" },
        ["<C-S-Right>"] = { "v<C-Right>", desc = "Start word-wise selection right" },
      },

      x = {
        -- Shift + Arrows to extend the selection
        ["<S-Left>"] = { "<Left>", desc = "Extend selection left" },
        ["<S-Right>"] = { "<Right>", desc = "Extend selection right" },
        ["<S-Up>"] = { "<Up>", desc = "Extend selection up" },
        ["<S-Down>"] = { "<Down>", desc = "Extend selection down" },
        -- Ctrl + Shift + Arrows to extend word-wise selection
        ["<C-S-Left>"] = { "<C-Left>", desc = "Extend word-wise selection left" },
        ["<C-S-Right>"] = { "<C-Right>", desc = "Extend word-wise selection right" },
      },
      i = {
        -- Shift + Arrows to start a visual selection from insert mode
        ["<S-Left>"] = { "<ESC>v<Left>", desc = "Start selection left" },
        ["<S-Right>"] = { "<ESC>v<Right>", desc = "Start selection right" },
        ["<S-Up>"] = { "<ESC>v<Up>", desc = "Start selection up" },
        ["<S-Down>"] = { "<ESC>v<Down>", desc = "Start selection down" },
        -- Ctrl + Shift + Arrows to start a word-wise selection from insert mode
        ["<C-S-Left>"] = { "<ESC>v<C-Left>", desc = "Start word-wise selection left" },
        ["<C-S-Right>"] = { "<ESC>v<C-Right>", desc = "Start word-wise selection right" },
        -- Word Deletion Mappings
        ["<C-BS>"] = { "<C-w>", desc = "Delete previous word" },
        ["<C-Del>"] = { "<C-o>de", desc = "Delete next word" },
      },
    },
  },
}
