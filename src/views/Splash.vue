<template>
    <div id="splash"
        :class="{ 'clock-only': clockOnly }"
        :style="{ 'background-image': 'url(' + current_background.default + ')' }">
        <Clock />
        <div v-if="!clockOnly" id="trigger">{{ trigger }}</div>
    </div>
</template>

<script>
import Clock from "@/components/Clock.vue";
import { trans } from "@/translations";
import { settings } from "@/settings";
import { background } from '../themer';

export default {
    name: "splash",
    components: { Clock },
    mounted() {
        window.addEventListener("keyup", this.submit_key);
        window.document.getElementById('splash')
            .addEventListener("click", this.submit);
    },
    data() {
        return {
            trigger: trans("trigger"),
            current_background: background,
            clockOnly: settings.disableSplashText
        };
    },
    methods: {
        submit() {
            if (this.$route.path !== "/base/login")
                this.$router.push("/base/login");
        },
        submit_key(event) {
            if (event.which === 13 || event.which === 32)
                this.submit();
        }
    }
};
</script>

<style lang="scss" scoped>
#splash {
    width: 100vw;
    height: 100vh;
    background-size: cover;
    cursor: none;
    display: flex;
    justify-content: space-between;
    flex-direction: column;
}

#splash:not(.clock-only) .clock {
    margin-top: 6vh;
}

#splash.clock-only {
    align-items: center;
    justify-content: center;
    flex-direction: initial;
    .clock {
        padding-bottom: 25px;
        /* Text size compensation */
    }
}

#trigger {
    font-family: "Alte Haas Grotesk";
    font-weight: 400;
    font-size: 16px;
    cursor: default;
    margin-bottom: 11.5vh;
    letter-spacing: 0.25px;
}
</style>
