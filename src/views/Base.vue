<template>
  <div class="base">
    <div
      class="bg"
      :class="{ blurred: isBlurred() }"
      :style="{ 'background-image': 'url(' + this.current_background + ')' }"
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
      current_background: background.default,
    };
  },
  methods: {
    isBlurred() {
      let name = this.$router.currentRoute.name;
      let blur_now = name === "login" || name === "select";
      if (blur_now)
        this.current_background = background.blurred;
      else
        this.current_background = background.default;

      return blur_now;
    },
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
