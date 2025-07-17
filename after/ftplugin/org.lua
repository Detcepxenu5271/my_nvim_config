vim.wo.conceallevel = 2

vim.bo.expandtab = true
vim.bo.tabstop = 4

vim.keymap.set('i', 'jlc', '~~<Left>', {buffer = true})
vim.keymap.set('i', 'jlm', '$$<Left>', {buffer = true})

vim.keymap.set('n', '<leader>r', '?^\\s*#+begin_src?1<Cr>V/^\\s*#+end_src/-1<Cr>:SnipRun<Cr>', {buffer = true, desc = 'Run current src block (with SnipRun)'})

--vim.keymap.set('n', '<leader>R', ':e!', {buffer = true})

-- abbreviation

--vim.keymap.set('ia', 'h3', '***', {buffer = true})
