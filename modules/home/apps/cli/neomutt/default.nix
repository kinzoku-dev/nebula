{
  config,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.home.apps.cli.neomutt;
in {
  options.home.apps.cli.neomutt = with types; {
    enable = mkBoolOpt false "Enable neomutt";
  };

  config = mkIf cfg.enable {
    programs.neomutt = {
      enable = true;
      editor = "nvim";
      vimKeys = true;
      sidebar = {
        enable = true;
      };
      settings = {
        mail_check_stats = true;
      };
    };

    accounts.email.accounts.kinzokudev = {
      address = "kinzokudev4869@gmail.com";
      neomutt.enable = true;
      primary = true;
      flavor = "gmail.com";
      folders = {
        inbox = "Inbox";
        drafts = "Drafts";
        sent = "Sent";
        trash = "Trash";
      };
      realName = "Ayman Hamza";
      aliases = [];
    };
  };
}
