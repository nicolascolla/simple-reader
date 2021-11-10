# Simple Reader

![](logo.png)

(icon by the [Numix Project](https://github.com/numixproject/numix-icon-theme-square) - GPL-3.0)

Lightweight ePub reader for Ubuntu Touch. Forked from [ePubViewer](https://github.com/gsantner/ePubViewer).

[![OpenStore](https://open-store.io/badges/en_US.png)](https://open-store.io/app/simplereader.collaproductions)

### Features

- Modern, responsive UI
- Themes, fonts, line spacing, margins, font size settings
- Search
- About view
- Go to page
- Location numbers
- Online English dictionary
- More

### Building the app (Ubuntu 16.04)

Install click:

```
$ sudo apt install click
```

Clone this repository and build:

```
$ git clone https://github.com/nicolascolla/simple-reader.git
$ cd simple-reader
$ click build .
```

### Installing the Bookerly font

The Bookerly font is available on the menu. However, it is not included in Ubuntu Touch. In order to install it, download the Bookerly font files from the internet and add them to `/home/phablet/.fonts`.
