# OCaml*Re*format.el

## Goal

Proof of concept that aims to simplify the Elisp code of [ocamlformat.el](https://github.com/ocaml-ppx/ocamlformat/blob/master/emacs/ocamlformat.el) by using the library [reformatter.el](https://github.com/purcell/reformatter.el).

## Build

Use Makefile from the project root directory. Main targets:

* `make` - Download a copy of reformatter.el and compile ocamlreformat.el
* `make test-*` - Start an new instance of Emacs with a minimal configuration
* `make clean` - Remove reformatter.el dependency and clean generated files.

## What's left to do

* Support [`ocamlformat-show-errors`](https://github.com/ocaml-ppx/ocamlformat/blob/master/emacs/ocamlformat.el#L51)
* Package available from MELPA?
* Check it is a drop-in replacement of the current ocamlformat.el. So far, naming of the customizable variables is kept the same apart from the prefix (from `ocamlformat` to `ocamlreformat`).
