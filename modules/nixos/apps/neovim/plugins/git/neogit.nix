{...}: {
  programs.nixvim = {
    plugins.neogit = {
      enable = true;
      disableBuiltinNotifications = true;
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
