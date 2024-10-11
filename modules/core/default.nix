{
  hostname,
  isServer,
  ...
}: {
  imports =
    if isServer
    then [
      ./boot
      ./other
      ./packages
      ./services
      ./tui
    ]
    else [
      ./boot
      ./gui
      ./other
      ./packages
      ./services
      ./tui
    ];
}
