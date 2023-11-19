import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Spotify from './widgets/spotify/Spotify.js';

const dispatch = ws => Utils.execAsync(`hyprctl dispatch workspace ${ws}`);

const Workspaces = () => Widget.EventBox({
    onScrollUp: () => dispatch('+1'),
    onScrollDown: () => dispatch('-1'),
    child: Widget.Box({
        children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
            setup: btn => btn.id = i,
            label: `${i}`,
            onClicked: () => dispatch(i),
        })),

        connections: [
            [Hyprland.active.workspace, (self) => {
                const arr = Array.from({ length: 10 }, (_, i) => i + 1);
                self.children = arr.map(i => Widget.Button({
                    onClicked: () => dispatch(`${i}`),
                    child: Widget.Label(`${Hyprland.active.workspace.id == i ? '' : i}`),
                    className: Hyprland.active.workspace.id == i ? 'bar-ws-active' : (Hyprland.getWorkspace(i)?.windows > 0 ? 'bar-ws txt' : 'bar-ws-empty'),
                }));
            }]],
    }),
})

const myBar = () => Widget.Window({
    name: 'bar',
    className: 'bar',
    anchor: ['top', 'left', 'right'],
    exclusive: true,
    child: Widget.CenterBox({
        class_name: 'bar-child',
        centerWidget: Workspaces(),
    }),
})

export default {
    style: `/home/kinzoku/.config/ags/style.css`,
    windows: [
        myBar(),
        Spotify(),
    ]
}
