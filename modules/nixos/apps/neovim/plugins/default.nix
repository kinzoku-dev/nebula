{
  inputs,
  config,
  ...
}: let
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) palette;
  colors = palette;
in {
  imports = [
    ./lsp.nix
    ./nvim-cmp.nix
    ./none-ls.nix
    ./comments.nix
    ./conform-nvim.nix
    ./oil.nix
    ./alpha.nix
    ./telescope.nix
    ./cursorline.nix
    ./notify.nix
    ./git
    ./luasnip.nix
    ./rust.nix
    (import ./bufferline.nix {inherit colors;})
  ];
}
