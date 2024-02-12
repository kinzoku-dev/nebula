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
    home.xdgDesktopEntries = {
      nvim = lib.mkForce {
        name = "Neovim";
        type = "Application";
        mimeType = ["text/plain"];

        icon = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/NotAShelf/neovim-flake/main/assets/neovim-flake-logo-work.svg";
          sha256 = "19n7n9xafyak35pkn4cww0s5db2cr97yz78w5ppbcp9jvxw6yyz3";
        };
        exec = "kitty nvim";
      };
    };

    programs.nixvim = {
      enable = true;
      extraPlugins = let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        plugpkgs = pkgs.vimPlugins;
      in [
        plugpkgs.friendly-snippets
        plugpkgs.lazygit-nvim
        plugpkgs.aerial-nvim
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
        rust-analyzer
        alejandra

        chafa
        imagemagick
        ffmpegthumbnailer
        poppler_utils
        fontpreview
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

        require("luasnip.loaders.from_vscode").lazy_load()

        local lsnip = require 'luasnip'
        local s = lsnip.snippet
        local t = lsnip.text_node
        local i = lsnip.insert_node
        local extras = require 'luasnip.extras'
        local rep = extras.rep
        local fmt = require('luasnip.extras.fmt').fmt

        lsnip.add_snippets('nix', {
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

        require('aerial').setup({
                backends = { "treesitter", "lsp" },
                on_attach = function(bufnr)
                    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
                layout = {
                    max_width = { 40, 0.2 },
                    width = nil,
                    min_width = 20,

                    default_direction = "prefer_right",
                },
        })

      '';
      keymaps = [
        {
          action = ":m '>+1<CR>gv=gv";
          key = "J";
          mode = "v";
          options = {
            silent = true;
            noremap = true;
          };
        }
        {
          action = ":m '<-2<CR>gv=gv";
          key = "K";
          mode = "v";
          options = {
            silent = true;
            noremap = true;
          };
        }
        {
          action = "<cmd>LazyGit<CR>";
          key = "<leader>gg";
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
          action = "<cmd>AerialToggle!<CR>";
          key = "<leader>ae";
        }
        {
          action = "<cmd>Neotree toggle<CR>";
          key = "<C-n>";
        }
        {
          action = "<cmd>q<CR>";
          key = "<leader>qq";
        }
        {
          action = "<cmd>qa<CR>";
          key = "<leader>qa";
        }
        {
          action = "<cmd>w<CR>";
          key = "<leader>ww";
        }
        {
          action = "<cmd>wq<CR>";
          key = "<leader>wq";
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
        {
          action = "\"_dP";
          key = "<leader>p";
          mode = "x";
        }
        {
          action = "\"_d";
          key = "<leader>d";
          mode = ["n" "v"];
        }
        {
          action = "mzJ`z";
          key = "J";
          mode = "n";
        }
        {
          action = "<C-d>zz";
          key = "<C-d>";
          mode = "n";
        }
        {
          action = "<C-u>zz";
          key = "<C-u>";
          mode = "n";
        }
        {
          action = "<cmd>Trouble<CR>";
          key = "<leader>tr";
        }
        {
          mode = "n";
          action = "<cmd>UndotreeToggle<CR>";
          key = "<leader>u";
        }
        {
          action = "<C-r>";
          key = "U";
        }
      ];
      plugins = {
        tmux-navigator.enable = true;
        emmet = {
          enable = true;
          mode = "n";
          leader = ",";
        };
        /*
           floaterm = {
          enable = true;
          position = "center";
          autoclose = 0;
          autohide = 1;
          shell = "${config.system.shell.shell}";
          wintype = "float";
          keymaps = {
            toggle = "<leader>tt";
          };
        };
        */
        toggleterm = {
          enable = true;
          size = ''
            function(term)
              if term.direction == "horizontal" then
                  return 15
              elseif term.direction == "vertical" then
                  return vim.o.columns * 0.4
              end
            end
          '';
          openMapping = "<leader>tt";
          hideNumbers = true;
          shadeTerminals = true;
          startInInsert = true;
          terminalMappings = true;
          persistMode = true;
          insertMappings = false;
          closeOnExit = true;
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
        bufferline = {
          enable = true;
          bufferCloseIcon = "";
          closeIcon = "";
          modifiedIcon = "";
          indicator.style = "underline";
          rightTruncMarker = "";
          leftTruncMarker = "";
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
          cmdline = {
            enabled = true;
            format = {
              cmdline = {
                pattern = "^:";
                icon = "";
                lang = "vim";
              };
              search_down = {
                kind = "search";
                pattern = "^/";
                icon = " ";
                lang = "regex";
              };
              search_up = {
                kind = "search";
                pattern = "^%?";
                icon = " ";
                lang = "regex";
              };
              find = {
                pattern = [":%s*%%s*s:%s*" ":%s*%%s*s!%s*" ":%s*%%s*s/%s*" "%s*s:%s*" ":%s*s!%s*" ":%s*s/%s*"];
                icon = "";
                lang = "regex";
              };
              replace = {
                pattern = [":%s*%%s*s:%w*:%s*" ":%s*%%s*s!%w*!%s*" ":%s*%%s*s/%w*/%s*" "%s*s:%w*:%s*" ":%s*s!%w*!%s*" ":%s*s/%w*/%s*"];
                icon = "󱞪";
                lang = "regex";
              };
              input = {};
            };
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
        undotree = {
          enable = true;
          autoOpenDiff = true;
          focusOnToggle = true;
        };
        which-key = {
          enable = true;
          registrations = {
            "<leader>l".name = " LSP";
          };
        };
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
