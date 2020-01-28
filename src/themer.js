import { settings } from './settings';

export const DEFAULT_COLOR = '#657285';

const wall_dir = './assets/images/wallpapers';
const require_wallpaper = wallpaper => ({
    default: require(`${wall_dir}/${wallpaper}`),
    blurred: require(`${wall_dir}/blurred/${wallpaper}`)
});

const DEFAULT_NAMES = [
    'background.png',
    '1532564867739.png', '1579652499063.jpg',
    'EJ2tvsICil0.jpg', '1532575538303.jpg',
    'Solid_Aqua_Graphite.png'
];

const DEFAULT_WALLPAPERS = DEFAULT_NAMES.map(require_wallpaper);

const unique_objects = _ =>
    _.map(JSON.stringify)
        .filter((e, i, self) => self.indexOf(e) === i)
        .map(JSON.parse);

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
    localStorage.setItem('background', bg.default);
    localStorage.setItem('background_blurred', bg.blurred);
}

export function backgrounds() {
    const dirlist = dir => {
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

    let result = dirlist(greeter_config.branding.background_images);
    return unique_objects([
        ...DEFAULT_WALLPAPERS,
        ...result
    ]);
}

function getBackground() {
    if(settings.randomizeBG) {
        const bgs = backgrounds(blurred);
        return bgs[Math.floor(Math.random() * bgs.length)];
    }

    if (!localStorage.getItem('background'))
        return DEFAULT_WALLPAPERS[0];
    return {
        default: localStorage.getItem('background'),
        blurred: localStorage.getItem('background_blurred')
    }
}
