## Minimum Working Example of LaTeX compilation using latexmk with tikz externalization and a pre-compiled preamble which includes the tikz package.

This MWE shows three techniques for making your latex compilation super-fast, I mean unbelievably fast.

### latexmk

This has more to do with saving you time compiling that latex document repeatedly, as many times as it takes to get the final output. 'latexmk' is a perl script that enhances 'make' for LaTeX compilation. All you will have to do is issue the 'make' command once and it will compile only what is needed, as many times as is needed to get the output.

It is configured through the Makefile.

### Tikz externalization

Those of you who use tikz know that it is an extremely powerful and impressive tool. However if used naively all your tikz images will be compiled every time you compile the document. That is an enormous waste of time and computing cycles. With tikz externalization every 'tikzpicture' is first compiled in to a separate pdf file (also useful if you want to use some figure somewhere else).

Now when you compile your document tikz first checks if the tikzpicture has changed. If not the pre-compiled pdf is inserted automatically and your time and power is saved.

### preamble

Anyone who uses pdflatex naively should know that the verbose output produced by the compiler is mostly about loading various packages. Why repeat this process over an over again. Place the preamble (all the '\usepackage{}' commands) in a separate preamble.tex file, compile it once, and then simply load it every time you compile the document. The time saved is enormous.

Again, if used naively, tikz externalization doesn't use the pre-compied preamble, so your images are compiled as slowly as before. But judicious placement of just two commands in the dynamic (non-pre-compiled) preamble allows tikz externalization to use the preamble making your image compilation lightning fast as well.

## Outcome

With this configuration you will only have to compile the bare minimum part of your document (only the part that you have actually changed) when you compile your document. You won't believe how fast your compilation goes.

### Testing

To test this simply clone this repo and run 'scons'. Now change just one thing, say some text in the document, and run 'scons'. The image will not be recompiled. Change just one image and recompile. Only that image will be compiled, the other one will remain as it is. Additionally the tikz package won't be loaded every time. You will see a decrease in both the log output and time taken because the compiler will have less to do.
