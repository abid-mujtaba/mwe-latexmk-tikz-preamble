import os

# We incorporate the entire OS environment in to scons
#
# Since we are using a precompiled fmt (preamble) file scons auto-detection
# chooses to use PDFTEX. We over-ride this to use pdflatex instead.
env = Environment(ENV=os.environ, PDFTEX='pdflatex')

# We want pdflatex to halt on error.
env.AppendUnique(PDFTEXFLAGS='-halt-on-error')

# shell-escaping needs to be activated for tikz externalization to work
env.AppendUnique(PDFTEXFLAGS='-shell-escape')


# Explicit command for pre-compiling the preamble (scons doesn't know how to do this, yet)
# The first argument to env.Command() is the target
# The second argument is the source
# The third argument is the shell command that will create the target
preamble = env.Command('preamble.fmt', 'preamble.tex', 'pdftex -ini -jobname=preamble "&pdflatex preamble.tex\dump"')

# The main command for creating pdf from tex files
pdf = env.PDF(target='document.pdf', source='document.tex')

# Declare the preamble to be a dependency of the pdf so that preamble is build before the pdf is
Depends(pdf, preamble)

# Declare the default action to be the creation of the pdf
Default(pdf)


# Since the preamble was created explicitly scons must be explicitly told about
# the need to clean preamble.log when --clean is issued
#
# Additionally all files in the 'build/' folder are generated and so should be
# removed when cleaning
Clean(pdf, Glob('build/*') + ['preamble.log'])
