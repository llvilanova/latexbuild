A reasonably automatic build system for LaTeX documents.

You can use ``latexbuild`` as a stand-alone script to build your documents:

<pre>
latexbuild document.tex
</pre>

But it is more convenient to get copy of ``Makefile.sample`` to automatically
download latexbuild and use it to build your LaTeX documents using ``make``:

<pre>
curl https://raw.githubusercontent.com/llvilanova/latexbuild/master/Makefile.sample > Makefile
make
</pre>

If you store your document in git, you should run the following to ignore some
files generated during the build process:

```
cat >> .gitignore <<EOF
/.deps/latexbuild
/latex.out
/*.synctex.gz
EOF
```

All the heavy lifting is done by other programs:

* [latexrun](https://github.com/aclements/latexrun) drives the actual document
  build.
* [latexdeps](https://github.com/llvilanova/latexdeps) builds external
  depdendencies like figures from their source files (e.g., manages SVG to PDF
  conversion).
* [lacheck](https://ctan.org/tex-archive/support/lacheck) (if provided) finds
  common mistakes in LaTeX documents.
