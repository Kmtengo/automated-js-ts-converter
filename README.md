# Automated JS to TS Converter
This action is designed to convert JavaScript files with the _.jsx_ extension in a pull request, on the _main_ branch to TypeScript.

This action uses the [convert-js-to-ts](https://github.com/HardCoreQual/convert-js-to-ts) package to convert the JavaScript files to TypeScript. The package is also available on [npm](https://www.npmjs.com/package/convert-js-to-ts).

This action is triggered by a pull request on the _main_ branch. The action will switch to the Pull Request source branch and convert the JavaScript files to TypeScript and store the generated typescript files in the **src/output** directory. It will then run a test using the default react test **(react-scripts test)** and if the test passes it will push the changes to the main branch as an added commit on the pull request. It will then _comment_ on the pull request that the JavaScript files have been converted and _assign a reviewer_ to review the changes.

## Important Notes
* The Pull Request must have the label **convert-to-ts** attached to it.
* This action assumes you have a **main** branch in your repository and a **src** directory in your pull request.

* The action only converts the JavaScript files located within the **src** directory of the changes in the pull request.

* You can use this project to update a podcast feed located within this repository in the **./output/podcast.xml** file or update other podcast feeds in other repositories. When you use another repo to run the project, it will find the _action.yml_ file, understand that it needs to use the Docker image, run the _Dockerfile_ to generate the server then run the _entrypoint_, which will set up git, run _feed.py_ and push the code to the server and in so doing generate your feed.


# Usage
## Navigate to Actions
In your repository got to **Actions** and select **set up a workflow yourself**.
## Create a YAML file
Create a YAML file named **main.yml** with the following format:

```name: Code Review

on:
  pull_request:
    branches: [main]
    types: [labeled]

jobs:
  convert-test-review:
    if: contains(github.event.pull_request.labels.*.name, 'convert-to-ts')
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@v4
      - name: Run Converter
        uses: Kmtengo/automated-js-ts-converter@main
```

> [!NOTE]
> Ensure to grant the **entrypoint.sh** file executable permissions by running the command `chmod -R 775 entrypoint.sh` in the terminal.
> Run `ls -la` to ensure that it has been granted the necessary permissions.
