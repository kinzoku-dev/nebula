import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';

const ActionButtons = () => Widget.CenterBox({
    className: 'action-buttons',
    children: [
        Widget.Button({
            className: 'pause-play-button',
            onClicked: () => Mpris.players[0]?.playPause(),
            child: Widget.Label(),
            connections: [[Mpris, self => {
                const player = Mpris.players[0];
                self.child.label = player ? (player.playBackStatus == "Playing" ? "" : "") : "";
                if (!player)
                    return;
            }]],
        }),
    ]
})

const SongInfo = () => Widget.Box({
    className: 'song-text-box',
    children: [
        Widget.Box({
            className: 'song-cover',
            hexpand: false,
            hpack: 'end',
            binds: [['css', Mpris.players[0], 'cover-path',
                path => `background-image: url("${path})`]]
        }),
        Widget.Box({
            children: [
                Widget.Label({
                    className: 'song-title',
                    truncate: 'end',
                    maxWidthChars: 24,
                    justification: 'left',
                }),
                Widget.Label({
                    className: 'song-artists',
                    truncate: 'end',
                    maxWidthChars: 24,
                    justification: 'left',
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
        children: [
            SongInfo(),
            ActionButtons(),
        ],
    })
})
