# chinese
Make a sentence look like it's chinese

# What
I've seen a [post](reddit.com/r/translator/comments/1cfz001/unknown_to_english/) on the _transator_ subreddit of a white board with some chinese characters written in it. Those characters appeared to be random and, as it turns out, they were actually hiding a message in a very interesting way, so my immediate thought was: "Let's write some code".

The image that shows the chinese characters can be seen below
![The original image](https://preview.redd.it/unknown-to-english-v0-67d2r4tb6fxc1.jpeg?width=1080&crop=smart&auto=webp&s=f0e01250c9ec05ea9dbe74243bacbc21f2365aec "The original image")
A transcription for the characters is: "獣牡瑣栠灡灥爠浹獳"

In order to decode the message, one must take the characters on this board and convert it to its ASCII representation, which yields the following UTF-16 representation in hex, `0x7363 0x7261 0x7463 0x6820 0x7061 0x7065 0x7220 0x6D79 0x7373`. Then, separate each octet in its own value, to get `0x73 0x63 0x72 0x61 0x74 0x63 0x68 0x20 0x70 0x61 0x70 0x65 0x72 0x20 0x6D 0x79 0x73 0x73`, that if taken their representation in UTF-8, they reveal the message `scratch paper myss`.

# Installation
First, make sure you have a Haskell compiler installed. In case you don't, one can be downloaded here: https://www.haskell.org/ghc/

Then, clone this repository
```sh
git clone https://github.com/pvpscript/chinese
```

Go inside the cloned folder and compile it
```sh
cd chinese
ghc -o chinese main.hs
```

# Using it

# Limitations
The chinese character set is comprised in the range `0x4E00` to `0x9FFF`, so, by looking at how this was implemented, it becomes clear that it may not always work, or at least it won't work for a few ASCII characters.
I simply wanted to replicate the idea presented by deciphered code above, so this little program simply transforms a list of characters into pairs of two octets, then converts them back into a character representation, which may or may not fall between the chinese character range, but overall it works okay.

The first element in a pair of the octets is created by shifting left the character value by **8 bits**, which is the same than **multiplying by 256**. So, in order for the algorithm to present a chinese character, the first element in the pair of octets must have a value of **at least 78**, which translates to the character **"N"**. And, the value must be **at most 159**, that is translated to the character **"ƒ"** and falls in the extended ASCII part of the table. For the second value in the octet pair, it can be anything between **0 and 255**, or **0x0 and 0xFF**.

Knowing this, it becomes obvious that this is not a very good way to map characters of the latin alphabet into chinese characters, but that's just not the point of this, it never was.
