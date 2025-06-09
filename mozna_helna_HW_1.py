import json


with open("alice.txt", mode="r", encoding="utf-8") as input_file:

    text_space= input_file.read()
    text_nospace = text_space.replace(" ","") 
    text = text_nospace.replace("\n", "")
    count_letter = {}

    for letter in text.lower():
        if letter in count_letter:
            count_letter[letter] += 1
        else:
            count_letter[letter] = 1
    sorted_dict = dict(sorted(count_letter.items()))

with open("hw01_output.json", "w", encoding="utf-8") as output_file:
    json.dump(sorted_dict, output_file, ensure_ascii =False, indent=4)
