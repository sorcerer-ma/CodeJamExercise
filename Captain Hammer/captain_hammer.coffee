# https://code.google.com/codejam/contest/2933486/dashboard#s=p1

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
  return data.shift().split(' ')

handleCase = (caseData) ->
  v = caseData[0]
  d = caseData[1]
  return getDeg v, d

PI = 3.14159265359
c = 180 / 2 / PI
getDeg = (v, d) ->
  return (Math.asin(d / v / v * 9.8) * c).toFixed 7

main = ->
  start = new Date()
  for i in [0...totalCount]
    caseData = getCase()
    ret = handleCase caseData
    writeAnwser i + 1, ret
  end = new Date()
  console.log end - start + 'ms'

main()
