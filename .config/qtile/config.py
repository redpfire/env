# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

from typing import List  # noqa: F401

mod = "mod4"

keys = [

    # spawn the terminal
    Key([mod], "Return", lazy.spawn('xst')),

    # Move focus in current stack pane
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),

    # Move windows in current stack
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # Expand window / increase number in master pane (Tile)
    Key([mod], "h", lazy.layout.grow(), lazy.layout.increase_nmaster()),
    Key([mod], "l", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),

    # Normalize window size ratios
    Key([mod], "n", lazy.layout.normalize()),

    # Switch which side main pane occupies
    Key([mod, "shift"], "space", lazy.layout.rotate(), lazy.layout.flip()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Key([mod], "k", lazy.screen.next_group()),
    # Key([mod], "j", lazy.screen.prev_group()),

    # Open prompt
    Key([mod], "r", lazy.spawncmd()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),

    Key([mod], "q", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),

    Key([mod, "control"], "m", lazy.spawn("udevil_mu")),
    Key([mod, "control"], "u", lazy.spawn("udevil_mu -u")),

    Key([], "Print", lazy.spawn("scr")),
    Key(['control'], "Print", lazy.spawn("scr -s")),
]

group_names = [("www", {'layout': 'max'}),
               ("term", {'layout': 'monadtall'}),
               ("disc", {'layout': 'max'}),
               ("misc", {'layout': 'monadtall'}),
               ("misc2", {'layout': 'monadtall'}),
               ("gfx", {'layout': 'floating'}),
               ("obs", {'layout': 'max'})]

group_keys = ['a', 's', 'd', 'f', 'i', 'o', 'p']

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names):
    keys.append(Key([mod], group_keys[i], lazy.group[name].toscreen()))
    keys.append(Key([mod, "shift"], group_keys[i], lazy.window.togroup(name)))

layout_theme = {
                "border_width": 1,
                # "margin": 6,
                "border_focus": "#606060"
               }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
    layout.Floating(**layout_theme),
]

widget_defaults = dict(
    font='Iosevka Custom',
    fontsize=10,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(highlight_method='text', urgent_alert_method='text', active='#909090', foreground='#ffffff', this_current_screen_border='#ffffff'),
                widget.Sep(linewidth = 0,padding = 10),
                widget.Prompt(),
                widget.WindowName(),
                widget.Notify(default_timeout=5),
                widget.Volume(channel="Speaker",emoji=True,fontsize=12),
                widget.Sep(linewidth = 0,padding = 5),
                widget.TextBox(text='📡', fontsize=12),
                widget.Wlan(format='{essid}', disconnected_message='✖️ ',
                    interface='wlp1s0', update_interval=3,
                    foreground='ffffff'),
                widget.Sep(linewidth = 0,padding = 5),
                widget.TextBox(text='🔋', fontsize=12),
                widget.Battery(format='{percent:2.0%}{char}', update_interval=5,
                    charge_char='⚡', discharge_char=''),
                widget.Sep(linewidth = 0,padding = 5),
                widget.Clock(format='%a %m/%d %H:%M'),
                widget.Sep(linewidth = 0,padding = 5),
                widget.Systray(),
                widget.Sep(linewidth = 0,padding = 5),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wname': 'Discord Updater'},
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
