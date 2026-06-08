<template>
  <div class="annotation">
    <slot />
  </div>
</template>

<style scoped>
.annotation {
  position: absolute;
  bottom: 1rem;
  left: 2rem;
  font-size: 0.75rem;
  color: #9ca3af;
}
</style>