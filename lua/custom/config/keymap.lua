local telescope = require 'telescope.builtin'

vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<leader>ld', function()
  vim.diagnostic.open_float { border = 'rounded' }
end, { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', '<leader>le', telescope.quickfix, { desc = 'Telescope Quickfix' })
vim.keymap.set('n', '<leader>lf', function()
  vim.lsp.buf.format { async = true }
end, { desc = 'Format' })
vim.keymap.set('n', '<leader>ll', vim.lsp.buf.hover, { desc = 'Info' })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Quickfix List' })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol, { desc = 'Document Symbols' })
vim.keymap.set('n', '<leader>lS', vim.lsp.buf.workspace_symbol, { desc = 'Workspace Symbols' })
vim.keymap.set('n', '<leader>lw', vim.diagnostic.setqflist, { desc = 'Diagnostics' })
