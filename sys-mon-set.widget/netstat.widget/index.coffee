command: "sys-mon-set.widget/netstat.widget/scripts/netst"

refreshFrequency: 1000

style: """
  bottom: 2px
  left: 620px
  color: #fff
  font-family: Helvetica Neue

  table
    border-collapse: collapse
    table-layout: fixed

  &:before
    content: 'netstat'
    position: absolute
    right: 0
    top: -14px
    font-size: 10px

  td
    border: 1px solid #fff
    font-size: 24px
    font-weight: 100
    width: 110px
    max-width: 110px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .wrapper
    padding: 6px 6px 4px 6px
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
      <td class='col1 wrapper' id="in"></td>
      <td class='col2 wrapper' id="out"></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  bytesToSize = (bytes) ->
    return "0 Byte"  if bytes is 0
    k = 1024
    sizes = [
      "b/s"
      "kb/s"
      "mb/s"
      "gb/s"
      "gb/s"
      "pb/s"
      "eb/s"
      "zb/s"
      "yb/s"
    ]
    i = Math.floor(Math.log(bytes) / Math.log(k))
    (bytes / Math.pow(k, i)).toPrecision(3) + " " + sizes[i]
  values = output.split(' ')
  table     = $(domEl).find('table')
  in_bytes = bytesToSize(values[0])
  out_bytes = bytesToSize(values[1])
  in_bytes = if in_bytes=="NaN undefined" then "0 b/s" else in_bytes
  out_bytes = if out_bytes=="NaN undefined" then "0 b/s" else out_bytes
  $(domEl).find('#in').html(in_bytes + "<p>In</p>")
  $(domEl).find('#out').html(out_bytes + "<p>Out</p>")
