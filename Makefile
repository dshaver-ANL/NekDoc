# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = Nek5000
SOURCEDIR     = source
BUILDDIR      = build
BRANCH        = master

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

gh-pages:
	git checkout -t origin/gh-pages
	rm -rf build _sources _static
	git checkout $(BRANCH) source/ Makefile
	git reset HEAD
	make html
	cp -rf build/html/* ./
	rm -rf source/ Makefile build/
	touch .nojekyll
	git add -A
	git commit -m "Generated gh-pages for `git log -1 --oneline $(BRANCH) --`" && git push origin gh-pages
