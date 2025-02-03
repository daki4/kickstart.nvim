return {
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'dark',
        transparent = true, -- Enable transparency
        term_colors = true,
        -- Make floating windows transparent too
        highlights = {
          NormalFloat = { bg = 'NONE' },
          FloatBorder = { bg = 'NONE' },
          Float = { bg = 'NONE' },
        },
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },
}
