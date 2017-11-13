format = '%d %a %l:%M %p'

command: "date +\"#{format}\""

# the refresh frequency in milliseconds
refreshFrequency: 30000

render: (output) -> """
  <h1>#{output}</h1>
"""

style: """
  color: #FFFFFF
  font-family: Helvetica Neue
  left: 0
  bottom: 55px

  h1
    font-size: 4.5em
    font-weight: 100
    margin: 0
    padding: 0
  """
