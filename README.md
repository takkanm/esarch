# Esarch

esarch is command line tool for [esa](https://esa.io) search.

## Installation

```shell
$ git clone https://github.com/takkanm/esarch.git
$ cd esarch
$ mix deps.get
$ mix escript.build
$ mix escript.install
```

## Usage

### Setting

First, you have to add esa token.
Esa token can gets https://your-team.esa.io/user/applications .

```
$ esarch --add XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

```

### Search

```
$ esarch --help
esarch [--page N] organization_name keyword1 [keyword2 keyword3 ...]
```

