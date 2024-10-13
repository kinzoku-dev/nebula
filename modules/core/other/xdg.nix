{ lib, ... }:
{
  xdg.portal = {
    enable = true;
    wlr = lib.mkForce { enable = false; };
  };
}
