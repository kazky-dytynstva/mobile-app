# This is the repo for Flutter mobile application `Казки дитиснтва`

----------

### Work preparations:

1. Add local `git hooks`. About the hooks and how to add them please read [here](https://medium.com/@f3igao/get-started-with-git-hooks-5a489725c639).
   <details>
      <summary>pre-push</summary>

      ```bash
        #!/bin/bash
        
        protected_branch='dev'
        current_branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
        
        if [ $protected_branch = $current_branch ]
        then
            echo "[ ${protected_branch} is a protected branch❗❗❗ create PR to merge 🙏🏻]"
            exit 1 # push will not execute
        else
            exit 0 # push will execute
        fi
      ```
    </details>
   <details>
      <summary>pre-commit</summary>

      ```bash
        #!/bin/bash
        
        cd application/
        flutter analyze lib test
        flutter format ./ --set-exit-if-changed
      ```
    </details>

1. Please checkout the [docs](/docs)
   * [github conventions](/docs/GITHUB_CONVENTIONS.md)
   * [naming conventions](docs/NAMING_CONVENTIONS.md)
   * [widget conventions](/docs/WIDGET_CONVENTIONS.md)
   * [stagings](docs/STAGINGS.md)
   * [data flow](docs/DATA_FLOW.md)
   * [screens schema](docs/SCREENS_SCHEMA.md)
   * [task development flow](docs/TASK_DEVELOPMENT_FLOW.md)
1. Read application [README.md](/application/README.md) for more instructions

----------
