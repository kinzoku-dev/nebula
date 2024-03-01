{...}: {
  programs.nixvim = {
    plugins = {
      notify = {
        enable = true;
        maxWidth = 50;
        timeout = 500;
        topDown = false;
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
