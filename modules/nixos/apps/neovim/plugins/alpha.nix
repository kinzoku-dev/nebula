{...}: {
  programs.nixvim = {
    # plugins.alpha = {
    #   enable = true;
    #   iconsEnabled = true;
    #   theme = null;
    #   layout = let
    #     padding = val: {
    #       type = "padding";
    #       inherit val;
    #     };
    #   in [
    #     (padding 4)
    #     {
    #       opts = {
    #         hl = "AlphaHeader";
    #         position = "center";
    #       };
    #       type = "text";
    #       val = [
    #         "███╗   ██╗███████╗██████╗ ██╗   ██╗██╗   ██╗██╗███╗   ███╗"
    #         "████╗  ██║██╔════╝██╔══██╗██║   ██║██║   ██║██║████╗ ████║"
    #         "██╔██╗ ██║█████╗  ██████╔╝██║   ██║██║   ██║██║██╔████╔██║"
    #         "██║╚██╗██║██╔══╝  ██╔══██╗██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
    #         "██║ ╚████║███████╗██████╔╝╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
    #         "╚═╝  ╚═══╝╚══════╝╚═════╝  ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
    #       ];
    #     }
    #     (padding 2)
    #     {
    #       type = "group";
    #       val = [
    #         {
    #           command = "<cmd>Telescope find_files<CR>";
    #           desc = "󰥩 Find files";
    #           shortcut = "f";
    #         }
    #         {
    #           command = "<cmd>Telescope frecency<CR>";
    #           desc = "󰪻 Recent files";
    #           shortcut = "r";
    #         }
    #         {
    #           command = "<cmd>qa<CR>";
    #           desc = " Quit";
    #           shortcut = "SPC q";
    #         }
    #       ];
    #     }
    #     (padding 2)
    #   ];
    # };
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
