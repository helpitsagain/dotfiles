return {
  {
    'echasnovski/mini.surround',
    config = function()
      require('mini.surround').setup({
        mappings = {
          add = 'gsa',
          delete = 'gsd',
          find = 'gsf',
          find_left = 'gsF',
          highlight = 'gsh',
          replace = 'gsr',
          update_n_lines = 'gsn',
        },

        custom_surroundings = {
          d = {
            output = function()
              return { left = '<div>', right = '</div>' }
            end,
          },
          c = {
            output = function()
              return { left = '/*', right = '*/' }
            end,
          },
          s = {
            output = function()
              return { left = '${', right = '}' }
            end,
          },
        },
      })
    end,
  },
}
