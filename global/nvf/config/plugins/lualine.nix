let
  colors = {
    bg = "#161616";
    fg = "#dde1e6";
    # This isn't oxocarbon... no yellow in oxocarbon...
    yellow = "#ecbe7b";
    cyan = "#3ddbd9";
    darkblue = "#78a9ff";
    green = "#42be65";
    # Also not oxocarbon
    orange = "#ff8800";
    violet = "#be95ff";
    magenta = "#ff7eb6";
    blue = "#33b1ff";
    red = "#ee5396";
  };
  conditions = {
    buffer_not_empty = ''
      function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end
    '';

    hide_in_width = ''
      function()
        return vim.fn.winwidth(0) > 80
      end
    '';

    check_git_workspace = ''
      function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end
    '';
  };
in
{
  programs.nvf.settings.vim.statusline.lualine = {
    enable = true;

    componentSeparator = {
      left = "";
      right = "";
    };

    sectionSeparator = {
      left = "";
      right = "";
    };

    setupOpts.options.theme = {
      normal = {
        c = {
          fg = colors.fg;
          bg = colors.bg;
        };
      };
      inactive = {
        c = {
          fg = colors.fg;
          bg = colors.bg;
        };
      };
    };

    activeSection = {
      c = [
        ''
          {
            function()
              return '▊'
            end,
            color = {fg = '${colors.blue}'},
            padding = {left = 0, right = 1},
          }
        ''
        ''
          {
            function()
              return '󱄅'
            end,
            color = function()
              local mode_color = {
                n = "${colors.red}",
                i = "${colors.green}",
                v = "${colors.blue}",
                [''] = "${colors.blue}",
                V = "${colors.blue}",
                c = "${colors.magenta}",
                no = "${colors.red}",
                -- I would update these to be an oxocarbon color but I have no idea what modes they are
                s = "${colors.orange}",
                S = "${colors.orange}",
                [''] = "${colors.orange}",
                ic = "${colors.yellow}",
                R = "${colors.violet}",
                Rv = "${colors.violet}",
                cv = "${colors.red}",
                ce = "${colors.red}",
                r = "${colors.cyan}",
                rm = "${colors.cyan}",
                ['r?'] = "${colors.cyan}",
                ['!'] = "${colors.red}",
                t = "${colors.red}",
              }
              return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = {right = 1},
          }
        ''
        ''
          {
            'filesize',
            cond = ${conditions.buffer_not_empty},
          }
        ''
        ''
          {
            'filename',
            cond = ${conditions.buffer_not_empty},
            color = {fg = '${colors.magenta}', gui = 'bold'},
          }
        ''
        "{'location'}"
        ''
          {
            'progress',
            color = {fg = '${colors.fg}', gui = 'bold'},
          }
        ''
        ''
          {
            'diagnostics'
            sources = ['nvim_diagnostic'],
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
            },
            diagnostics_color = {
              error = {fg = '${colors.red}'},
              warn = {fg = '${colors.violet}'},
              info = {fg = '${colors.cyan}'},
            },
          }
        ''
        "{function() return '%=' end}"
        ''
          {
            function()
              local msg = 'No Active Lsp'
              local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            icon = ' LSP:',
            color = {fg = '#ffffff', gui = 'bold'},
          }
        ''
      ];
      x = [
        ''
          {
            'o:encoding',
            fmt = string.upper,
            cond = ${conditions.hide_in_width},
            color = {fg = '${colors.green}', gui = 'bold'},
          }
        ''
        ''
          {
            'fileformat',
            fmt = string.upper,
            cond = ${conditions.hide_in_width},
            color = {fg = '${colors.green}', gui = 'bold'},
          }
        ''
        ''
          {
            'branch',
            icon = '',
            color = {fg = '${colors.violet}', gui = 'bold'},
          }
        ''
        ''
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
            diff_color = {
              added = {fg = '${colors.green}'},
              modified = {fg = '${colors.cyan}'},
              removed = {fg = '${colors.red}'},
            },
            cond = ${conditions.hide_in_width},
          }
        ''
        ''
          {
            function()
              return '▊'
            end,
            color = {fg = '${colors.blue}'},
            padding = {left = 1},
          }
        ''
      ];
      a = [ "" ];
      b = [ "" ];
      y = [ "" ];
      z = [ "" ];
    };
    inactiveSection = {
      a = [ "" ];
      b = [ "" ];
      c = [ "" ];
      y = [ "" ];
      x = [ "" ];
      z = [ "" ];
    };
  };
}
