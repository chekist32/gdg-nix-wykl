---
layout: section
---

## 06
# Podsumowanie


---
layout: default
---

# Wady Nixa

- **Krzywa uczenia** - funkcyjny DSL zamiast YAML czy bash
- **Dokumentacja** - rozproszona, czasem nieaktualna
- **Mniej rozwinięty ekosystem** - w porównaniu do Docker, Ansible czy Terraform, gotowych rozwiązań jest znacznie mniej
- **Czas ewaluacji/budowania** - pierwsze pobranie nixpkgs, cache miss czy ewaluacja dużego configa potrafią trwać długo
- **Komunikaty błędów** - potrafią być kryptyczne, szczególnie dla początkujących
- **Słabsze wsparcie dla macOS i Windows** - na macOS część rzeczy wymaga dodatkowej konfiguracji, na Windows wymagany WSL2

---
layout: default
---

# Linki

<div />

**Na start**
- [nix.dev](https://nix.dev) - oficjalne przewodniki i tutorial języka
- [nixos-and-flakes.thiscute.world](https://nixos-and-flakes.thiscute.world) - nieoficjalna książka społecznościowa: NixOS, flaki i codzienne użytkowanie

**Narzędzia**
- [nix-installer](https://github.com/NixOS/nix-installer) - instalator
- [mynixos.com](https://mynixos.com/) / [search.nixos.org](https://search.nixos.org) - szukanie pakietów

**Ciekawe powiązane projekty**
- [home-manager](https://github.com/nix-community/home-manager) - deklaratywne zarządzanie dotfiles i konfiguracją użytkownika
- [nix-darwin](https://github.com/LnL7/nix-darwin) - deklaratywna konfiguracja systemu dla macOS
- [devbox](https://www.jetify.com/devbox) - devShell bez potrzeby znajomości języka Nix - interfejs podobny do npm/pip
- [devenv.sh](https://devenv.sh) - devShell z gotowymi integracjami dla popularnych języków


---
layout: end
---

# Dziękuję!

<div class="flex items-center gap-2 mt-4">
  <img src="../public/GitHub-Mark.png" class="w-8 h-8 invert" />
  <a href="https://github.com/chekist32">github.com/chekist32</a>
</div>

<div class="flex items-center gap-2 mt-4">
  <span class="text-2xl">✉️</span>
  <a href="mailto:vladkra@proton.me">vladkra@proton.me</a>
</div>