let local = localStorage.getItem("settings");

if (local === "undefined") {
    local = null;
}

export let settings = local ? JSON.parse(local) : {
    first: true,

    mode: "classic",

    disableSplash: false,
    disableSplashText: false,
    disableIntro: false,
    disableFade: false,
    roundAvatar: true,
    disableAvatar: false,
    disableZoom: false,
    clock12: false,
    randomizeBG: false,

    hostname: lightdm.hostname,
    user: lightdm.users[0],
    desktop: lightdm.sessions[0]
};

// Handle display name/avatar/hostname change.
if (lightdm.hostname !== settings.hostname)
    settings.hostname = lightdm.hostname;

lightdm.users.forEach(u => {
    if (settings.user.username === u.username)
        settings.user = u;
});

lightdm.sessions.forEach(s => {
    if (settings.desktop.username === s.key)
        settings.desktop = s;
});

save();

export function save(s) {
    localStorage.setItem(
        "settings",
        JSON.stringify(s ? (settings = s) : settings)
    );
}

export function avatar(avi) {
    if (!avi || avi === "") {
        return require("./assets/images/eh8.png");
    }

    if (avi === "cicero") {
        return require("./assets/images/cicero.png")
    }

    if (avi === "eh8") {
        return require("./assets/images/eh8.png");
    }

    if (avi === "litarvan") {
        return require("./assets/images/litarvan.png");
    }

    return avi;
}
