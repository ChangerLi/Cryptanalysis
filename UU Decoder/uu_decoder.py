uuencode_table = {}
for i in range(8):
    for j in range(8):
        character = chr(32 + i * 8 + j)
        # The character at uuencode_table[0][0] should be the space character
        # However, some mailers may strip space characters in the start or end
        # of a line. So the ‘ character is used instead.
        if character == " ":
            character = "‘"
        uuencode_table[character] = i * 8 + j

# Using ‘ to replace space is not universal.
# Some codes may use ` instead.
uuencode_table["`"] = 0


def uudecoder(encoded_data: str):
    decoded_string = ""
    idx = 0
    while idx < len(encoded_data):
        num_bytes_in_line = uuencode_table[encoded_data[idx]]
        idx += 1
        while num_bytes_in_line > 0 and idx < len(encoded_data):
            binaries = ""
            for i in range(4):
                temp = bin(uuencode_table[encoded_data[idx]])[2:].zfill(6)
                binaries += temp
                idx += 1

            # Break into 3 bytes and for each byte, convert it to a character
            # and append to decoded string
            for i in range(3):
                decoded_string += chr(int(binaries[i * 8 : i * 8 + 8], 2))
            num_bytes_in_line -= 3

    return decoded_string


print(uudecoder(',2&5L;&\@5V]R;&0A'))