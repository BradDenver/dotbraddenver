local status, lualine = pcall(require, "lualine")
if (not status) then return end
lualine.setup {
-- require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'solarized_dark',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {
      winbar = {'nerdtree'}
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      {'filename', path = 1, shorting_target = 80, symbols = {
        modified = ' ',
        readonly = '',
      }}
    },
    lualine_x = {
      { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'diff',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {'filename', path = 1, shorting_target = 80, symbols = {
        modified = ' ',
        readonly = '',
      }}
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'},
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {'filename', path = 1, shorting_target = 80, symbols = {
        modified = ' ',
        readonly = '',
      }}
    },
    lualine_x = {
      { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      {'filetype', icon_only = true}
    },
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {'filename', path = 1, shorting_target = 80, symbols = {
        modified = ' ',
        readonly = '',
      }},
      {'filetype', icon_only = true}
    },
    lualine_x = {
      { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
    },
    lualine_y = {},
    lualine_z = {}
  }
}
