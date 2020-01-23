import { settings } from './settings';

export const DEFAULT_COLOR = '#657285';
const DEFAULT_BG = {
    default: require('./assets/images/wallpapers/background.png'),
    blurred: require('./assets/images/wallpapers/blurred/background.png')
};

export let color = localStorage.getItem('color') || DEFAULT_COLOR;
export let background = getBackground();

export function hook(element, rules) {
    const style = element.style;

    for (const rule of rules) {
        style[rule] = color;
    }
}

export function updateColor(hex) {
    color = hex;
    localStorage.setItem('color', color);
}

export function updateBG(bg) {
    background = bg;
    console.log('SETTING BACKGROUNDS TO:');
    console.log(bg.default);
    console.log(bg.blurred);
    localStorage.setItem('background', bg.default);
    localStorage.setItem('background_blurred', bg.blurred);
}

export function backgrounds() {
    const recDirlist = dir => {
        let files = [];
        for (const file of theme_utils.dirlist(dir)) {
            if (file.includes('.')) { // Really awful way of checking if it's a file...
                let path = file.split('/');
                let basename = path[path.length - 1];
                let dirname = path.slice(0, -1).join('/');

                files.push({
                    default: 'file://' + file,
                    blurred: 'file://' + dirname + '/blurred/' + basename
                });
            }
        }

        return files;
    };

    let result = recDirlist(greeter_config.branding.background_images);

    return [DEFAULT_BG, ...result];
}

function getBackground() {
    if(settings.randomizeBG) {
        const bgs = backgrounds(blurred);
        return bgs[Math.floor(Math.random() * bgs.length)];
    }

    let bg;
    if (!localStorage.getItem('background'))
        bg = DEFAULT_BG;
    else
        bg = {
            default: localStorage.getItem('background'),
            blurred: localStorage.getItem('background_blurred')
        }
    console.log('GOT CACHED BACKGROUNDS AS:');
    console.log(bg.default);
    console.log(bg.blurred);
    return bg;
}
