{pkgs, ...}: {
  programs.nixvim = {
    plugins.none-ls = {
      enable = true;
      enableLspFormat = true;
      updateInInsert = false;
      sources = {
        code_actions = {
          refactoring.enable = true;
          gitsigns.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          ansiblelint.enable = true;
          statix.enable = true;
          deadnix.enable = true;
          fish.enable = true;
          yamllint.enable = true;
          gdlint.enable = true;
          editorconfig_checker.enable = true;
        };
        formatting = {
          csharpier.enable = true;
          prettier.enable = true;
          gdformat.enable = true;
          gofmt.enable = true;
          stylua.enable = true;
          leptosfmt.enable = true;
          terraform_fmt.enable = true;
          alejandra.enable = true;
          hclfmt.enable = true;
        };
      };
    };
    extraConfigLua = ''
      local null_ls = require("null-ls")

      local function get_fun_predicate(node, params)
        if node == nil or node:type() ~= "identifier" then return false end

        local parent = node:parent()
        if parent == nil or (parent:type() ~= "function_definition" and parent:type() ~= "function_item") then return false end

        local node_text = vim.treesitter.get_node_text(node, params["bufnr"])
        if node_text:match("^get") == nil then return false end

        return true
      end

      null_ls.register({
        name = "my-source",
        method = null_ls.methods.CODE_ACTION,
        filetypes = { "_all" },
        generator = {
          fn = function(params)
            local out = {}

            local node = vim.treesitter.get_node()
            if params.content[params.row]:match("amazing") then
                table.insert(out,
                  {
                    title = 'test',
                    action = function()
                      print("hello!")
                    end
                  })
            end

            if get_fun_predicate(node, params) then
              table.insert(out,
                {
                  title = 'test2',
                  action = function()
                    local commentstring = vim.bo.commentstring:gsub("%%s", "")
                    vim.fn.append(params.row-1, commentstring:gsub(" ", "") .. [[ HELLO!]])
                  end
                })
            end

            return out
          end,
        }
      })

      null_ls.register({
        name = "my-other-source",
        method = null_ls.methods.DIAGNOSTICS,
        filetypes = { "_all" },
        generator = {
          fn = function(params)
            local out = {}

            for i, line in ipairs(params.content) do
              local commentstring = vim.bo.commentstring:gsub("%%s", "")
              local match = line:match(commentstring:gsub(" ", "")  .. [[ NOTE(.*)]])
              if match then
                table.insert(out, {
                  row = i,
                  message = [[NOTE ]] .. match,
                  severity = vim.diagnostic.severity.INFO,
                })
              end
            end

            return out
          end
        }
      })

      local function get_fun_predicate_1(node, params)
        if node == nil or node:type() ~= "identifier" then return false end

        local parent = node:parent()
        if parent == nil or parent:type() ~= "let_declaration" then return false end

        local prev_sibling = node:prev_sibling()
        if prev_sibling == nil or prev_sibling:type() == "mutable_specifier" then return false end

        return true
      end

      null_ls.register({
        name = "rust-actions",
        method = null_ls.methods.CODE_ACTION,
        filetypes = { "rust" },
        generator = {
          fn = function(params)
            local out = {}


            local node = vim.treesitter.get_node()
            if get_fun_predicate_1(node, params) then
              table.insert(out,
                {
                  title = 'Add `mut` keyword',
                  action = function()
                      vim.cmd([[s/let/let mut]])
                      vim.cmd([[noh]])
                  end
                })
            end

            return out
          end
        },
      })
    '';
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>lf";
        action = "function() vim.lsp.buf.format() end";
        lua = true;
        options = {
          silent = true;
          desc = "LSP format";
        };
      }
    ];
  };
}
