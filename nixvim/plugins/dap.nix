{ pkgs, ... }:
{
  plugins.dap-virtual-text.enable = true;

  plugins.dap-ui = {
    enable = true;
    settings.layouts = [
      {
        elements = [
          {
            id = "scopes";
            size = 1;
          }
        ];
        position = "left";
        size = 40;
      }
    ];
  };

  extraPackages = [ pkgs.gdb ];

  plugins.dap = {
    enable = true;
    adapters.executables = {
      gdb = {
        command = "gdb";
        args = [
          "--interpreter=dap"
          "--eval-command"
          "set print pretty on"
        ];
      };
      rust-gdb = {
        command = "${pkgs.rustc}/bin/rust-gdb";
        args = [
          "--interpreter=dap"
          "--eval-command"
          "set print pretty on"
        ];
      };
    };

    signs = {
      dapBreakpoint = {
        text = "";
        texthl = "@constant.macro";
      };
      dapBreakpointCondition = {
        text = "";
        texthl = "@constant.macro";
      };
      dapBreakpointRejected.texthl = "@comment.error";
      dapStopped = {
        linehl = "@markup.emphasis";
        texthl = "@constant.macro";
      };
    };

    configurations = rec {
      c =
        let
          program.__raw =
            # lua
            ''
              function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
              end
            '';
          cwd = "\${workspaceFolder}";
          type = "gdb";
        in
        [
          {
            name = "Launch";
            request = "launch";
            inherit
              program
              cwd
              type
              ;
            args.__raw =
              # lua
              ''
                function()
                  return vim.fn.input("Arguments: ")
                end
              '';
            stopAtBeginningOfMainSubprogram = false;
          }
          {
            name = "Select and attach to process";
            request = "attach";
            inherit
              program
              cwd
              type
              ;
            pid.__raw =
              # lua
              ''
                function()
                  return tonumber(vim.fn.input("PID: "))
                end
              '';
          }
          {
            name = "Attach to gdbserver :1234";
            request = "attach";
            inherit
              program
              cwd
              type
              ;
            target = "localhost:1234";
          }
        ];

      cpp = c;
      rust = builtins.map (config: config // { type = "rust-gdb"; }) c;
    };
  };

  keymaps = [
    {
      key = "<leader>bp";
      action = "<cmd>DapToggleBreakpoint<CR>";
      options.desc = "Toggle breakpoint";
    }
    {
      key = "<leader><left>";
      action = "<cmd<DapStepOut<CR>";
      options.desc = "Dap: step out";
    }
    {
      key = "<leader><down>";
      action = "<cmd>DapStepOver<CR>";
      options.desc = "Dap: step over";
    }
    {
      key = "<leader><up>";
      action = "<cmd>DapRestartFrame<CR>";
      options.desc = "Dap: restart frame";
    }
    {
      key = "<leader><right>";
      action = "<cmd>DapStepInto<CR>";
      options.desc = "Dap: step into";
    }
    {
      key = "<F1>";
      action = "<cmd>DapContinue<CR>";
      options.desc = "Dap: continue";
    }
    {
      key = "<F12>";
      action = "<cmd>DapNew<CR>";
      options.desc = "Start new debug session";
    }
    {
      key = "<leader>E";
      action.__raw = "require('dap.ui.widgets').hover";
      options.desc = "Dap: hover";
    }
  ];

  # Automatically open the dapui sidebar
  extraConfigLuaPost = ''
    local dap = require("dap")
    local dapui = require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  '';
}
