command: "ps axro \"pid, %cpu, ucomm\" | awk 'FNR>1' | head -n 3 | awk '{ printf \"%5.1f%%,%s,%s\\n\", $2, $3, $1}' 2>/dev/null"

refreshFrequency: 3000

style: """
  bottom: 2px
  left: 5px
  color: #fff
  font-family: Helvetica Neue

  table
    border-collapse: collapse
    table-layout: fixed

  &:after
    content: 'cpu'
    position: absolute
    right: 0
    top: -14px
    font-size: 10px

  td
    border: 1px solid #fff
    font-size: 24px
    font-weight: 100
    width: 100px
    max-width: 100px
    overflow: ellipsis
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative

  .col1, .col3
    background: rgba(#fff, 0.1)

  p
    padding: 0
    margin: 0
    font-size: 11px
    font-weight: normal
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis
    text-shadow: none

  .pid
    position: absolute
    top: 2px
    right: 2px
    font-size: 10px
    font-weight: normal

"""


render: -> """
  <table>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "#{cpu}<p>#{name}</p>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)
