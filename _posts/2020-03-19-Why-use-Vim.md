---
layout: default
---

# Why use Vim?

> Why should use an editor like Vim (or EMACS) over an IDE such as PyCharm, Eclipse...?

## Start times

Well, for one, look at start times.

| Editor  | Startup time |
| ---     | ---          |
| Vim     | 133.815 ms   |
| EMACS   | 0.05 S       |
| Eclipse | 27.62s       |
| ---     | ---          |

As you can see, Vim whips Eclipse with 0.133s vs 27.62s 

**Note that my cursor froze several times while starting Eclipse, and the figure is the time from command line invocation to me being able to force an exit.**

## UNIX motto

The UNIX motto is:

> Do one thing, and do it well.

Vim does one thing: Edit text.

EMACS does a couple: Edit text, browse web, and play snake. (Alt-x snake)

PyCharm: Take up RAM, make you angry, learn the killall command, and think about your life choices.

## Size

Now, this one is a small point, but a good one.

What editor can you carry on a 100M flash drive? Vim or Eclipse?

## Configurability

Vim is spartan on first launch. There are a lot of features, but they are all backed in. 

However, you can use Vim-Plugs, Vundle, ETC to add more features.

You can do the same in IDEs, but they are usually not 
 * Good
 * Customizable

## The ~/.vimrc

At startup, Vim sources the ~/.vimrc file.

Mine is long, and can be found at my GitHub page.

However, there is one section that deserves mention:

```
nnoremap <F5> :w<CR>
```

This maps <F5> to save the current file

There is also 

```
nnoremap <F9> :w<CR>:!gcc %<CR>
```

Which compiles the current file.

These are but a couple of my mappings.

## The street cred

This is a personal one, but I like the feeling of using something that many others don't.

People often tell me

 > I don't know why you would use Vim over an IDE.

People also instantly assume you're hacking when they see the white text on black background, and no mouse in sight.

## The colorschemes

In PyCharm, you get 3-4 themes.

In Vim, you have more themes than stars in the sky.

I use Base16-dark, badwolf, and nord.

## The commands

Time for a showdown!

We will now compare the editing commands of an IntelliJ IDE, and vanilla Vim

| Goal                                | Vim                             | IDE                           |
| ---                                 | ---                             | ---                           |
| Go to line 314                      | 134G                            | Ctrl-G 314 <RETURN>           |
| Select all text                     | ggVG                            | Ctrl-a                        |
| Delete to end of line               | d$                              | Not possible                  |
| Return to previous cursor posistion | Ctrl-o                          | Ctrl-Alt-left                 |
| Run command                         | :!<command>                     | No possible in editor window  |
| Split screen with different files   | :split <file> OR :vsplit <file> | Right-click, split-vertically |

## Final words 

So, after reading this, I hope you have a snappy reply when someone says

 > I don't know why you would use Vim over an IDE.

<p align="center">
  <img width="128" height="38" src="https://www.vim.org/images/vim_created_wq.gif">
</p>

