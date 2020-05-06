# How to exit Vim

[The Canonical way](https://github.com/CodeLongAndProsper90/codelongandprosper90.github.io/blob/master/_posts/2020-03-18-How-to-exit-Vim.md#the-canonical-way)

[The "Abort! Abort!" way](https://github.com/CodeLongAndProsper90/codelongandprosper90.github.io/blob/master/_posts/2020-03-18-How-to-exit-Vim.md#the-abort-abort-way)

[The "Sudo" way](https://github.com/CodeLongAndProsper90/codelongandprosper90.github.io/blob/master/_posts/2020-03-18-How-to-exit-Vim.md#the-sudo-way)

[The power user's way](https://github.com/CodeLongAndProsper90/codelongandprosper90.github.io/blob/master/_posts/2020-03-18-How-to-exit-Vim.md#the-power-users-way)

[The fallback way](https://github.com/CodeLongAndProsper90/codelongandprosper90.github.io/blob/master/_posts/2020-03-18-How-to-exit-Vim.md#the-fallback-way)

[The UNIX way](https://github.com/CodeLongAndProsper90/codelongandprosper90.github.io/blob/master/_posts/2020-03-18-How-to-exit-Vim.md#the-unix-way)

For some reason or other, if you are stuck in Vim, there are many ways to exit. Here are but a few.

However, first we need to cover some Vim history.
The first editor to grace UNIX was ed. This is what [JEDI](https://codelongandprosper90.github.io/2020/03/14/Make-an-terminal-editor-in-python.html) is a clone of.
Next in line is EX. EX stands for EXtended. More on this later.
After EX, people had enough terminal cycles to display a file. This caused the birth of Vi. 
Vi stands for VIsual.
Vim is an extension of Vi.
Whenever you press ```:``` in Vim, you are actually invoking an EX command. 
Now, on to the commands!

Before entering these commands, press ```ESC```

## The canonical way
```
:wq
```
to save and quit.

## The "Abort! Abort!" way:
```
:q!
``` 
To save without quitting

## The "Sudo" way:
```
:wq!
```
To **force** a save and quit

## The power user's way:
```
ZZ
```
This is the same as ```:wq```

## The fallback way:
```
ZQ
```
This is the same as ```:q!```

## The UNIX way:
```
^Z
killall vim
```

I now hope will **never** post "how to quit vim" on Stack Overflow again

![One more joke](_site/idont-know-who-you-are-but-if-you-make-one-51027889.png)
