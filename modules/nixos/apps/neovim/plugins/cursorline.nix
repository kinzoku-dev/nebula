{...}: {
  programs.nixvim = {
    plugins.cursorline = {
      enable = true;
      cursorline = {
        enable = true;
        number = true;
        timeout = 0;
      };
      cursorword = {
        enable = true;
        hl = {underline = true;};
        minLength = 3;
      };
    };
  };
}
