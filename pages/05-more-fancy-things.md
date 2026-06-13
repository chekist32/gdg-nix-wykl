---
layout: section
---

## 05
# Więcej fajnych rzeczy z Nixem


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

# 🐳 Obrazy OCI bez Dockerfile
<div />

Nix może budować obrazy Docker **bez Dockerfile** i **bez Docker daemona**.

- **Reprodukowalny obraz** Ten sam kod = ten sam obraz. Żadnych niespodzianek z wersjami, zależności są przypięte z góry przez Nix.
- **Deterministyczny build** Cache nie zależy od kolejności komend - każda warstwa oparta na swoim hashu zawartości.

<div class="grid grid-cols-2 gap-4">

```nix [default.nix]
{
  pkgs ? import (fetchTarball { ... }) { },
}:
pkgs.dockerTools.buildLayeredImage {
  name = "cli-toolbox-nix";
  tag = "latest1";

  contents = with pkgs.pkgsMusl; [ htop busybox ];

  config = {
    Cmd = [ "sh" ];
  };
}
```

```dockerfile [Dockerfile]
FROM alpine:3.24.0
RUN apk add --no-cache busybox htop

CMD [ "sh" ]
```

</div>

---
layout: default
---

## Reprodukowalność - Dockerfile vs Nix

```bash {*|7-8|*}
docker build --no-cache -t cli-toolbox-docker:latest1 .
docker build --no-cache -t cli-toolbox-docker:latest2 .

docker inspect cli-toolbox-docker:latest1 --format='{{.Id}}'
docker inspect cli-toolbox-docker:latest2 --format='{{.Id}}'

sha256:3441c759b7b339fad25e3476f3f2222afdb959d80dfd73e3dcb1d2b9cc03452c
sha256:08e10d250c09b4d8e0754cd3562bfe027ec00cb8fb2abebdaf2b326e45871a6b
```

```bash {*|7-8|*}
nix-build ./default.nix && docker load < result
nix-build ./default1.nix && docker load < result

docker inspect cli-toolbox-nix:latest1 --format='{{.Id}}'
docker inspect cli-toolbox-nix:latest2 --format='{{.Id}}'

sha256:116b59e69ba5a6ad4a502e33521e253158e7f8eff0a2e43fe873313b26337dfb
sha256:116b59e69ba5a6ad4a502e33521e253158e7f8eff0a2e43fe873313b26337dfb
```
## Natomiast Nix potrafi budować większe obrazy

```bash
IMAGE                              ID             DISK USAGE   CONTENT SIZE
cli-toolbox-docker:latest1         2c02496c6998       14.7MB          4.3MB       
cli-toolbox-nix:latest1            116b59e69ba5       38.6MB         17.5MB
```