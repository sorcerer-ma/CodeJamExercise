# https://code.google.com/codejam/contest/2933486/dashboard#s=p1

fs = require 'fs'
readline = require 'readline'

infile = 'B-small-practice.in'
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
  for i in [0...totalCount]
    caseDate = getCase()
    ret = handleCase caseDate
    writeAnwser i + 1, ret

main()
