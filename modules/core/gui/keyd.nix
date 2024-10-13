{
  services.keyd = {
    enable = true;
    keyboards.true = {
      ids = [ "*" ];
      settings.main = {
        capslock = "control";
        rightshift = "esc";
      };
    };
  };
}
