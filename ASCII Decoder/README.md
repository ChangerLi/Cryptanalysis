# What is ASCII?

The American Standard Code for Information Interchange (ASCII) provides computers with a unique mapping of text characters to byte values.

Unlike other forms of encryption, information about ASCII is easily found all over the internet, so only the decoding method will be explained.

## ASCII Decoding

Today, standard ASCII encoding is done with 8 bits which can be represented by 2 hexadecimal characters in the range 00 - FF. The mapping of characters to bytes is shown in the image below for your convenience.

For those of you who are unfamiliar with hexadecimal, each hexadecimal character is 4 bits.

Each ASCII character in binary will go from 00000000 - FFFFFFFF. The standard number ranges in hexadecimal are 0-9 for single digit numbers, then A-F for 10-15 sequentially.

![ASCII Table](image.png)

## Worked Example

<p>Suppose we want to decode the hex string <code>48656C6C6F20576F726C6421</code>. <br />

<ol>
    <li>
            <strong>Hex Pair: 48</strong>
            <ul>
                <li>Convert to decimal: 4 &times; 16<sup>1</sup> + 8 &times; 16<sup>0</sup> = 64 + 8 = 72</li>
                <li>ASCII Character: 72 corresponds to 'H'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 65</strong>
            <ul>
                <li>Convert to decimal: 6 &times; 16<sup>1</sup> + 5 &times; 16<sup>0</sup> = 96 + 5 = 101</li>
                <li>ASCII Character: 101 corresponds to 'e'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 6C</strong>
            <ul>
                <li>Convert to decimal: 6 &times; 16<sup>1</sup> + 12 &times; 16<sup>0</sup> = 96 + 12 = 108</li>
                <li>ASCII Character: 108 corresponds to 'l'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 6C</strong>
            <ul>
                <li>Convert to decimal: 6 &times; 16<sup>1</sup> + 12 &times; 16<sup>0</sup> = 96 + 12 = 108</li>
                <li>ASCII Character: 108 corresponds to 'l'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 6F</strong>
            <ul>
                <li>Convert to decimal: 6 &times; 16<sup>1</sup> + 15 &times; 16<sup>0</sup> = 96 + 15 = 111</li>
                <li>ASCII Character: 111 corresponds to 'o'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 20</strong>
            <ul>
                <li>Convert to decimal: 2 &times; 16<sup>1</sup> + 0 &times; 16<sup>0</sup> = 32 + 0 = 32</li>
                <li>ASCII Character: 32 corresponds to ' ' (space)</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 57</strong>
            <ul>
                <li>Convert to decimal: 5 &times; 16<sup>1</sup> + 7 &times; 16<sup>0</sup> = 80 + 7 = 87</li>
                <li>ASCII Character: 87 corresponds to 'W'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 6F</strong>
            <ul>
                <li>Convert to decimal: 6 &times; 16<sup>1</sup> + 15 &times; 16<sup>0</sup> = 96 + 15 = 111</li>
                <li>ASCII Character: 111 corresponds to 'o'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 72</strong>
            <ul>
                <li>Convert to decimal: 7 &times; 16<sup>1</sup> + 2 &times; 16<sup>0</sup> = 112 + 2 = 114</li>
                <li>ASCII Character: 114 corresponds to 'r'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 6C</strong>
            <ul>
                <li>Convert to decimal: 6 &times; 16<sup>1</sup> + 12 &times; 16<sup>0</sup> = 96 + 12 = 108</li>
                <li>ASCII Character: 108 corresponds to 'l'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 64</strong>
            <ul>
                <li>Convert to decimal: 6 &times; 16<sup>1</sup> + 4 &times; 16<sup>0</sup> = 96 + 4 = 100</li>
                <li>ASCII Character: 100 corresponds to 'd'</li>
            </ul>
        </li>
        <li>
            <strong>Hex Pair: 21</strong>
            <ul>
                <li>Convert to decimal: 2 &times; 16<sup>1</sup> + 1 &times; 16<sup>0</sup> = 32 + 1 = 33</li>
                <li>ASCII Character: 33 corresponds to '!'</li>
            </ul>
        </li>
</ol> <br />

Putting it all together, the decoded string is <strong>"Hello World!"</strong>
