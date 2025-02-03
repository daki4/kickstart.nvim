return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { { 'nvim-tree/nvim-web-devicons' }, { 'SmiteshP/nvim-navic' } },
    opts = {
      options = {
        mode = 'buffers',
        numbers = 'none',
        close_command = 'bdelete! %d',
        diagnostics = 'nvim_lsp',
        indicator = {
          style = 'icon',
        },
        separator_style = 'thin',
      },
    },
    keys = {
      { '<leader>bp', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
      { '<leader>bD', '<cmd>BufferLineSortByDirectory<cr>', desc = 'Sort by directory' },
      { '<leader>be', '<cmd>BufferLinePickClose<cr>', desc = 'Pick which buffer to close' },
      { '<leader>bf', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle pin' },
      { '<leader>bh', '<cmd>BufferLineCloseLeft<cr>', desc = 'Close all to the left' },
      { '<leader>bj', '<cmd>BufferLinePick<cr>', desc = 'Jump' },
      { '<leader>bl', '<cmd>BufferLineCloseRight<cr>', desc = 'Close all to the right' },
      { '<leader>bL', '<cmd>BufferLineSortByLanguage<cr>', desc = 'Sort by language' },
      { '<leader>bn', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '<leader>bw', '<cmd>noautocmd w<cr>', desc = 'Save without formatting' },
      { '<leader>bc', '<cmd>bd<cr>', desc = 'Close current buffer' },
    },
    config = function()
      local navic = require 'nvim-navic'
      local function get_hl_color(name)
        local hl = vim.api.nvim_get_hl(0, { name = name })
        return string.format('#%06x', hl.fg or 0xFFFFFF)
      end

      -- Configure navic
      navic.setup {
        highlight = true,
        separator = ' > ',
      }
      -- Setup highlights using theme colors
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, 'NavicIconsFile', { fg = get_hl_color 'Type', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsModule', { fg = get_hl_color 'Special', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsNamespace', { fg = get_hl_color 'Include', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsClass', { fg = get_hl_color 'StorageClass', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsMethod', { fg = get_hl_color 'Function', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsProperty', { fg = get_hl_color 'Identifier', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsField', { fg = get_hl_color 'Identifier', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsConstructor', { fg = get_hl_color 'Special', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsEnum', { fg = get_hl_color 'Structure', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsInterface', { fg = get_hl_color 'Type', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsFunction', { fg = get_hl_color 'Function', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsVariable', { fg = get_hl_color 'Identifier', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsConstant', { fg = get_hl_color 'Constant', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsString', { fg = get_hl_color 'String', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsNumber', { fg = get_hl_color 'Number', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsBoolean', { fg = get_hl_color 'Boolean', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsArray', { fg = get_hl_color 'Type', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsObject', { fg = get_hl_color 'Type', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicIconsKey', { fg = get_hl_color 'Keyword', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicText', { fg = get_hl_color 'Normal', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NavicSeparator', { fg = get_hl_color 'Comment', bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'WinBar', { bg = 'NONE' })
        end,
      })

      vim.api.nvim_set_hl(0, 'WinBar', { bg = 'NONE' })

      local function is_valid_window()
        local win_type = vim.fn.win_gettype()
        return win_type == ''
      end

      local excluded_filetypes = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
      }

      local function should_show_winbar()
        if not is_valid_window() then
          return false
        end

        local filetype = vim.bo.filetype
        return not vim.tbl_contains(excluded_filetypes, filetype)
      end

      local function update_winbar()
        if not should_show_winbar() then
          return
        end

        local winid = vim.api.nvim_get_current_win()
        local bufnr = vim.api.nvim_win_get_buf(winid)

        if not (vim.api.nvim_win_is_valid(winid) and vim.api.nvim_buf_is_valid(bufnr)) then
          return
        end

        local filename = vim.fn.expand '%:t'
        local location = navic.get_location()

        if location and location ~= '' then
          vim.wo[winid].winbar = filename .. ' ' .. location
        else
          vim.wo[winid].winbar = filename
        end
      end

      vim.api.nvim_create_autocmd({ 'BufWinEnter', 'CursorHold', 'InsertLeave' }, {
        callback = update_winbar,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, buffer)
          end
        end,
      })

      vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>')
      vim.keymap.set('n', '<S-Left>', ':BufferLineCycleNext<CR>')
      vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>')
      vim.keymap.set('n', '<S-Right>', ':BufferLineCyclePrev<CR>')
      for i = 1, 9 do
        vim.keymap.set('n', tostring(i), ':BufferLineGoToBuffer ' .. i .. '<CR>', { desc = 'Jump to buffer ' .. i })
      end
      vim.keymap.set('n', '0', ':BufferLineGoToBuffer 10<CR>', { desc = 'Jump to buffer 10' })
    end,
  },
}
