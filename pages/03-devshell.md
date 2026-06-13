---
layout: section
---

## 03
# DevShell


---
layout: default
---
 
# README Hell
 
<div />

[MANUAL_INSTALL.md](https://github.com/openstreetmap/openstreetmap-website/blob/master/doc/MANUAL_INSTALL.md)

```bash [MANUAL_INSTALL.md](https://github.com/openstreetmap/openstreetmap-website/blob/master/doc/MANUAL_INSTALL.md)
# Ubuntu
sudo apt-get install ruby ruby-dev ruby-bundler \
  libvips-dev libxml2-dev libxslt1-dev nodejs build-essential git-core \
  postgresql postgresql-contrib postgresql-postgis libpq-dev \
  libsasl2-dev libffi-dev libgd-dev libarchive-dev libyaml-dev libbz2-dev npm
 
# Fedora
sudo dnf install ruby ruby-devel rubygem-rdoc rubygem-bundler \
  rubygems libxml2-devel nodejs gcc gcc-c++ git \
  postgresql postgresql-server postgresql-contrib postgis libpq-devel \
  perl-podlators libffi-devel gd-devel libarchive-devel libyaml-devel bzip2-devel \
  nodejs-yarn vips-devel
 
# macOS
brew install ruby libxml2 gd yarn pngcrush optipng \
  pngquant jhead jpegoptim gifsicle svgo \
  advancecomp vips
```


---
layout: default
---
 
# Docker/devcontainers
 
<div />

Docker i devcontainers to **dobra odpowiedź** na ten problem.

- **Szeroki znany ekosystem** - dużo gotowych obrazów bazowych, ogromna społeczność
- **Devcontainers UX** - VS Code plugin automatycznie konfiguruje środowisko z `devcontainer.json`
- **Izolowane środowisko** - pakiety i narzędzia nie zaśmiecają systemu hosta

Ale są pewne kompromisy:

- <span class="text-yellow-400 font-bold">Overhead virtualizacji</span> - szczególnie I/O na bind mountach (macOS, Windows)
- <span class="text-yellow-400 font-bold">Środowisko kontenera != host</span> - debugowanie, GUI, integracja z IDE*
- <span class="text-yellow-400 font-bold">Dockerfile != reprodukowalność</span> - obraz zbudowany dziś i za miesiąc może zachowywać się inaczej

<Annotation>
  * devcontainers częściowo rozwiązują ten problem
</Annotation>

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