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
    buffer_not_empty.__raw = ''
      function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end
    '';

    hide_in_width.__raw = ''
      function()
        return vim.fn.winwidth(0) > 80
      end
    '';

    check_git_workspace.__raw = ''
      function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end
    '';
  };
in
{
  plugins.lualine = {
    enable = true;
    # pulled from evil_lualine example
    settings = {
      options = {
        component_separators = "";
        section_separators = "";
        theme = {
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
      };
      sections = {
        lualine_c = [
          {
            __unkeyed.__raw = "function() return '▊' end";
            color = {
              fg = colors.blue;
            };
            padding = {
              left = 0;
              right = 1;
            };
          }
          {
            __unkeyed.__raw = "function() return '󱄅' end";
            color.__raw = ''
              function()
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
              end
            '';
            padding = {
              right = 1;
            };
          }
          {
            __unkeyed = "filesize";
            cond = conditions.buffer_not_empty;
          }
          {
            __unkeyed = "filename";
            cond = conditions.buffer_not_empty;
            color = {
              fg = colors.magenta;
              gui = "bold";
            };
          }
          { __unkeyed = "location"; }
          {
            __unkeyed = "progress";
            color = {
              fg = colors.fg;
              gui = "bold";
            };
          }
          {
            __unkeyed = "diagnostics";
            sources = [ "nvim_diagnostic" ];
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
            };
            diagnostics_color = {
              error = {
                fg = colors.red;
              };
              warn = {
                fg = colors.violet;
              };
              info = {
                fg = colors.cyan;
              };
            };
          }
          { __unkeyed.__raw = "function() return '%=' end"; }
          {
            __unkeyed.__raw = ''
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
              end
            '';
            icon = " LSP:";
            color = {
              fg = "#ffffff";
              gui = "bold";
            };
          }
        ];
        lualine_x = [
          {
            __unkeyed = "o:encoding";
            fmt.__raw = "string.upper";
            cond = conditions.hide_in_width;
            color = {
              fg = colors.green;
              gui = "bold";
            };
          }
          {
            __unkeyed = "fileformat";
            fmt.__raw = "string.upper";
            cond = conditions.hide_in_width;
            color = {
              fg = colors.green;
              gui = "bold";
            };
          }
          {
            __unkeyed = "branch";
            icon = "";
            color = {
              fg = colors.violet;
              gui = "bold";
            };
          }
          {
            __unkeyed = "diff";
            symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
            diff_color = {
              added = {
                fg = colors.green;
              };
              modified = {
                fg = colors.cyan;
              };
              removed = {
                fg = colors.red;
              };
            };
            cond = conditions.hide_in_width;
          }
          {
            __unkeyed.__raw = "function() return '▊' end";
            color = {
              fg = colors.blue;
            };
            padding = {
              left = 1;
            };
          }
        ];

        lualine_a = [ "" ];
        lualine_b = [ "" ];
        lualine_y = [ "" ];
        lualine_z = [ "" ];
      };
      inactive_sections = {
        lualine_a = [ "" ];
        lualine_b = [ "" ];
        lualine_y = [ "" ];
        lualine_z = [ "" ];
        lualine_c = [ "" ];
        lualine_x = [ "" ];
      };
    };
  };
}
