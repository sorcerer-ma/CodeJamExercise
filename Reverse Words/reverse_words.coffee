# https://code.google.com/codejam/contest/351101/dashboard#s=p1

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

getCase = () -> data.shift().replace '\r', ''

###
# simple way, faster than regular way
reverseWordsJs = (sentence) -> sentence.split(' ').reverse().join ' '
handleCase = (caseData) -> reverseWordsJs caseData
###

# ##
# regular way
reverseStr = (strArr, start, end) ->
  mid = Math.floor((end - start) / 2)
  for i in [0...mid]
    t = strArr[start + i]
    strArr[start + i] = strArr[end - 1 - i]
    strArr[end - 1 - i] = t

handleCase = (caseData) ->
  strArr = caseData.split ''
  start = 0
  for i in [0..strArr.length]
    if strArr[i] == ' ' || i == strArr.length
      reverseStr strArr, start, i
      start = i + 1
      i += 1
  reverseStr strArr, 0, strArr.length
  return strArr.join ''
# ##

main = ->
  start = new Date()
  for i in [0...totalCount]
    caseData = getCase()
    ret = handleCase caseData
    writeAnwser i + 1, ret
  end = new Date()
  console.log end - start + 'ms'

main()
