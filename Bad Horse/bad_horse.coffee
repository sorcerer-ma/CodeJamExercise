# https://code.google.com/codejam/contest/2933486/dashboard#s=p0

fs = require 'fs'

infile = 'A-small-practice-2.in'
outfile = infile.replace '.in', '.out'

data = fs.readFileSync(infile).toString().split('\n')
totalCount = +data.shift()
if totalCount < data.length
  data.pop()

outstream = fs.createWriteStream outfile

writeAnwser = (i, result) ->
  outstream.write 'Case #' + i + ': ' + result + '\n'

getCase = () ->
  adj = {}
  count = +data.shift()

  for i in [0...count]
    t = data.shift().split ' '
    if not adj[t[0]]
      adj[t[0]] = []
    adj[t[0]].push t[1]

    if not adj[t[1]]
      adj[t[1]] = []
    adj[t[1]].push t[0]

  return adj

handleCase = (caseData) ->
  red = 0
  blue = 1
  list = {}
  for evil, opposites of caseData
    evilColor = list[evil]
    if not evilColor
      list[evil] = red
      evilColor = red

    color = (evilColor + 1) % 2
    for opposite in opposites
      oppositeColor = list[opposite]
      if not oppositeColor
        list[opposite] = color
      else if oppositeColor != color
        # console.log evil, ':', evilColor
        # console.log 'conflict:', opposite, '-', oppositeColor, ':', color
        # console.log list
        return 'No'

  # console.log list
  return 'Yes'

main = ->
  for i in [0...totalCount]
    caseDate = getCase()
    ret = handleCase caseDate
    writeAnwser i + 1, ret

main()
