# Injective API documentation
Injective API documentation page for all endpoints included in the Python and Go SDKs

## Before creating a PR

Before creating a PR you can test the documentation locally by running `./slate.sh serve`.
If you want to make sure all the example scripts are updated when running the local server with the documentation, please make sure you execute the script to update all code example snippets.
The code examples are included in the documentation using [markdown-autodocs](https://github.com/marketplace/actions/markdown-autodocs).

To refresh all example snippets you can run `make refresh-examples` 

For the refresh process to run successfully please make sure to install `markdown-autodocs` in the local environment:

```
npm i -g markdown-autodocs
```

The deploy process associated to the push events to the `main` branch will automatically run the process to update code example snippets before deploying the documentation site (check the deploy workflow configuration in _.github/workflows/deploy.yml_)

**Important**
Do not modify manually any code snippet between markdown-autodocs markers. Those examples will be modified automatically by the tool.
The markers look like this:
<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=https://raw.githubusercontent.com/kubernetes/kubectl/master/docs/book/examples/nginx/nginx.yaml) -->
<!-- MARKDOWN-AUTO-DOCS:END -->


The API documentation is generated using [Slate](https://github.com/slatedocs/slate)