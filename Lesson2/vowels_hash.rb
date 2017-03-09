# Заполнить хеш гласными буквами, где значением будет являться порядковый номер буквы в алфавите (a - 1).

vowels = ['а','е','и','о','у','ы','э','ю','я']
alphabet = []
('а'..'я').each { |l| alphabet << l }
vowels_hash = {}
alphabet.each do |letter|
  vowels_hash[letter] = alphabet.index(letter) + 1 if vowels.include?(letter)
end
