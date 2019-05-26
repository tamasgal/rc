command: "sh ./scripts/spotify.sh"

refreshFrequency: 10000

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='spotify'></div>
  """

style: """
  color: #66d9ef
  font: 12px Hack
  left: 14px
  bottom: 7px
  width:850px
  height: 16px
"""

cutWhiteSpace: (text) ->
  text.replace /^\s+|\s+$/g, ""

update: (output, domEl) ->

   values = output.split('@')
   artist = @cutWhiteSpace(values[0])
   song = @cutWhiteSpace(values[1])
   elapsed = values[2]
   total = values[3]
   status = @cutWhiteSpace(values[4])

   if artist.length >= 30
     artist = artist.substring(0,29)
     artist = @cutWhiteSpace(artist)
     song = song + "…"

   if song.length >= 30
     song = song.substring(0,29)
     song = @cutWhiteSpace(song)
     song = song + "…"

   elapsedValues = elapsed.split(':')
   elapsedSeconds = 60 * parseInt(elapsedValues[0]) + parseInt(elapsedValues[1])

   totalValues = total.split(':')
   totalSeconds = 60 * parseInt(totalValues[0]) + parseInt(totalValues[1])

   elapsed = elapsedSeconds / totalSeconds

   # Create mpdHtmlString
   mpdHtmlString = "<span class='icon switch'></span><span class='white'>  #{artist} - #{song}&nbsp</span>"

   emptySpace = (120 - artist.length - song.length - 3) / 2

   elapsedCounter = parseInt(elapsed * emptySpace)
   remainingCounter = emptySpace - elapsedCounter - 1



   mpdHtmlString += "<span>"
   i = 0
   while i <= elapsedCounter
     i += 1
     mpdHtmlString += " ● "

   mpdHtmlString += "</span>"
   mpdHtmlString += "<span class='grey'>"

   i = 0
   while i <= remainingCounter
     i += 1
     mpdHtmlString += " ● "

   mpdHtmlString += "</span>"


   mpdHtmlString += "<span class='sicon prev'>&nbsp&nbsp</span>" + " "

   if status == "playing."
      mpdHtmlString += "<span class='sicon pause'></span>" + " "
   else
      mpdHtmlString += "<span class='sicon play'></span>" + " "

   mpdHtmlString += "<span class='sicon next'></span>"


   $(domEl).find('.spotify').html(mpdHtmlString)

   $(".pause").on "click", => @run "/usr/local/bin/spotify pause"
   $(".play").on "click",  => @run "/usr/local/bin/spotify play"
   $(".next").on "click",  => @run "/usr/local/bin/spotify next"
   $(".prev").on "click",  => @run "/usr/local/bin/spotify prev"
