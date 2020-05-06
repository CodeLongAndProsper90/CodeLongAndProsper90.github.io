Sometimes, using ```sys.argv``` doesn't cut it.

## Look at a simple program like this:

```python
import sys
mode = sys.argv[1]
src = sys.argv[2]
dest = sys.argv[3]
...

```
This usage would by ```myprog [mode] [src] [dest]```
but what if you have more than one mode?
For example: ```myprog r f src dest```?
That wouldn't work. This is where argparse comes in.

Argparse is in the Python standard library.
It add UNIX-like command lines to any Python program.

# Hello World
This is the "Hello World" of argparse.

```python

import argparse
parser = argparse.ArgumentParser()
parser.parse_args()
```

If you run this with flag ```h```, you get:

```
usage: parse.py [-h]

optional arguments:
  -h, --help  show this help message and exit
```

Now, how do you make this useful?
# Add a argument 
You use ```parser.add_argument()```
Let's make a clone of GNU cat:

```python3
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("filename")
args = parser.parse_args()

with open(args.filename, 'r') as f:
  print(f.read())

```

This is the most basic way to add a argument.

# Help lost users.

If you run ```bash
$ cat --help 
```
You'll get:
```
Usage: cat [OPTION]... [FILE]...
Concatenate FILE(s) to standard output.

With no FILE, or when FILE is -, read standard input.

  -A, --show-all           equivalent to -vET
  -b, --number-nonblank    number nonempty output lines, overrides -n
  -e                       equivalent to -vE
  -E, --show-ends          display $ at end of each line
  -n, --number             number all output lines
  -s, --squeeze-blank      suppress repeated empty output lines
  -t                       equivalent to -vT
  -T, --show-tabs          display TAB characters as ^I
  -u                       (ignored)
  -v, --show-nonprinting   use ^ and M- notation, except for LFD and TAB
      --help     display this help and exit
      --version  output version information and exit

```
How do we add these help string to our program?
You'll use the keyword argument ```help=```.

Let's look at our cat program:
```python3
import argparse
parser = argparse.ArgumentParser()
### Adding a help string:
parser.add_argument("filename", help="The file to read.")
args = parser.parse_args()

with open(args.filename, 'r') as f:
  print(f.read())

```

If you run ```$ cat.py -h```, you'll get:
```
usage: cat.py [-h] filename

positional arguments:
  filename    The file to read.

optional arguments:
  -h, --help  show this help message and exit
```

# Add some requirements.

You can add another optioal keyword argument to ```add_argument()```: ```required=[bool]```
This makes that argument required for execution.

We'll rework ```cat``` to add another argument:

```python3
import argparse
parser = argparse.ArgumentParser()
### Adding a help string:
parser.add_argument("filename", help="The file to read.", required=True)
parser.add_argument("--version", help="Display version info")
args = parser.parse_args()

with open(args.filename, 'r') as f:
  print(f.read())

```
This now gives us another argument
