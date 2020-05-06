# Make a line editor in Python

Most programmers have wondered how to write an editor. Most elect to use Tk, if they use Python.

However, today, I will document how I created my editor, JEDI.

JEDI is a line editor. (If you are a Vi\[m\] user, think ':')

The starter command set:
```
a: (a)ppend to file
e: (e)dit file
w: (w)rite to file
q: (q)uit
```
Now, let's start programming!

**These instructions are written for GNU+Linux.** (Darwin/macOS may work)

```bash
cd ~
mkdir Python/jedi
python3 -m venv env
source env/bin/activate
git init

```
That sets up our working directory.

Let's edit ```editor.py```

```python3
class editor:
    def __init__(self, filename):
        self.source = open(filename, 'r').read().split('\n')
    def read(self):
        print(self.source)
```
That big block of text in line 3 is my prefrred way of reading a file, and splitting it by line. 
open(filename, 'r'): Make a file object pointing to *filename* in read mode
read(): read the contents of the file as a string
split('\n'): Split the string into an list, using \n as the delimiter

And now for main.py

```python3
from editor import editor
e = editor('main.py')
e.read()
```
Expected output:
```
['from editor import editor', "e = editor('main.py')", 'e.read()']
```

We are now going to impliment the io for adding, opening, and writing.

```editor.py``` should now look like this:
```python3
class editor:
    def __init__(self, filename=""):
        self.fd = filename
        if  self.fd!="" :  # Not ""
            self.source = self.read(filename)
        else:
            self.source = []
    def read(self, fn):
        return open(fn, 'r').read().split('\n')
    def append(self, arr):
        assert type(arr) is list
        for item in arr:
            self.source.append(item)
    def write(self):
        f = open(self.fd, 'w')
        payload = ""
        for item in self.source:
            payload += (item + '\n')
        f.write(payload)
        f.close()
```

And ```main.py``` should look like this:
```python3
from editor import editor
import sys
prompt = '*'
e = editor(sys.argv[1])
while True:
    command = input(prompt) # TODO: Make prompt with -p
    if command == 'a':
        data = []
        txt = ""
        while txt != "`":
            txt = input()
            data.append(txt)
        e.append(data)
    elif command == 'w':
        e.write()
    elif command == 'q':
        break
 ```
 Now, let's clean up the UI a bit, using argparse. Add these changes to main.py:
```python3
from editor import editor
import argparse <=
# Create the parser
parser= argparse.ArgumentParser(description='JEDI is a Ed clone, made in the 21st Century') <=

# Add the arguments
parser.add_argument('file', type=str, help='The path used to access the file to edit (Ex: ~/.bashrc') <=
parser.add_argument('-p', action='store', type=str, help='The prompt string to be used') <=

args = parser.parse_args() <=

e = editor(args.file) <=
while True:
    command = input(args.p) <= 
    if command == 'a':
        data = []
        txt = ""
        while txt != "`":
            txt = input()
            data.append(txt)
        e.append(data)
    elif command == 'w':
        e.write()
    elif command == 'q':
        break
```
Now we can add to a file, but we cannot 
* See the file
* Goto a line 
We need to add  more commands to editor.py
```python3
class editor:
    def __init__(self, filename=""):
        self.fd = filename
        self.cursor = 0
        if  self.fd!="" :  # Not ""
            self.source = self.read(filename,caller=1)
        else:
            self.source = []
        print(self.source)
    def read(self, fn, caller=0):
        try:
            return open(fn, 'r').read().split('\n')
        except FileNotFoundError:
            if caller == 1:
                print("No such file or directory")
            else:
                return 1
    def append(self, arr):
        for item in arr:
            self.source.insert(self.cursor, item)
            self.cursor +=1

    def write(self):
        f = open(self.fd, 'w')
        payload = ""
        for item in self.source:
            payload += (item + '\n')
        f.write(payload)
        f.close()
#============== Add all text after this =================
    def getline(self, lineno):
        if lineno <= len(self.source):
            return self.source[lineno]
        else:
            return 1
    def goto(self, pos):
        pos = int(pos)
        if pos <= len(self.source):
            self.cursor = pos
            return 0
        else:
            return 1
    def isint(self, test):
        try:
            int(test)
            return True
        except ValueError:
            return False
    def getln(self, loc="NAN"):
        if loc == "NAN":
            loc = self.cursor
        return self.source[loc]
    def getpos(self):
        return self.cursor
    def getlen(self):
        return len(self.source)
