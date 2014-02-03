# https://code.google.com/codejam/contest/2933486/dashboard#s=p0

fs = require 'fs'

if process.argv.length < 3
  throw new Error 'no input file'
  return

infile = process.argv[2]
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
        return 'No'

  return 'Yes'

main = ->
  start = new Date()
  for i in [0...totalCount]
    caseData = getCase()
    ret = handleCase caseData
    writeAnwser i + 1, ret
  end = new Date()
  console.log end - start + 'ms'

main()
