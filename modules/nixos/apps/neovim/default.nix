{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.neovim;
in {
  options.apps.neovim = with types; {
    enable = mkBoolOpt false "Enable or disable neovim";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables.EDITOR = "nvim";
    programs.nixvim = {
      enable = true;
      extraPlugins = let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        plugpkgs = pkgs.vimPlugins;
      in [
        plugpkgs.friendly-snippets
        plugpkgs.move-nvim
	/*
        {
          plugin = plugpkgs.neocord;
          config = toLua ''
            require("neocord").setup({
                    logo = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp"
            })
          '';
        }
	*/
      ];
      extraPackages = with pkgs; [
        nil
        stylua
        luajitPackages.lua-lsp
        ripgrep
      ];
      globals = {
        mapleader = " ";
      };
      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };
      colorschemes = {
        catppuccin = {
          enable = true;
          flavour = "mocha";
          transparentBackground = true;
          integrations = {
            alpha = true;
            cmp = true;
            gitsigns = true;
            leap = true;
            lsp_trouble = true;
            neotree = true;
            noice = true;
            treesitter = true;
            which_key = true;
          };
        };
      };
      extraConfigLua = ''
            local mode_map = {
                ['n']    = 'NORMAL',
                ['no']   = 'O-PENDING',
                ['nov']  = 'O-PENDING',
                ['noV']  = 'O-PENDING',
                ['no�'] = 'O-PENDING',
                ['niI']  = 'NORMAL',
                ['niR']  = 'NORMAL',
                ['niV']  = 'NORMAL',
                ['nt']   = 'NORMAL',
                ['v']    = 'VISUAL',
                ['vs']   = 'VISUAL',
                ['V']    = 'V-LINE',
                ['Vs']   = 'V-LINE',
                ['�']   = 'V-BLOCK',
                ['�s']  = 'V-BLOCK',
                ['s']    = 'SELECT',
                ['S']    = 'S-LINE',
                ['�']   = 'S-BLOCK',
                ['i']    = 'INSERT',
                ['ic']   = 'INSERT',
                ['ix']   = 'INSERT',
                ['R']    = 'REPLACE',
                ['Rc']   = 'REPLACE',
                ['Rvc']  = 'V-REPLACE',
                ['Rvx']  = 'V-REPLACE',
                ['c']    = 'COMMAND',
                ['cv']   = 'EX',
                ['ce']   = 'EX',
                ['r']    = 'REPLACE',
                ['rm']   = 'MORE',
                ['r?']   = 'CONFIRM',
                ['!']    = 'SHELL',
                ['t']    = 'TERMINAL',
            }

        require('lualine').setup({
            sections = {
                lualine_a = {function ()
                    return mode_map[vim.api.nvim_get_mode().mode] or "__"
                end},
            },
        })
      '';
      keymaps = [
        {
          action = "require(\"oil\").open_float";
          key = "<leader>op";
          lua = true;
          options = {
            desc = "Open oil";
          };
        }
        {
          action = "<cmd>MoveLine(1)<CR>";
          key = "J";
          mode = "v";
          options = {
            silent = true;
            noremap = true;
          };
        }
        {
          action = "<cmd>MoveLine(-1)<CR>";
          key = "K";
          mode = "v";
          options = {
            silent = true;
            noremap = true;
          };
        }
        {
          action = "nzzzv";
          key = "n";
        }
        {
          action = "Nzzzv";
          key = "N";
        }
        {
          action = "<cmd>noh<CR>";
          key = "<leader>noh";
        }
        {
          action = "<cmd>Neotree toggle<CR>";
          key = "<C-n>";
        }
        {
          action = "<cmd>q<CR>";
          key = "<leader>q";
        }
        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<leader>ff";
        }
        {
          action = "<cmd>Telescope frecency<CR>";
          key = "<leader>fr";
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>ft";
        }
        {
          action = "<cmd>Telescope buffers<CR>";
          key = "<leader>fb";
        }
        {
          action = "<cmd>Telescope media_files<CR>";
          key = "<leader>fm";
        }
        {
          action = "<cmd>Telescope undo<CR>";
          key = "<leader>fu";
        }
        {
          action = "<cmd>Gitsigns blame_line<CR>";
          key = "<leader>gb";
        }
        {
          action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
          key = "<leader>gbt";
        }
        {
          action = "<cmd>bnext<CR>";
          key = "<leader><Tab>";
        }
        {
          action = "<cmd>bprev<CR>";
          key = "<leader><S-Tab>";
        }
        {
          action = "<cmd>bdel<CR>";
          key = "<C-x>";
        }
      ];
      plugins = {
        alpha = {
          enable = true;
          iconsEnabled = true;
          layout = [
            {
              type = "padding";
              val = 2;
            }
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
            {
              type = "padding";
              val = 2;
            }
            {
              type = "group";
              val = [
                {
                  command = "<cmd>Telescope find_files<CR>";
                  desc = "󰥩 Find files";
                  shortcut = "f";
                }
                {
                  command = "<cmd>Telescope frecency<CR>";
                  desc = "󰪻 Recent files";
                  shortcut = "r";
                }
                {
                  command = "<cmd>qa<CR>";
                  desc = " Quit";
                  shortcut = "SPC q";
                }
              ];
            }
            {
              type = "padding";
              val = 2;
            }
          ];
        };
        oil = {
          enable = true;
        };
        telescope = {
          enable = true;
          extensions = {
            frecency.enable = true;
            media_files.enable = true;
            fzf-native.enable = true;
            undo.enable = true;
          };
        };
        tmux-navigator.enable = true;
        todo-comments.enable = true;
        nvim-cmp = {
          enable = true;
          autoEnableSources = true;
          sources = [
            {name = "nvim_lsp";}
            {name = "fuzzy-path";}
            {name = "fuzzy-buffer";}
            {name = "luasnip";}
            {name = "tmux";}
            {name = "treesitter";}
            {name = "cmdline";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = {
              action = "cmp.mapping.select_prev_item()";
              modes = [
                "i"
                "s"
              ];
            };
            "<Tab>" = {
              action = "cmp.mapping.select_next_item()";
              modes = [
                "i"
                "s"
              ];
            };
          };
        };
        comment-nvim = {
          enable = true;
        };
        conform-nvim = {
          enable = true;
          formatOnSave = {
            lspFallback = true;
          };
          formattersByFt = {
            lua = ["stylua"];
            javascript = [["prettierd" "prettier"]];
            typescript = [["prettierd" "prettier"]];
            javascriptreact = [["prettierd" "prettier"]];
            typescriptreact = [["prettierd" "prettier"]];
            rust = ["rustfmt"];
            go = ["gofumpt"];
            html = [["prettierd" "prettier"]];
            css = [["prettierd" "prettier"]];
            scss = [["prettierd" "prettier"]];
            nix = ["alejandra"];
          };
        };
        cursorline = {
          enable = true;
          cursorline = {
            enable = true;
            number = true;
          };
          cursorword = {
            enable = true;
            hl = {underline = true;};
            minLength = 3;
          };
        };
        emmet = {
          enable = true;
        };
        floaterm = {
          enable = true;
          position = "center";
          autoclose = 0;
          autohide = 1;
          shell = "nushell";
          wintype = "float";
          keymaps = {
            toggle = "<leader>tt";
          };
        };
        gitsigns = {
          enable = true;
          currentLineBlame = false;
          currentLineBlameOpts.virtTextPos = "overlay";
        };
        illuminate = {
          enable = true;
        };
        indent-blankline = {
          enable = true;
          scope = {
            enabled = true;
          };
        };
        leap = {
          enable = true;
        };
        lint = {
          enable = true;
          lintersByFt = {
            javascript = ["eslint"];
            json = ["jsonlint"];
            md = ["vale"];
          };
        };
        lsp = {
          enable = true;
          servers = {
            bashls.enable = true;
            clangd.enable = true;
            csharp-ls.enable = true;
            cssls.enable = true;
            emmet_ls.enable = true;
            eslint.enable = true;
            gdscript.enable = true;
            gopls.enable = true;
            html.enable = true;
            lua-ls.enable = true;
            nil_ls.enable = true;
            rust-analyzer = {
              installRustc = true;
              installCargo = true;
              enable = true;
            };
            svelte.enable = true;
            tailwindcss.enable = true;
            tsserver.enable = true;
            volar.enable = true;
            vuels.enable = true;
          };
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
            lspBuf = {
              gK = "hover";
              gD = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
            };
          };
        };
        bufferline = {
          enable = true;
          bufferCloseIcon = "";
          closeIcon = "";
          modifiedIcon = "";
        };
        lualine = {
          enable = true;
          iconsEnabled = true;
          theme = "catppuccin-mocha";
          sections = {
            lualine_b = ["branch"];
            lualine_c = ["filename"];
            lualine_x = ["filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
        };
        luasnip = {
          enable = true;
        };
        neo-tree = {
          enable = true;
        };
        noice = {
          enable = true;
          lsp = {
            hover = {
              enabled = true;
            };
            message = {
              enabled = true;
            };
            progress = {
              enabled = true;
            };
          };
          presets = {
            inc_rename = true;
            lsp_doc_border = true;
          };
        };
        inc-rename = {
          enable = true;
        };
        nvim-autopairs.enable = true;
        surround.enable = true;
        treesitter = {
          enable = true;
          ensureInstalled = [
            "rust"
            "lua"
            "nix"
            "typescript"
            "go"
          ];
        };
        barbecue = {
          enable = true;
        };
        treesitter-textobjects = {
          enable = true;
          select.enable = true;
        };
        ts-autotag.enable = true;
        which-key.enable = true;
        trouble = {
          enable = true;
        };
      };
      options = {
        nu = true;
        rnu = true;
        wrap = true;
        tabstop = 4;
        softtabstop = 4;
        shiftwidth = 4;
        smartindent = true;
        expandtab = true;
        backup = false;
        swapfile = false;
        undofile = true;
        undodir = "/home/${config.user.name}/.vim/undodir";
        termguicolors = true;
        spelllang = "en_us";
        spell = true;
        updatetime = 50;
        hlsearch = false;
        incsearch = true;
        scrolloff = 8;
        signcolumn = "yes";
      };
    };
  };
}
