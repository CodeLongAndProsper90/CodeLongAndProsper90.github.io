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

# Have an argument

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

If you run 
```bash
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
How do we add these help strings to our program? (" equivalent to -vET ")
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
parser.add_argument("filename", help="The file to read.", required=True)
parser.add_argument("--count", help="Count lines.")
args = parser.parse_args()
count = 0
with open(args.filename, 'r') as f:
  if args.count:
    print(count, end = " ")
    count += 1
  print(f.read())

```

We now have mutiple arguments, one depending on the other.
You can't run ```--count``` without a file to read. This is where the ```required=True``` comes in. 
You have to have the filename argument, otherwise it raises an error.


# Who reads manuals anyway?

 How to disable the help text:
Sometimes, you may want to use ```-h``` as a custom argument.

You can disable the help option with:
```python3
...
parser = argparse.ArgumentParser(add_help=False)
...
```

# What's GNU?
Look at the program GNU ```tar```.
```tar -xvf``` works the same as ```tar --extract --verbose --file```. 
You can add this to your program like this:

```python3
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("filename", help="The file to read.", required=True)
parser.add_argument("--count", "-c", help="Count lines.")  # New argument!
args = parser.parse_args()
```

# What if?

How to make an argument required if another argument is present.
Sometimes, you may want to have "Optional requirments"    (Oxymoron)
For example in one of my programs, there is an option, ```t```, that needs ```f``` and ```--host```. However, it also has an argument ```r``` that does not need those.

To make an argument required if a other argument is present:
```python3
import argparse, sys
parser = argparse.ArgumentParser()
parser.add_argument("filename", help="The file to read.", required=True)
parser.add_argument("--count", "-c", help="Count lines.", required='-foo' in sys.argv)  # New argument!
args = parser.parse_args()
```

# What int the world?

Sometime you want to get a bool or int.
The argument ```type=``` is what you need.

```python3
import argparse, sys
parser = argparse.ArgumentParser()
parser.add_argument("filename", help="The file to read.", required=True)
parser.add_argument("--count", "-c", help="Count lines.", required='-foo' in sys.argv, type=int)  # New argument!
args = parser.parse_args()
```
You may also want to just see if an argument is present, but does not have a value. 
You'll use the argument ```action="store_true"```.

```python3
import argparse, sys
parser = argparse.ArgumentParser()
parser.add_argument("filename", help="The file to read.", required=True)
parser.add_argument("--count", "-c", help="Count lines.", required='-foo' in sys.argv, action="store_true")  # New argument!
args = parser.parse_args()
```

# Wrapping up.

This article just skims the surface of what is possible with argparse. 
Some other bits of information:
[Python 3.8 documentation](https://docs.python.org/3.9/library/argparse.html)

[Real Python](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=6&cad=rja&uact=8&ved=2ahUKEwjf6tqTz-3oAhUIeawKHet9C_gQFjAFegQICBAB&url=https%3A%2F%2Frealpython.com%2Fcommand-line-interfaces-python-argparse%2F&usg=AOvVaw3kycV8IHjJVGx7EH7HFQmG)

[This article](about:blank)
