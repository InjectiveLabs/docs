.PHONY: refresh-examples

refresh-examples:
	markdown-autodocs -c code-block -o source/includes/*.md
