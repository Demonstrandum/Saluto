<template>
    <div
        class="simple-keyboard"
        id="simple-keyboard"
    ></div>
</template>

<script>

import Keyboard from "simple-keyboard";
import "simple-keyboard/build/css/index.css";

export default {
    name: "onboard-keyboard",
    props: {
        input: {
            type: String
        },
        visibility: {
            type: Function
        }
    },
    data: () => ({
        keyboard: null,
        listenerID: null
    }),
    mounted() {
        this.keyboard = new Keyboard({
            onChange: this.onChange,
            onKeyPress: this.onKeyPress
        });
        clearInterval(this.listenerID);
        this.listenerID = setInterval(() => {
            let classList = null;
            try {
                classList = document.getElementById('simple-keyboard').classList;
            } catch {}

            if (classList !== null
            && !classList.contains('visible')
            && this.visibility())
                classList.add('visible');
        }, 10);
    },
    methods: {
        onChange(input) {
            this.$emit("onChange", input);
        },
        onKeyPress(button) {
            this.$emit("onKeyPress", button);
            if (button === "{shift}" || button === "{lock}") this.handleShift();
        },
        handleShift() {
            let currentLayout = this.keyboard.options.layoutName;
            let shiftToggle = currentLayout === "default" ? "shift" : "default";

            this.keyboard.setOptions({
                layoutName: shiftToggle
            });
        }
    },
    watch: {
        input(input) {
            this.keyboard.setInput(input);
        }
    }
};
</script>

<style lang="scss">
$keyboard-width: 50vw;

.simple-keyboard {
    position: absolute;
    bottom: 12vh;
    color: #222;
    background-color: rgba(0,0,0,0.2);
    backdrop-filter: blur(20px) saturate(200%);
    width: $keyboard-width;
    left: calc((100vw - #{$keyboard-width}) / 2);
    visibility: hidden;
}
</style>
