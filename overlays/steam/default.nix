_: (final: prev: {
  steam = prev.steam.override (
    {extraLibraries ? pkgs': [], ...}: {
      extraLibraries = pkgs': (extraLibraries pkgs') ++ [pkgs'.gperftools];
    }
  );
})
