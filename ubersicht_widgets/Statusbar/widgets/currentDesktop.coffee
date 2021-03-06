command: "echo $(x=$(/usr/local/bin/chunkc tiling::query -d id);echo $(/usr/local/bin/chunkc tiling::query -D $(/usr/local/bin/chunkc tiling::query -m id))\",$x\")"

refreshFrequency: 600

render: (output) ->
  values = output.split(',')
  spaces = values[0].split(' ')

  htmlString = """
    <div class="currentDesktop-container" data-count="#{spaces.length}">
      <ul>
  """

  for i in [0..spaces.length - 1]
    icon = ""
    switch spaces[i]
        when '1' then text = "hme"
        when '2' then text = "web"
        when '3' then text = "dev"
        when '4' then text = "doc"
        when '5' then text = "img"
        when '6' then text = "mmd"
        when '7' then text = "cmm"
        when '8' then text = "phd"
        when '9' then text = "foo"
        else text = "narf"
    htmlString += "<li id=\"desktop#{spaces[i]}\">#{spaces[i]}-#{text}</li>"

  htmlString += """
      <ul>
    </div>
  """

style: """
  position: relative
  margin-top: 9px
  font: 11px "Fira Code", "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif
  color: #aaa
  font-weight: 700

  ul
    list-style: none
    margin: 0 0 0 6px
    padding: 0

  li
    display: inline
    margin: 0 10px

    img
      max-height: 20px
      max-width: 20px

  li.active
    color: #ededed
    border-bottom: 3px solid red
"""

update: (output, domEl) ->
  values = output.split(',')
  spaces = values[0].split(' ')
  space = values[1]

  htmlString = ""
  for i in [0..spaces.length - 1]
    icon = ""
    switch spaces[i]
        when '1' then text = "hme"
        when '2' then text = "web"
        when '3' then text = "dev"
        when '4' then text = "doc"
        when '5' then text = "img"
        when '6' then text = "mmd"
        when '7' then text = "cmm"
        when '8' then text = "phd"
        when '9' then text = "foo"
        else text = "narf"
    htmlString += "<li id=\"desktop#{spaces[i]}\">#{spaces[i]}-#{text}</li>"

  if ($(domEl).find('.currentDesktop-container').attr('data-count') != spaces.length.toString())
     $(domEl).find('.currentDesktop-container').attr('data-count', "#{spaces.length}")
     $(domEl).find('ul').html(htmlString)
     $(domEl).find("li#desktop#{space}").addClass('active')
  else
    $(domEl).find('li.active').removeClass('active')
    $(domEl).find("li#desktop#{space}").addClass('active')
