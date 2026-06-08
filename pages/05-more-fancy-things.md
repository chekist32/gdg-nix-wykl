---
layout: section
---

## 05
# Więcej fajnych rzeczy z Nixem


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

  contents = with pkgs; [ htop bash busybox ];

  config = {
    Cmd = [ "sh" ];
  };
}
```

```dockerfile [Dockerfile]
FROM alpine:latest
RUN apk add --no-cache bash busybox htop

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

sha256:6e2b19dff7c6546406d789abb9f908e64b48f38287b1a110b05ed849efcb8b24
sha256:b013d6225049f1f6aa084398ba112a67330ad545126f69fd541c50bb15d98f37
```

```bash {*|7-8|*}
nix-build ./default.nix && docker load < result
nix-build ./default1.nix && docker load < result

docker inspect cli-toolbox-nix:latest1 --format='{{.Id}}'
docker inspect cli-toolbox-nix:latest2 --format='{{.Id}}'

sha256:c4376656fb6f9285f6c98c87f4b1236a1d2d8d297e7baee7b377a512900103e0
sha256:c4376656fb6f9285f6c98c87f4b1236a1d2d8d297e7baee7b377a512900103e0
```
## Natomiast Nix buduje większe obrazy

```bash
IMAGE                              ID             DISK USAGE   CONTENT SIZE
cli-toolbox-docker:latest1         6e2b19dff7c6       16.7MB         4.82MB
cli-toolbox-nix:latest1            c4376656fb6f        127MB         60.3MB
```