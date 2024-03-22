{...}: {
  programs.nixvim = {
    plugins.alpha = {
      enable = true;
      iconsEnabled = true;
      theme = null;
      layout = let
        padding = val: {
          type = "padding";
          inherit val;
        };
      in [
        (padding 4)
        {
          opts = {
            hl = "Type";
            position = "center";
          };
          type = "text";
          val = [
            "███╗   ██╗███████╗██████╗ ██╗   ██╗██╗   ██╗██╗███╗   ███╗"
            "████╗  ██║██╔════╝██╔══██╗██║   ██║██║   ██║██║████╗ ████║"
            "██╔██╗ ██║█████╗  ██████╔╝██║   ██║██║   ██║██║██╔████╔██║"
            "██║╚██╗██║██╔══╝  ██╔══██╗██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
            "██║ ╚████║███████╗██████╔╝╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
            "╚═╝  ╚═══╝╚══════╝╚═════╝  ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ];
        }
        (padding 2)
        {
          type = "group";
          opts = {
            position = "center";
          };
          val = [
            {
              on_press = {
                __raw = "function() vim.cmd[[Telescope find_files]] end";
              };
              val = "󰥩 Find files";
              type = "button";
              opts = {
                shortcut = "f";
                position = "center";
              };
            }
            {
              on_press = {
                __raw = "function() vim.cmd[[Telescope oldfiles]] end";
              };
              val = "󰪻 Recent files";
              type = "button";
              opts = {
                shortcut = "r";
                position = "center";
              };
            }
            {
              on_press = {
                __raw = "function() vim.cmd[[qa]] end";
              };
              type = "button";
              val = " Quit";
              opts = {
                shortcut = "SPC q";
                position = "center";
              };
            }
          ];
        }
        (padding 2)
        {
          opts = {
            hl = "Keyword";
            position = "center";
          };
          type = "text";
          val = "My balls itch.";
        }
      ];
    };
    # keymaps = [
    #   {
    #     action = ''
    #         function()
    #         local wins = vim.api.nvim_tabpage_list_wins(0)
    #         if #wins > 1
    #             and vim.api.nvim_get_option_value("filetype", { win = wins[1] })
    #             == "neo-tree"
    #         then
    #           vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
    #         end
    #         require("alpha").start(false, require("alpha").default_config)
    #         vim.b.miniindentscope_disable = true
    #       end
    #     '';
    #     lua = true;
    #     key = "<leader>h";
    #     options = {
    #       silent = true;
    #       desc = "Home screen";
    #     };
    #   }
    # ];
  };
}
