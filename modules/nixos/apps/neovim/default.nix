{
  options,
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.neovim;
  theme = inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme};
  colors = theme.palette;
in {
  options.apps.neovim = with types; {
    enable = mkBoolOpt false "Enable or disable neovim";
  };

  config = mkIf cfg.enable {
    environment = {
      sessionVariables.EDITOR = "nvim";
      systemPackages = with pkgs; [silicon];
    };
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
      editorconfig.enable = true;
      colorschemes.base16 = {
        enable = true;
        customColorScheme =
          lib.concatMapAttrs (name: value: {
            ${name} = "#${value}";
          })
          config.colorScheme.palette;
      };
      extraPlugins = let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        plugpkgs = pkgs.vimPlugins;
      in [
        plugpkgs.aerial-nvim
        plugpkgs.playground
        plugpkgs.nui-nvim
        plugpkgs.openingh-nvim
        plugpkgs.nvim-ansible
        {
          plugin = plugpkgs.nvim-silicon;
          config = toLua ''
            require("silicon").setup({
                font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
                theme = "Dracula"
            })
          '';
        }
        {
          plugin = plugpkgs.treesj;
          config = toLua ''require("treesj").setup() '';
        }
      ];
      extraPackages = with pkgs; [
        nil
        stylua
        silicon
        luajitPackages.lua-lsp
        ripgrep
        rust-analyzer
        alejandra

        yamllint
        statix
        clippy
        csharpier
        ktlint
        deadnix
        nixfmt-rfc-style
        leptosfmt
        nixpkgs-fmt
        yamlfmt

        gdb

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
      highlight = {
        NoiceCmdlineIcon.fg = "#${colors.base05}";
        NoiceCmdlinePopupTitle.fg = "#${colors.base05}";
        NoiceCmdlinePopupBorderCmdline.fg = "#${colors.base07}";
        NoiceCmdlinePopupIconCmdline.fg = "#${colors.base07}";
        NoiceCmdlinePopupBorderSearch.fg = "#${colors.base0A}";
        NoiceCmdlinePopupIconSearch.fg = "#${colors.base0A}";
        NoiceCmdlinePopupBorderHelp.fg = "#${colors.base08}";
        NoiceCmdlinePopupIconHelp.fg = "#${colors.base08}";
        NoiceCmdlinePopupBorderLua.fg = "#${colors.base0D}";
        NoiceCmdlinePopupIconLua.fg = "#${colors.base0D}";
        LineNr.fg = "#${colors.base05}";
        LineNrAbove.fg = "#${colors.base05}";
        LineNrBelow.fg = "#${colors.base05}";
        CursorLineNr.fg = "#${colors.base07}";
        "@ibl.indent.char.1".fg = "#${colors.base02}";
        "@comment".fg = "#ffffff";
        "TSComment".fg = "#ffffff";
        "nixComment".fg = "#ffffff";
        "Comment".fg = "#ffffff";
      };
      extraConfigVim = ''
        autocmd FileType nix setlocal commentstring=#%s
      '';
      extraConfigLua = ''
            local mode_map = {
                ['n']    = '󰍜',
                ['no']   = 'O-PENDING',
                ['nov']  = 'O-PENDING',
                ['noV']  = 'O-PENDING',
                ['no�'] = 'O-PENDING',
                ['niI']  = '󰍜',
                ['niR']  = '󰍜',
                ['niV']  = '󰍜',
                ['nt']   = '󰍜',
                ['v']    = '󱄽',
                ['vs']   = '󱄽',
                ['V']    = '󱄽',
                ['Vs']   = '󱄽',
                ['�']   = '󱄽',
                ['�s']  = '󱄽',
                ['s']    = '󱄽',
                ['S']    = '󱄽',
                ['�']   = '󱄽',
                ['i']    = '',
                ['ic']   = '',
                ['ix']   = '',
                ['R']    = '',
                ['Rc']   = '',
                ['Rvc']  = '',
                ['Rvx']  = '',
                ['c']    = '',
                ['cv']   = 'EX',
                ['ce']   = 'EX',
                ['r']    = '',
                ['rm']   = 'MORE',
                ['r?']   = 'CONFIRM',
                ['!']    = '',
                ['t']    = '',
            }

        require('lualine').setup({
            sections = {
                lualine_a = {function ()
                    return mode_map[vim.api.nvim_get_mode().mode] or "__"
                end},
            },
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
          action = "<cmd>Silicon<CR>";
          key = "<leader>ss";
          mode = "v";
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
          action = "<cmd>OpenInGHRepo<CR>";
          key = "<leader>ghr";
        }
        {
          action = "<cmd>OpenInGHFile<CR>";
          key = "<leader>ghf";
        }
        {
          action = "<cmd>OpenInGHFileLines<CR>";
          key = "<leader>ghl";
        }
        {
          action = "<cmd>noh<CR>";
          key = "<leader>noh";
        }
        {
          action = "<cmd>TSJToggle<CR>";
          key = "<leader>m";
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
          action = "\"_dP";
          key = "p";
          mode = "x";
        }
        {
          action = "\"_d";
          key = "d";
          mode = [
            "n"
            "v"
          ];
        }
        {
          action = "\"_c";
          key = "c";
          mode = [
            "x"
            "n"
            "v"
          ];
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
          action = "<cmd>TroubleToggle document_diagnostics<CR>";
          key = "<leader>td";
        }
        {
          action = "<cmd>TroubleToggle workspace_diagnostics<CR>";
          key = "<leader>tw";
        }
        {
          action = "<cmd>TroubleToggle quickfix<CR>";
          key = "<leader>tq";
        }
        {
          action = "<cmd>TroubleToggle lsp_references<CR>";
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
        neocord = {
          enable = true;
          settings = {
            enable_line_number = true;
            auto_update = true;
            editing_text = "File: %s (editing)";
            reading_text = "File: %s (reading)";
            line_number_text = "Line: %s/%s";
            workspace_text = "Project: %s";
            logo = "https://raw.githubusercontent.com/kinzoku-dev/nebula/main/.github/assets/nebuvim_logo.png";
          };
        };
        nvim-bqf.enable = true;
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
          settings.open_mapping = "[[<A-t>]]";
          hideNumbers = true;
          shadeTerminals = true;
          startInInsert = true;
          terminalMappings = true;
          persistMode = true;
          insertMappings = false;
          closeOnExit = true;
        };
        gitblame.enable = true;
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
        lualine = {
          enable = true;
          iconsEnabled = true;
          sections = {
            lualine_b = ["branch"];
            lualine_c = ["filename"];
            lualine_x = ["filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
        };
        neo-tree = {
          enable = true;
          enableDiagnostics = true;
          enableGitStatus = true;
          enableModifiedMarkers = true;
          enableRefreshOnWrite = true;
          closeIfLastWindow = true;
          popupBorderStyle = "rounded";
          buffers = {
            bindToCwd = false;
            followCurrentFile = {
              enabled = true;
            };
          };
          window = {
            width = 40;
            height = 15;
            autoExpandWidth = false;
            mappings = {
              "<space>" = "none";
            };
          };
        };
        noice = {
          enable = true;
          popupmenu = {
            enabled = true;
            backend = "nui";
          };
          lsp = {
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              "cmp.entry.get_documentation" = true;
            };
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
                pattern = [
                  ":%s*%%s*s:%s*"
                  ":%s*%%s*s!%s*"
                  ":%s*%%s*s/%s*"
                  "%s*s:%s*"
                  ":%s*s!%s*"
                  ":%s*s/%s*"
                  ":%s*'<,'>s/\%s*%%s*V%s*"
                ];
                icon = "";
                lang = "regex";
              };
              replace = {
                pattern = [
                  ":%s*%%s*s:%w*:%s*"
                  ":%s*%%s*s!%w*!%s*"
                  ":%s*%%s*s/%w*/%s*"
                  "%s*s:%w*:%s*"
                  ":%s*s!%w*!%s*"
                  ":%s*s/%w*/%s*"
                  ":%s*'<,'>s/\%s*%%s*V%w*/%s*"
                ];
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
            "bash"
            "fish"
            "rust"
            "lua"
            "nix"
            "typescript"
            "go"
            "gdscript"
            "gdresource"
            "gomod"
            "gosum"
            "haskell"
            "html"
            "java"
            "json"
            "kotlin"
            "markdown"
            "python"
            "scss"
            "svelte"
            "todotxt"
            "toml"
            "tsx"
            "yaml"
            "ini"
            "latex"
          ];
          folding = true;
          indent = true;
          nixvimInjections = true;
          incrementalSelection.enable = true;
        };
        refactoring.enable = true;
        treesitter-refactor = {
          enable = true;
          highlightDefinitions.enable = true;
          smartRename.enable = true;
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
          settings = {
            auto_close = true;
          };
        };
      };
      options = {
        # enable relative line numbers
        nu = true;
        rnu = true;

        # set tabs to 2 spaces
        tabstop = 2;
        softtabstop = 2;
        showtabline = 2;
        expandtab = true;

        # enable auto intending and set it to spaces
        smartindent = true;
        shiftwidth = 2;

        # enable smart indenting
        breakindent = true;

        # enable incremental searching
        hlsearch = true;
        incsearch = true;

        # enable text wrap
        wrap = true;

        # better splitting
        splitbelow = true;
        splitright = true;

        # enable ignorecase + smartcase for better searching
        ignorecase = true;
        smartcase = true; # don't ignore case with capitals
        grepprg = "rg --vimgrep";
        grepformat = "%f:%l:%c:%m";

        # decrease updatetime
        updatetime = 50;

        # set completeopt
        completeopt = [
          "menuone"
          "noselect"
          "noinsert"
        ];

        # enable persistent undo directory
        swapfile = false;
        backup = false;
        undofile = true;

        # enable termguicolors
        termguicolors = true;

        # enable sign column
        signcolumn = "yes";

        # set folding options
        foldcolumn = "0";
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = false;

        # always keep 8 lines above/below cursor
        scrolloff = 8;

        # reduce which-key timeout
        timeoutlen = 10;

        # set encoding type
        encoding = "utf-8";
        fileencoding = "utf-8";

        # more space in cmdline
        cmdheight = 2;
      };
    };
  };
}
