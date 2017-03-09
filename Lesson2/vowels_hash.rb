# Заполнить хеш гласными буквами, где значением будет являться порядковый номер буквы в алфавите (a - 1).

vowels = ['а','е','и','о','у','ы','э','ю','я']
vowels_hash = {}
('а'..'я').each_with_index do |letter,index|
  vowels_hash[letter] = index + 1 if vowels.include?(letter)
end
puts vowels_hash