---
layout: section
---

## 03
# DevShell

---
layout: default
---

# Co daje devShell

- **Dokładne wersje** narzędzi, biblioteki systemowe i zmienne środowiskowe - w jednym pliku w repozytorium.*
- **Łatwość wdrożenia**: git clone -> nix-shell lub nix develop -> kompletne środowisko. Bez ręcznej instalacji.
- **Bez zaśmiecania** systemu globalnie. Projekty z konfliktującymi zależnościami żyją obok siebie.

````md magic-move [shell.nix]
```nix {*|2}
{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  # pakiety dostępne w shellu
  packages = [ ... ];
  
  # skrypt uruchamiany przy wejściu do shellu
  shellHook = '' ... ''; 
}
```
```nix {2-7|*}
{
  # nixpkgs przypięty do konkretnego commita 8c50...41c5
  # co gwarantuje te same wersje pakietów na każdej maszynie
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8c50a710ddca43d7a530fb805ad55bde8d0141c5.tar.gz";
    sha256 = "0am8xx09fx5yf2p0wb001v0jx1g5hrfb76h4r37xph378jgk7pcr";
  }) { },
}:
pkgs.mkShell {
  # pakiety dostępne w shellu
  packages = [ ... ];
  
  # skrypt uruchamiany przy wejściu do shellu
  shellHook = '' ... ''; 
}
```
````

<Annotation>
  * pełna reprodukowalność wymaga przypięcia nixpkgs przy pomocy <code>fetchTarball</code>, <code>fetchGit</code> lub użycia flaków (o tym dalej)
</Annotation>

---
layout: center
---

# devShell + direnv

<img src="../public/devshell_direnv.gif" class="w-full h-[90%] object-contain" />