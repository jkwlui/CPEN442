code = "MZUJMKWUNUOKMKKLXOFIMOOUQKXSUVXHTNUKUUWRTSJMQGTWHXMPOXJVXCKMJTWOXJVTUKMWVHUQQKXSUVOXQQLMOWMWVZIKHHRUSMQQIYVXHTHJMKHRUKMSUMCHUORUBXHHXZUMQMJLUOVXHMQQULUKJMKXWRTSJRUWUNUORUOTDVXHHRUOUJMKKIHRTWYUPIQTMOKXSUMZXIHRTSVXHTSXNUVCOXSTWVTMWMHXTQQTWXTKJRUWMZUVTVVXHTZXIBRHMQTHHQUTSYOXNUSUWHWUMORTSPXSSMKTASTQUKCOXSVUPMHIOVXHRUOUHRUCMSXIKOMTQKJUOUKYQTHHRMHJUOUPMOOTUVOXIWVTWHRUPMSYMTBWVXHHRULJUOUPMQQUVRTKOMTQKPXSSMZIHLXIWUNUOPMWHUQQ"

frequency = "ETAOSRIHMDCNLUGFBWPKYQV"
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

_findFrequency = (code) ->
  bins = []
  for char, i in alphabet
    bins.push { frequency: (code.match(new RegExp(char, 'g')) || []).length, char:  char}
  bins

console.log _findFrequency(code)

codeFrequency = _findFrequency(code)
codeFrequency.sort (a, b) ->
  b.frequency - a.frequency

console.log codeFrequency

_replaceChar = (code, replaces) ->
  result = ""
  for char in code
    replace = do ->
      return repl for repl in replaces when repl.from is char
    if replace?
      result += " " + replace.to
    else
      result += " " + char.toLowerCase()

  result

decoded = ""
# replace for the first 10 most frequent char
replaces = []
for i in [0..22]
  from = codeFrequency[i].char
  to = frequency[i]
  replaces.push from: from, to: to

replaces = [
  {from:'M', to: 'A'}
  {from:'Z', to: 'B'}
  {from:'U', to: 'E'}
  {from:'J', to: 'W'}
  {from:'K', to: 'S'}
  {from:'W', to: 'N'}
  {from:'N', to: 'V'}
  {from:'O', to: 'R'}
  {from:'L', to: 'Y'}
  {from:'X', to: 'O'}
  {from:'F', to: 'Q'}
  {from:'I', to: 'U'}
  {from:'Q', to: 'L'}
  {from:'S', to: 'M'}
  {from:'V', to: 'D'}
  {from:'H', to: 'T'}
  {from:'T', to: 'I'}
  {from:'R', to: 'H'}
  {from:'G', to: 'K'}
  {from:'P', to: 'C'}
  {from:'C', to: 'F'}
  {from:'Y', to: 'P'}
  {from:'B', to: 'G'}
  {from:'D', to: 'Z'}
  {from:'A', to: 'X'}
]


console.log replaces
console.log _replaceChar(code, replaces)


