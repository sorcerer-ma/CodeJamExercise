# https://code.google.com/codejam/contest/351101/dashboard#s=p0

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
  cdate = {}
  cdate.credit = +data.shift()
  cdate.items = +data.shift()
  cdate.prices = data.shift().split ' '
  cdate.prices[cdate.items - 1] = cdate.prices[cdate.items - 1].replace '\r', ''
  return cdate

handleCase = (caseData) ->
  credit = caseData.credit
  len = caseData.items
  prices = caseData.prices
  item1 = 0
  item2 = 1
  for i in [0...len]
    for j in [i+1...len]
      if Number(prices[i]) + Number(prices[j]) == credit
        return (i + 1) + ' ' + (j + 1)

main = ->
  start = new Date()
  for i in [0...totalCount]
    caseData = getCase()
    ret = handleCase caseData
    writeAnwser i + 1, ret
  end = new Date()
  console.log end - start + 'ms'

main()
