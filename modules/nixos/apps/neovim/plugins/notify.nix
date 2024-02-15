{...}: {
  programs.nixvim = {
    plugins = {
      notify = {
        enable = true;
        maxWidth = 50;
        icons = {
          debug = "󰯠";
          error = "";
          info = "";
          warn = "";
        };
      };
    };
  };
}
