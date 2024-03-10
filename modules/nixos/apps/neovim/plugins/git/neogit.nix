{...}: {
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
      settings.disable_builtin_notifications = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gn";
        action = "<cmd>Neogit<CR>";
      }
    ];
  };
}
