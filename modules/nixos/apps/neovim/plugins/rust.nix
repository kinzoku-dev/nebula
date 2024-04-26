{...}: {
  programs.nixvim = {
    plugins = {
      # rust-tools = {
      #   enable = true;
      # };
      rustaceanvim = {
        enable = true;
      };
    };
  };
}
