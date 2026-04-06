{ pkgs, ... }:
{
  plugins.dap-virtual-text.enable = true;

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
      c = [
        {
          name = "Launch";
          type = "gdb";
          request = "launch";

          program.__raw =
            # lua
            ''
              function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
              end
            '';
          cwd = "\${workspaceFolder}";
          stopAtBeginningOfMainSubprogram = false;
        }
        {
          name = "Select and attach to process";
          type = "gdb";
          request = "attach";

          program.__raw =
            # lua
            ''
              function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
              end
            '';
          pid.__raw =
            # lua
            ''
              function()
                local name = vim.fn.input("Executable name (filter): ")
                return require("dap.utils").pick_process({ filter = name })
              end
            '';
          cwd = "\${workspaceFolder}";
        }
        {
          name = "Attach to gdbserver :1234";
          type = "gdb";
          request = "attach";

          target = "localhost:1234";
          program.__raw =
            # lua
            ''
              function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
              end
            '';
          cwd = "\${workspaceFolder}";
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
}
