---
layout: section
---
## 02
# Czym jest Nix?

---
layout: default
---

Nix to **funkcyjny menedżer pakietów**.

- Pakiet = **czysta funkcja** swoich wejść: źródło + zależności + kroki budowania.<br>Te same wejścia -> ten sam wynik.
- Wszystko ląduje w ``/nix/store`` pod ścieżką z hashem -> wiele wersji obok siebie, zero konfliktów.
- **Deklaratywność**: opisujesz co chcesz mieć, nie jak to ręcznie zbudować.

```nix {*|1|2-10|3-4|6-9|*} [package.nix] 
{ stdenv, fetchurl }:
stdenv.mkDerivation (finalAttrs: {
  pname = "hello";
  version = "2.12";

  src = fetchurl {
    url = "https://ftp.gnu.org/gnu/hello/hello-${finalAttrs.version}.tar.gz";
    sha256 = "1ayhp9v4m4rdhjmnl2bq3cibrbqqkgjbl3s7yk2nhlh8vj3ay16g";
  };
})
```

---
layout: default
---

# Modularność pakietów

<div />

W przeciwieństwie do apt czy brew - w Nix możesz **dostosować dowolny pakiet** bez forkowania repozytorium.

````md magic-move
```nix
# podmienia zależność (np. inna wersja JDK dla Mavena)
pkgs.maven.override {
  jdk_headless = pkgs.jdk11_headless;
}
```
```nix
# zmienia atrybuty/fazy budowania
pkgs.hello.overrideAttrs (old: {
  version = "2.10";
  src = pkgs.fetchurl {
    url = "https://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz";
    sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
  };
})
```
````

- **`override`** - podmienia zależności pakietu
- **`overrideAttrs`** - nadpisuje wersję, źródła, patche, flagi, fazy builda, itp.

---
layout: default
---

# ...nie tylko menedżer pakietów

- **Język Nix** - funkcyjny, dynamicznie typizowany DSL [nix.dev](https://nix.dev/tutorials/nix-language)
- **Nixpkgs** - ponad 100k pakietów [search.nixos.org](https://search.nixos.org)
- **NixOS** - dystrybucja Linuksa zbudowana wokół Nixa [nixos.org](https://nixos.org) 
