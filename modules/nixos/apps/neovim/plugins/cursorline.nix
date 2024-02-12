{...}: {
  programs.nixvim = {
    plugins.cursorline = {
      enable = true;
      cursorline = {
        enable = true;
        number = true;
      };
      cursorword = {
        enable = true;
        hl = {underline = true;};
        minLength = 3;
      };
    };
  };
}
