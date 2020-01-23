<template>
  <div class="base">
    <div
      class="bg"
      :style="{ 'background-image': 'url(' + (isBlurred() ? background.blurred : background.default) + ')' }"
    ></div>

    <transition name="fade">
      <router-view />
    </transition>
  </div>
</template>

<script>
import { background } from "../themer";

export default {
  name: "l-base",

  data() {
    return {
      background,
    };
  },
  methods: {
    isBlurred() {
      let name = this.$router.currentRoute.name;
      return name === "login" || name === "select";
    }
  }
};
</script>

<style lang="scss">
@import "../theme";

.bg {
  background-size: cover;
  position: fixed;
  left: 0;
  right: 0;

  display: block;
  width: 100vw;
  height: 100vh;

  z-index: -1;

  transition: background-image 200ms ease;

  color: $secondary-color;
}
</style>
