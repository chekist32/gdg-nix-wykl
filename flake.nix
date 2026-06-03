{
  description = "Basic dev shell template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
      ];
      
      pow = a: x: x^a

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
      genAttrs => {"x86_64-linux" = (system: (system: ...) system) }
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = import ./shell.nix { inherit pkgs; };
        }
      );
    };
}
