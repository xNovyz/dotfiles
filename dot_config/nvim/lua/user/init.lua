-- These mappings go inside the `mappings` table in your AstroNvim user config.
-- Example: ~/.config/nvim/lua/user/init.lua

-- The `n`, `i`, and `v` keys define the mode for the mappings.
-- n = Normal mode
-- i = Insert mode
-- x = Visual mode (and `v` is a synonym for visual mode in this context)

local astro_mappings = {
  -- Selection Mappings
  n = {
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
}