```
And add this to main.py:
```python3
from editor import editor
import argparse
# Create the parserr
parser= argparse.ArgumentParser(description='JEDI is a Ed clone, made in the 21st Century')

# Add the arguments
parser.add_argument('file', type=str, help='The path used to access the file to edit (Ex: ~/.bashrc')
parser.add_argument('-p', nargs='?', const='', action='store', type=str, help='The prompt string to be used')
def split(word):
    return [char for char in word]
args = parser.parse_args()

e = editor(args.file)
p = args.p
if p == 'None':
    p=''
while True:
    command = split(input(p))
    if command[0] == 'a':
        data = []
        txt = ""
        while txt != "`":
            data.append(txt)
            txt = input()
        data.remove(data[0])
        e.append(data)
    elif command[0] == 'w':
        e.write()
 #=========== Add from here ===========
    elif e.isint(command[0]):
        e.goto(command[0])
    elif command[0] == 'p':
        if len(command) == 1:
           print( e.getln())
        elif len(split(command)) == 2:
            print(e.getln(int(command[1])))
 #=========== To Here ===========
    elif command[0] == 'q':
        break
```

```
The new command set:
p: (p)rint a line (Ex: p15)
(any int): Goto line
a: (a)ppend to file
e: (e)dit file
w: (w)rite to file
q: (q)uit
```
We are now goting to add the final command needed for a basic editor: Delete
```editor.py```

```python3
class editor:
    def __init__(self, filename=""):
        self.fd = filename
        self.cursor = 0
        if  self.fd!="" :  # Not ""
            self.source = self.read(filename,caller=1)
        else:
            self.source = []
    def read(self, fn, caller=0):
        try:
            return open(fn, 'r').read().split('\n')
        except FileNotFoundError:
            if caller == 1:
                print("No such file or directory")
            else:
                return 1
    def append(self, arr):
        for item in arr:
            self.source.insert(self.cursor, item)
            self.cursor +=1

    def write(self):
        f = open(self.fd, 'w')
        payload = ""
        for item in self.source:
            payload += (item + '\n')
        f.write(payload)
        f.close()
    def getline(self, lineno):
        if lineno <= len(self.source):
            return self.source[lineno]
        else:
            return 1
    def goto(self, pos):
        if not isint(pos):
            return 1
        pos = int(pos)
        if pos <= len(self.source):
            self.cursor = pos
            return 0
        else:
            return 1
    def isint(self, test):
        try:
            int(test)
            return True
        except ValueError:
            return False
    def getln(self, loc="NAN"):
        if loc == "NAN":
            loc = self.cursor
        if not self.isint(loc):
            return 1
        loc = int(loc)
        return self.source[loc]
    def getpos(self):
        return self.cursor
    def getlen(self):
        return len(self.source)
    def delline(self, loc="NAN"):

        if loc == "NAN":
            loc = self.cursor
        if not self.isint(loc):
            return 1
        loc = int(loc)
        del self.source[loc]
```
And the corresponding entry in ```main.py```

```python3
from editor import editor
import argparse
# Create the parserr
parser= argparse.ArgumentParser(description='JEDI is a Ed clone, made in the 21st Century')

# Add the arguments
parser.add_argument('file', type=str, help='The path used to access the file to edit (Ex: ~/.bashrc')
parser.add_argument('-p', nargs='?', const='', action='store', type=str, help='The prompt string to be used')
def split(word):
    return [char for char in word]
args = parser.parse_args()

e = editor(args.file)
p = args.p
if p == 'None':
    p=''
while True:
    command = split(input(p))
    if command[0] == 'a':
        data = []
        txt = ""
        while txt != "`":
            data.append(txt)
            txt = input()
        data.remove(data[0])
        e.append(data)
    elif command[0] == 'w':
        e.write()
    elif e.isint(command[0]):
        e.goto(command[0])
    elif command[0] == 'p':
        if len(command) == 1:
           print( e.getln())
        elif len(split(command)) == 2:
            print(e.getln(int(command[1])))
    elif command[0] == 'd':
        if len(command) == 1:
            e.delline()
        elif len(command) == 2:
            error = e.delline(command[1])
    elif command[0] == 'q':
        break
```

NOTE: I have left a ```getpos()``` in editor.py for you to use to impliment the ```l``` command.
This command shoud print this:
```{LINENO} \t {LINE}```
