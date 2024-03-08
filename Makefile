.PHONY: refresh-examples

refresh-examples:
	markdown-autodocs -c code-block -c json-to-html-table -o source/includes/*.md
