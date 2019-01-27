emacs?=emacs
emacs_options=-Q -batch
byte_compilation=byte-compile-file
reformatter_directory=reformatter
src=ocamlreformat.el

all: compile

.PHONY : all test clean

dependencies:
	wget --no-clobber --directory-prefix $(reformatter_directory) https://raw.githubusercontent.com/purcell/reformatter.el/master/reformatter.el

compile: dependencies
	$(emacs) $(emacs_options) --eval="($(byte_compilation) \"$(wildcard $(reformatter_directory)/*.el)\")"
	$(emacs) $(emacs_options) -L $(reformatter_directory) --eval="($(byte_compilation) \"$(src)\")"

test-basic:
	emacs -Q --load "./test/basic/init.el" "test/basic/dummy.ml"
test-disable:
	emacs -Q --load "./test/disable/init.el" "test/disable/dummy.ml"
test-error:
	emacs -Q --load "./test/error/init.el" "test/error/dummy.ml"
test-margin:
	emacs -Q --load "./test/margin/init.el" "test/margin/dummy.ml"

clean:
	rm -rf $(reformatter_directory)
	rm -f *.elc
