{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    git
    nodejs_22
    pnpm
  ];
}