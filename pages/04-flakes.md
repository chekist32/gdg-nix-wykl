---
layout: section
---

## 04
# Flakes

---
layout: default
---

Flakes to <span class="text-yellow-400 font-bold">⚠️ eksperymentalny feature</span>\* w upstream implementacji Nixa (CppNix), 
który **standaryzuje dystrybucję** kodu Nix
i **gwarantuje reprodukowalność** dzięki `flake.lock`.

Struktura:
- **inputs** - zależności (inne flaki, np. `nixpkgs`, `home-manager`)
- **outputs** - `devShells`, `packages`, `nixosConfigurations`, ...

<Annotation>
  * de facto standard, choć potencjalne <em>breaking changes</em> w API są możliwe
</Annotation>

---
layout: default
---

````md magic-move
```nix {*|4-6|16-22|*}
{ # flake.nix
  description = "Nix devShell demo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [ nodejs curl jq ];
          };
        });
    };
}
```

```json {*|5-10|*}
{ // flake.lock
  "nodes": {
    "nixpkgs": {
      "locked": {
        "lastModified": 1780243769,
        "narHash": "sha256-x5UQuRsH3MqI0U9afaXSNqzTPSeZlRLvFAav2Ux1pNw=",
        "owner": "NixOS",
        "repo": "nixpkgs",
        "rev": "331800de5053fcebacf6813adb5db9c9dca22a0c",
        "type": "github"
      },
      ...
  },
  ...
}
```
````
<v-click>

To samo co `package-lock.json` czy `Cargo.lock` - przypina wersje wszystkich zależności.

</v-click>

