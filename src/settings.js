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
  roundAvatar: false,
  disableAvatar: false,
  disableZoom: false,
  clock12: false,
  randomizeBG: false,

  user: lightdm.users[0],
  desktop: lightdm.sessions[0]
};

// Handle display name change
lightdm.users.forEach(
  u => settings.user.username === u.username && (settings.user = u)
);
lightdm.sessions.forEach(
  s => settings.desktop.username === s.key && (settings.desktop = s)
);

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

  if (avi === "eh8") {
    return require("./assets/images/eh8.png");
  }

  if (avi === "litarvan") {
    return require("./assets/images/litarvan.png");
  }

  return avi;
}
