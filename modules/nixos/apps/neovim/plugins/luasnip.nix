{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [friendly-snippets];
    extraConfigLua = ''
          require("luasnip.loaders.from_vscode").lazy_load()

      local lsnip = require 'luasnip'
      local s = lsnip.snippet
      local t = lsnip.text_node
      local i = lsnip.insert_node
      local c = lsnip.choice_node
      local extras = require 'luasnip.extras'
      local rep = extras.rep
      local fmt = require('luasnip.extras.fmt').fmt

      vim.keymap.set({ "i", "s" }, "<A-j>", function()
          if lsnip.expand_or_jumpable() then
              lsnip.expand_or_jump()
          end
      end, {silent = true})

      vim.keymap.set({ "i", "s" }, "<A-k>", function()
          if lsnip.jumpable(-1) then
              lsnip.jump(-1)
          end
      end, {silent = true})

      lsnip.add_snippets('all', {
          s('enb', {
              t('enable = true;'),
          }),
      })

      lsnip.add_snippets('nix', {
          s('attrs',
              fmt(
                  [[
                      {} = {{
                          {};
                      }};
                  ]],
                  {
                      i(1),
                      i(2),
                  }
              )
          ),
          s('list',
              fmt(
                  [[
                      {} = [
                          {}
                      ];
                  ]],
                  {
                      i(1),
                      i(2),
                  }
              )
          ),
          s('listwith',
                fmt(
                    [[
                        {} = with {}; [
                            {}
                        ];
                    ]],
                    {
                        i(1),
                        i(2),
                        i(3),
                    }
                )
          ),
          s('flakeinput',
              fmt(
                  [[
                      {} = {{
                          url = "github:{}";
                      }};
                  ]],
                  {
                      i(1),
                      i(2),
                  }
              )
          ),
          s('vimpluginput',
              fmt(
                  [[
                      plugin-{} = {{
                          url = "github:{}";
                          flake = false;
                      }};
                  ]],
                  {
                      i(1),
                      i(2),
                  }
              )
          ),
          s('vimplugoverlay',
              fmt(
              [[
                  {} = prev.vimUtils.buildVimPlugin {{
                      name = "{}";
                      src = {};
                  }};
              ]],
              {
                  i(1),
                  i(2),
                  i(3),
              }
              )
          )
      })

      lsnip.add_snippets('bash', {
          s('bash-if',
              fmt(
                  [=[
                      if [[ {} ]]; then
                          {}
                      fi
                  ]=],
                  {
                      i(1),
                      i(2),
                  }
              )
          ),
          s('bash-if_else',
              fmt(
                  [=[
                      if [[ {} ]]; then
                          {}
                      else
                          {}
                      fi
                  ]=],
                  {
                      i(1),
                      i(2),
                      i(3),
                  }
              )
          ),
          s('bash-if_elif_else',
              fmt(
                  [=[
                      if [[ {} ]]; then
                          {}
                      elif [[ {} ]]; then
                          {}
                      else
                          {}
                      fi
                  ]=],
                  {
                      i(1),
                      i(2),
                      i(3),
                      i(4),
                      i(5),
                  }
              )
          ),
          s('bash-elif',
              fmt(
                  [=[
                      elif [[ {} ]]; then
                          {}
                  ]=],
                  {
                      i(1),
                      i(2),
                  }
              )
          )
      })

      lsnip.filetype_extend("bash", {"sh", "nix"})

      lsnip.add_snippets('javascript', {
          s('ts-ignore', {
              t("// @ts-ignore"),
          }),
          s('ts-nocheck', {
              t("// @ts-nocheck"),
          }),
          s('eslint-disable', {
              t("/* eslint "),
              i(1),
              t(": 0 */"),
          }),
      })

      lsnip.filetype_extend("javascript", {"javascriptreact", "typescript", "typescriptreact"})

    '';
    plugins = {
      luasnip = {
        enable = true;
        extraConfig = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
      };
    };
  };
}
