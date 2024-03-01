{...}: {
  programs.nixvim = {
    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      experimental = {
        ghost_text = true;
      };
      performance = {
        debounce = 60;
        fetchingTimeout = 200;
        maxViewEntries = 30;
      };
      snippet.expand = "luasnip";
      formatting = {
        fields = ["kind" "abbr" "menu"];
        expandableIndicator = true;
      };
      window = {
        completion = {
          border = "rounded";
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
        };
        documentation = {
          border = "rounded";
        };
      };
      sources = [
        {name = "nvim_lsp";}
        {
          name = "buffer";
          option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          keywordLength = 3;
        }
        {
          name = "path";
          keywordLength = 3;
        }
        {
          name = "luasnip";
          keywordLength = 3;
        }
      ];
      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = {
          action = ''
            function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
            else
                fallback()
                    end
                    end
          '';
          modes = ["i" "s"];
        };
        "<S-Tab>" = {
          action = ''
            function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
            else
                fallback()
                    end
                    end
          '';
          modes = ["i" "s"];
        };
        "<C-Space>" = {
          action = "cmp.mapping.complete()";
        };
        "<S-CR>" = {
          action = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };
    };
    extraConfigLua = ''
        luasnip = require("luasnip")
        kind_icons = {
          Text = "󰊄",
          Method = "",
          Function = "󰡱",
          Constructor = "",
          Field = "",
          Variable = "󱀍",
          Class = "",
          Interface = "",
          Module = "󰕳",
          Property = "",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
        } 

      local cmp = require'cmp'

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({'/', "?" }, {
            sources = {
            { name = 'buffer' }
            }
            })

      -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                { name = 'buffer' },
                })
            })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' }
                }, {
                { name = 'cmdline' }
                }),
            })  '';
  };
}
