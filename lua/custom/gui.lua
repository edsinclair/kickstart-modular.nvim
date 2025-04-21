vim.o.guifont = "Monaco:h16"

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0

  vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end

local keymapOpts = { silent = true }

-- Copy, Cut, Paste
vim.keymap.set({ 'n', 'v', 'i' }, '<D-c>', '"+y', keymapOpts)    -- Command-c copy
vim.keymap.set({ 'n', 'v', 'i' }, '<D-x>', '"+x', keymapOpts)    -- Command-x cut
vim.keymap.set({ 'c', 'n', 'i' }, '<D-v>', '<C-r>+', keymapOpts) -- Command-v paste
-- vim.keymap.set({ "n", "v" }, "<D-v>", "\"+p", keymapOpts)

-- Map command-[ and command-] to indenting or outdenting
-- while keeping the original selection in visual mode

vim.keymap.set('v', '<D-]>', '>gv', keymapOpts)
vim.keymap.set('v', '<D-[>', '<gv', keymapOpts)

vim.keymap.set({ 'n', 'o' }, '<D-]>', '>>', keymapOpts)
vim.keymap.set({ 'n', 'o' }, '<D-[>', '<<', keymapOpts)

vim.keymap.set('i', '<D-]>', '<Esc>>>i', keymapOpts)
vim.keymap.set('i', '<D-[>', '<Esc><<i', keymapOpts)
