{...}: {
  programs.nixvim = {
    plugins.oil = {
      enable = true;
    };
    keymaps = [
      {
        action = "require(\"oil\").open_float";
        key = "<leader>op";
        lua = true;
        options = {
          desc = "Open oil";
        };
      }
    ];
  };
}
