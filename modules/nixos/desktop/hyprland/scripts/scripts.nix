{ ...}: {
  # volume = pkgs.writeShellApplication {
  #   name = "volume";
  #   runtimeInputs = with pkgs; [pamixer dunst];
  #   text = ''
  #     icon_dir="${./.}/icons"
  #
  #     get_volume() {
  #         volume=$(pamixer --get-volume)
  #         echo "$volume"
  #     }
  #
  #     get_icon() {
  #         vol="$(get_volume)"
  #         current="''${vol%%%}"
  #         case $current in
  #           -eq "0")
  #               icon=''${icon_dir}'audio-volume-muted-symbolic.svg'
  #               ;;
  #     }
  #   '';
  # };
}
