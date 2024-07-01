def hex_to_ascii(hex_string):
    ascii_string = ""
    # Iterate over pairs of characters in the hex string
    for i in range(0, len(hex_string), 2):
        # Get the current pair of characters
        hex_pair = hex_string[i:i+2]
        # Convert the pair of characters to decimal
        decimal_value = int(hex_pair, 16)
        # Convert the decimal value to ASCII character
        ascii_character = chr(decimal_value)
        # Append the ASCII character to the result string
        ascii_string += ascii_character
    return ascii_string
