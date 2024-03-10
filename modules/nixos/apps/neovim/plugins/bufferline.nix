{colors, ...}: {
  programs.nixvim = {
    extraConfigLua = ''
      require("bufferline").setup {
          highlights = require("catppuccin.groups.integrations.bufferline").get(),
      }
    '';
    plugins = {
      bufferline = {
        enable = true;
        separatorStyle = "thin";
        bufferCloseIcon = "";
        modifiedIcon = "";
        closeIcon = "";
        showCloseIcon = false;
        maxNameLength = 14;
        maxPrefixLength = 13;
        tabSize = 10;
        showTabIndicators = true;
        indicator = {
          style = "underline";
        };
        enforceRegularTabs = false;
        showBufferCloseIcons = true;
        alwaysShowBufferline = true;
        diagnostics = false;
        themable = true;
        hover = {
          enabled = true;
          reveal = ["close"];
        };
        offsets = [
          {
            filetype = "neo-tree";
            text = "Neo-tree";
            highlight = "Directory";
            text-align = "left";
          }
        ];
        groups = {
          items = [
            {
              name = "Tests";
              highlight = {
                underline = true;
                sp = "blue";
              };
              priority = 2;
              icon = "󰙨";
              matcher = ''
                function(buf)
                    return buf.filename:match('&_test') or buf.filename:match('%_spec') or buf.filename:match('&.test') or buf.filename:match('%.spec')

                end
              '';
            }
          ];
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<Tab>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options = {
          desc = "Go to next buffer";
        };
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options = {
          desc = "Go to previous buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options = {
          desc = "Close current buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>BufferLinePick<cr>";
        options = {
          desc = "Pick buffer to go to";
        };
      }
      {
        mode = "n";
        key = "<leader>bt";
        action = "<cmd>BufferLineTogglePin<cr>";
        options = {
          desc = "Toggle current buffer as pinned";
        };
      }
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>e #<cr>";
        options = {
          desc = "Go to last visited buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>bf";
        action = "<cmd>BufferLineGoToBuffer 1<cr>";
        options = {
          desc = "Go to first buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>br";
        action = "<cmd>BufferLineCloseRight<cr>";
        options = {
          desc = "Close all buffers to the right";
        };
      }
      {
        mode = "n";
        key = "<leader>bl";
        action = "<cmd>BufferLineCloseLeft<cr>";
        options = {
          desc = "Close all buffers to the left";
        };
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>BufferLineCloseOthers<cr>";
        options = {
          desc = "Close all other buffers";
        };
      }
    ];
  };
}
