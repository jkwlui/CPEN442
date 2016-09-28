# Brute-force searching key space, assuming ciphertext is
# encrypted with polyalphabetic substitution

code = "MZUJMKWUNUOKMKKLXOFIMOOUQKXSUVXHTNUKUUWRTSJMQGTWHXMPOXJVXCKMJTWOXJVTUKMWVHUQQKXSUVOXQQLMOWMWVZIKHHRUSMQQIYVXHTHJMKHRUKMSUMCHUORUBXHHXZUMQMJLUOVXHMQQULUKJMKXWRTSJRUWUNUORUOTDVXHHRUOUJMKKIHRTWYUPIQTMOKXSUMZXIHRTSVXHTSXNUVCOXSTWVTMWMHXTQQTWXTKJRUWMZUVTVVXHTZXIBRHMQTHHQUTSYOXNUSUWHWUMORTSPXSSMKTASTQUKCOXSVUPMHIOVXHRUOUHRUCMSXIKOMTQKJUOUKYQTHHRMHJUOUPMOOTUVOXIWVTWHRUPMSYMTBWVXHHRULJUOUPMQQUVRTKOMTQKPXSSMZIHLXIWUNUOPMWHUQQ"

alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

_shift = (code, shift) ->
  decoded = ""
  i = 0
  while i < code.length
    char = code[i]
    index = alphabet.indexOf(char)
    index = (index + shift) % alphabet.length
    decoded += alphabet[index]
    i++
  return decoded

_polyshift = (code, key) ->
  decoded = ""
  i = 0
  keyI = 0
  while i < code.length
    char = code[i]
    index = alphabet.indexOf(char)
    if (index = (index - alphabet.indexOf(key[keyI]))) < 0
      index = alphabet.length + index
    index
    decoded += alphabet[index]
    keyI = (keyI + 1) % key.length
    i++
  decoded

maxCount = -1

do ->
# build key using 3 chars
  for i in alphabet
    console.log i
    for j in alphabet
      for k in alphabet
        key = i+j+k
        decrypted = _polyshift(code, key)
        count = (decrypted.match(/THE/g) || []).length
        if count > 2
          console.log key
          console.log decrypted
