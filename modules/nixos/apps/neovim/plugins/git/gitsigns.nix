{...}: {
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      trouble = true;
      currentLineBlame = false;
    };
    keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>gs";
        action = "gitsigns";
      }
      {
        mode = "n";
        key = "<leader>gsb";
        action = ":Gitsigns blame_line<CR>";
        options = {
          silent = true;
          desc = "Blame line";
        };
      }
      {
        mode = "n";
        key = "<leader>gsd";
        action = ":Gitsigns diffthis<CR>";
        options = {
          silent = true;
          desc = "Diff This";
        };
      }
      {
        mode = "n";
        key = "<leader>gsp";
        action = ":Gitsigns preview_hunk<CR>";
        options = {
          silent = true;
          desc = "Preview hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>gsR";
        action = ":Gitsigns reset_buffer<CR>";
        options = {
          silent = true;
          desc = "Reset Buffer";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>gsr";
        action = ":Gitsigns reset_hunk<CR>";
        options = {
          silent = true;
          desc = "Reset Hunk";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>gss";
        action = ":Gitsigns stage_hunk<CR>";
        options = {
          silent = true;
          desc = "Stage Hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>gsS";
        action = ":Gitsigns stage_buffer<CR>";
        options = {
          silent = true;
          desc = "Stage Buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>gsu";
        action = ":Gitsigns undo_stage_hunk<CR>";
        options = {
          silent = true;
          desc = "Undo Stage Hunk";
        };
      }
    ];
  };
}
