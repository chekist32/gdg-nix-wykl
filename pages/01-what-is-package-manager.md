---
layout: section
---
## 01
# Czym są menedżery pakietów?

---
layout: center
---

<img src="../public/package-managers-non-nix.svg" class="w-full h-[90%] object-contain" />

<span v-click>**brew** *(OS Level)* *instaluje Node.js i npm*</span>
<span v-after> -> </span>
<span v-click>**npm** *(Lang Level)* *instaluje zależności, buduje aplikację*</span>
<span v-after> -> </span>
<span v-click>**Docker** *(Deployment)* *tworzy kontener, uruchamia na serwerze*</span>

---
layout: default
---

<img src="../public/package-managers-nix.svg" class="w-full h-[90%] object-contain" />

<span v-click>**Nix** *(OS Level)* *instaluje Node.js i npm*</span>
<span v-after> -> </span>
<span v-click>**npm** *(Lang Level)* *instaluje zależności, buduje aplikację*</span>
<span v-after> -> </span>
<span v-click>**Nix** *(Deployment)* *buduje obraz/pakiet, uruchamia na serwerze*</span>