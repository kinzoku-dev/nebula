{...}: {
  programs.nixvim = {
    plugins.dap = {
      enable = true;
      extensions = {
        dap-ui = {
          enable = true;
        };
      };
      configurations = {
        "rust" = [
          {
            name = "Launch";
            type = "gdb";
            request = "launch";
          }
        ];
      };
      adapters = {
        executables = {
          "gdb" = {
            args = [
              "-i"
              "dap"
            ];
            command = "gdb";
          };
        };
      };
    };
    extraConfigLua = ''
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    '';
    keymaps = [
      {
        key = "<leader>dt";
        action = "<cmd> DapToggleBreakpoint <CR>";
      }
      {
        key = "<leader>dc";
        action = "<cmd> DapContinue <CR>";
      }
      {
        key = "<leader>dx";
        action = "<cmd> DapTerminate <CR>";
      }
      {
        key = "<leader>do";
        action = "<cmd> DapStepOver <CR>";
      }
    ];
  };
}
