Statusbar for use with chunkwm. Screenshot:

![img](https://user-images.githubusercontent.com/6175959/35296227-b4c0d428-007b-11e8-804c-8a4244a547f2.png)

Pretty much copied from [japorized](https://github.com/japorized/dotfiles), although there was an issue with the Spotify script that I fixed.
There are also other very minor changes such as padding and color-changes.

The spotify widget relies on the shell-script [shpotify](https://github.com/hnarayanan/shpotify).
Place the spotify script into `/usr/local/bin/` using your preferred method,
or change the path in the `spotify.coffee` file.

FontAwesome must be installed system wide (Grab FontAwesome.otf from this repo and drop it into FontBook.app).
Clone repo and move the entire **widgets** folder into `~/Library/Application Support/Übersicht/`

Get Übersicht here http://tracesof.net/uebersicht/
