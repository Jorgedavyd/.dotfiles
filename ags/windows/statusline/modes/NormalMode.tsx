import Hyprland from 'gi://AstalHyprland'
import Mpris from 'gi://AstalMpris'
import { Gtk } from 'astal/gtk3'
import { bind } from 'astal'

const hyprland = Hyprland.get_default()
const spotify = Mpris.Player.new('spotify')

export default function NormalMode() {
  return (
    <box
      name='normal'
      className='normal'
      spacing={8}
      hexpand={true}>
      <stack
        className='window_state'
        transitionType={Gtk.StackTransitionType.OVER_RIGHT_LEFT}
        transitionDuration={ANIMATION_SPEED}
        setup={(self) => {
          self.hook(hyprland, 'event', () => {
            const focusedClient = hyprland.get_focused_client()
            if (!focusedClient) {
              self.set_shown('tiling')
              return
            }

            self.set_shown(
              !focusedClient.get_floating()
                ? 'tiling' : 'floating'
            )
          })
        }}>

        <label
          name='tiling'
          className='tiling'
          label='TILING'
        />

        <label
          name='floating'
          className='floating'
          label='FLOATING'
        />
      </stack>

      <label
        className='active_window'
        setup={(self) => {
          self.hook(hyprland, 'event', () => {
            const focusedClient = hyprland.get_focused_client()

            self.set_label(
              focusedClient
                ? focusedClient.get_class()
                : '~'
            )
          })
        }}
      />

      {bind(spotify, 'available').as(musicAvailable =>
        !musicAvailable
          ? (
              <label
                className='music_indicator'
                label='󰝛 No Music - Title'
              />
            )
          : (
              <label
                className='music_indicator'
                label={
                  bind(spotify, 'title')
                    .as(title => `󰝚 Playing - ${title}`)
                }
              />
            )
      )}
    </box>
  )
}
