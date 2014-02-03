# problem link

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

KEY_MAP = 
  a: '2'
  b: '2'
  c: '2'
  d: '3'
  e: '3'
  f: '3'
  g: '4'
  h: '4'
  i: '4'
  j: '5'
  k: '5'
  l: '5'
  m: '6'
  n: '6'
  o: '6'
  p: '7'
  q: '7'
  r: '7'
  s: '7'
  t: '8'
  u: '8'
  v: '8'
  w: '9'
  x: '9'
  y: '9'
  z: '9'
  sp: '0'

OP_NUM = 
  a: 1
  b: 2
  c: 3
  d: 1
  e: 2
  f: 3
  g: 1
  h: 2
  i: 3
  j: 1
  k: 2
  l: 3
  m: 1
  n: 2
  o: 3
  p: 1
  q: 2
  r: 3
  s: 4
  t: 1
  u: 2
  v: 3
  w: 1
  x: 2
  y: 3
  z: 4
  sp: 1

repeatChar = (char, n) ->
  ret = ''
  for i in [0...n]
    ret += char
  return ret

getCase = () -> data.shift().replace '\r', ''

handleCase = (caseData) ->
  strArr = caseData.split ''
  preKey = ''
  ret = ''
  for i in [0...strArr.length]
    w = strArr[i]
    if w == ' ' then w = 'sp'
    key = KEY_MAP[w]
    if preKey == key then ret += ' '
    ret += repeatChar key, OP_NUM[w]
    preKey = key
  return ret


main = ->
  start = new Date()
  for i in [0...totalCount]
    caseData = getCase()
    ret = handleCase caseData
    writeAnwser i + 1, ret
  end = new Date()
  console.log end - start + 'ms'

main()
