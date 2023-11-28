import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';

const ActionButtons = () => Widget.CenterBox({
    className: 'action-buttons',
    vpack: 'end',
    vexpand: true,
    startWidget: Widget.Label({
        label: 'a',
    }),
    centerWidget: Widget.Box({
        className: 'controls',
        children: [
            Widget.Button({
                className: 'shuffle-button',
                onClicked: () => Mpris.players[0]?.shuffle(),
                child: Widget.Label({
                    label: ' ',
                })
            }),
            Widget.Button({
                className: 'prev-button',
                onClicked: () => Mpris.players[0]?.previous(),
                child: Widget.Label({
                    label: '',
                }),
            }),
            Widget.Button({
                className: 'pause-play-button', onClicked: () => Mpris.players[0]?.playPause(),
                child: Widget.Label(),
                connections: [[Mpris, self => {
                    const player = Mpris.players[0];
                    self.child.label = player ? (player.playBackStatus == "Playing" ? "" : "") : "";
                    if (!player)
                        return;
                }]],
            }),
            Widget.Button({
                className: 'next-button',
                onClicked: () => Mpris.players[0]?.next(),
                child: Widget.Label({
                    label: '',
                }),
            }),
            Widget.Button({
                className: 'loop-button',
                onClicked: () => Mpris.players[0]?.loop(),
                child: Widget.Label({
                    label: ' ',
                })
            })
        ],
    }),
    endWidget: Widget.Label({
        label: 'b',
    }),
})

const SongInfo = () => Widget.Box({
    className: 'song-text-box',
    children: [
        Widget.Box({
            className: 'song-cover',
            hexpand: false,
            hpack: 'end',
            connections: [[Mpris, box => {
                const url = Mpris.players[0]?.cover_path;
                if (!url) 
                    return;

                box.setCss(`background-image: url("${url}")`)
            }]]
        }),
        Widget.Box({
            children: [
                Widget.Label({
                    className: 'song-title txt',
                    truncate: 'end',
                    maxWidthChars: 24,
                    justification: 'left',
                    xalign: 0,
                }),
                Widget.Label({
                    className: 'song-artists txt',
                    truncate: 'end',
                    maxWidthChars: 24,
                    justification: 'left',
                    xalign: 0,
                })
            ],
            className: 'song-info',
            visible: false,
            vertical: true,
            hexpand: true,
            connections: [[Mpris, self => {
                const player = Mpris.players[0];
                self.visible = player;
                if (!player)
                    return;

                const { trackTitle, trackArtists } = player;
                self.children[0].label = `${trackTitle}`;
                self.children[1].label = `${trackArtists.join(', ')}`;
            }]],
        }),
    ],
})

export default () => Widget.Window({
    name: 'spotify',
    className: 'spotify',
    anchor: ['top', 'right'],
    child: Widget.Box({
        className: 'spotify-child',
        vertical: true,
        hexpand: true,
        vexpand: true,
        children: [
            SongInfo(),
            ActionButtons(),
        ],
    })
})
