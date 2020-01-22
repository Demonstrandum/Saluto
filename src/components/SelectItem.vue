<template>
  <div
    class="item"
    :class="{ 'user': mode === 'user', 'desktop': mode === 'desktop', 'selected': selected }"
    v-theming="['border-bottom-color']"
    @click="select()"
  >
    <div class="icon-container" v-if="!noicon">
      <img class="icon" :src="icon()" />
    </div>
    {{ mode === 'user' ? item.display_name : item.name }}
    <span v-if="mode === 'user'">
      /
      <span class="username">{{ item.username }}</span>
    </span>
  </div>
</template>

<script>
import { avatar } from "@/settings";

export default {
  name: "select-item",
  props: ["mode", "item", "selected", "noicon"],

  methods: {
    select() {
      this.$emit("select");
    },
    icon() {
      if (this.mode === "user") {
        return avatar(this.item.image);
      }

      if (this.mode === "desktop") {
        let key = this.item.key.toLowerCase();
        let icon = "unknown";

        if (key.indexOf("plasma") > -1 || key.indexOf("kde") > -1) {
          icon = "kde";
        }
        else if (key.indexOf("gnome") > -1) {
          icon = "gnome";
        }
        else if (key.indexOf("xfce") > -1) {
          icon = "xfce";
        }
        else if (key.indexOf("unity") > -1 || key.indexOf("ubuntu") > -1) {
          icon = "ubuntu";
        }
        else if (key.indexOf("dde") > -1 || key.indexOf("deepin") > -1) {
          icon = "deepin";
        }
        else if (key.indexOf("lxde") > -1 || key.indexOf("lxqt") > -1) {
          icon = "lxde";
        }
        else if (key.indexOf("pantheon") > -1 || key.indexOf("elementary") > -1) {
          icon = "elementary";
        }
        else if (key.indexOf("mate") > -1) {
          icon = "mate";
        }
        else if (key.indexOf("cinnamon") > -1 || key.indexOf("mint") > -1) {
          icon = "cinnamon";
        }
        else if (
          key.indexOf("enlightenment") > -1 ||
          (key.length === 3 && /e[1-9]{2}/g.test(key))
        ) {
          icon = "enlightenment";
        }
        else if (key.indexOf("liri") > -1) {
          icon = "liri";
        }
        else if (key.indexOf("i3") > -1) {
          icon = "i3";
        }
        else if (key.indexOf("xmonad") > -1) {
          icon = "xmonad";
        }
        else if (key.indexOf("budgie") > -1 || key.indexOf("solus") > -1) {
          icon = "budgie";
        }

        return require("../assets/images/desktops/" + icon + ".png");
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.item {
  font-family: "Inter";

  border-radius: 5px;
  transition: background-color 125ms ease-in-out;

  min-width: 150px;
}

.item.selected {
  border-bottom: solid 2px;
  background: rgba(255, 255, 255, 0.055);
}

.item:hover {
  cursor: pointer;
  background: rgba(255, 255, 255, 0.115);
}

.item.desktop {
  font-weight: 400;
  font-size: 16px;
  padding: 7px 19px;
  margin-bottom: 20px;
}

.item.user {
  font-weight: 400;
  font-size: 16px;
  padding: 3px 18px 8px;
  margin-bottom: 25px;
}

.username {
  font-weight: bold;
}

.icon-container {
  display: inline-block;

  width: 45px;
  height: 45px;

  margin-right: 6px;
}

.item.user .icon-container {
  margin-right: 8px;
}

.icon {
  height: 45px;
  margin-bottom: -6px;
}

.item.user .icon {
  margin-bottom: -8px;
}

@media (max-height: 850px) {
  .item.user {
    font-size: 16px;
  }

  .item.desktop {
    font-size: 16px;
  }

  .icon {
    margin-bottom: -5px;
  }
}
</style>
