local k = vim.keymap
local g = vim.g

g.mapleader = ";"

-- Disable help
k.set('n', '<F1>', '<Esc>')

-- Remap U to <C-r> for easier redo
k.set('n', 'U', '<C-r>')

-- Remap space to :
k.set('n', '<space>', ':')

-- <C-l> clears highlighting
k.set('n', '<C-l>', ':nohl<CR><C-l>', { noremap = true, silent = true })

-- Disable arrow keys
k.set('n', '<up>', '<nop>')
k.set('n', '<down>', '<nop>')
k.set('n', '<left>', '<nop>')
k.set('n', '<right>', '<nop>')

-- Esc
k.set('i', 'kj', '<esc>')
k.set('c', 'kj', '<C-C>')
