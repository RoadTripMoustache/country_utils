# Contributing Guidelines

This documentation contains a set of guidelines to help you during the contribution process. 
We heartily welcome all the contributions from anyone willing to improve/add new features to this project. Thank you for helping out and remember, **no contribution is too small.**

>Even if this is your first time trying to contribute, this document should help you get going. All the best !

## Code structure
First, here is the code structure to help you understand where is stored which can of information / services.
```
 ├─ .githooks - All the hooks setup to ensure quality before pushing commits
 ├─ .github
 │    ├─ ISSUE_TEMPLATE - Markdown templates for Github issues.
 │    ├─ workflows - Github actions pipelines definitions
 │    ├─ CODEOWNERS - List of the owners of this project.
 │    ├─ dependabot.yaml - Configuration file to use dependabot on this project.
 │    └─ pull_request_template.md - Markdown template of a pull request description.
 ├─ assets
 │    ├─ flags - All the countries' flags images.
 │    └─ i18n - All the localized names of each country. Each file contains the values for a language. The language code is used as filename.
 ├─ lib - Contains all the code of the library.
 │    ├─ src
 │    │    ├─ enums - All the enumerations.
 │    │    ├─ exceptions - All the custom exceptions created for this library.
 │    │    ├─ localization - The localization services to correctly manage the locale.
 │    │    ├─ models - All the models used in the library.
 │    │    └─ services - All the services from the library.
 │    └─ country_utils.dart - The main file of the library which exposes all the features, services, models... to the projects which import this library.
 └─ test
      ├─ dummies - All the dummies to use in the unit tests.
      ├─ src - All the unit tests
      └─ helpers.dart - Contains all the global unit tests helper methods.
```

## Submitting Contributions👩‍💻👨‍💻
Below you will find the process and workflow used to review and merge your changes.

### Step 0 : Go through the README and the demo
- The `README.md` file is the best start to discover this project.
- I encourage you to check them out to quickly get an idea of this project.

### Step 1 : Find an issue
- Take a look at the Existing Issues or create your **own** Issues!
- Wait for the Issue to be assigned to you after which you can start working on it.
- Note : Every change in this project should/must have an associated issue. This helps us easily communicate and document changes.

### Step 2 : Fork the Project
- Fork this Repository. This will create a Local Copy of this Repository on your Github Profile. Keep a reference to the original project in `upstream` remote.
```
$ git clone https://github.com/<your-username>/country_utils
$ cd country_utils
$ git remote add upstream https://github.com/RoadTripMoustache/country_utils
```

- If you have already forked the project, update your copy before working.
```
$ git remote update
$ git checkout <branch-name>
$ git rebase upstream/<branch-name>
```

### Step 3 : Setup git hooks
- Execute the following command to setup the repository's githooks locally. It will help you to do some checks automatically on different steps of a change.
```
git config --local core.hooksPath .githooks/
```

### Step 4 : Branch
Create a new branch. Use its name to identify the issue your addressing.
```
# It will create a new branch with name branch_name and switch to that branch 
$ git checkout -b branch_name
```

### Step 5 : Work on the issue assigned
- Work on the issue(s) assigned to you. 
- You can use the example app to test out changes in realtime.
```
# To run the example project
$ cd example
$ flutter run
```

### Step 6 : Add and Commit changes
- IMPORTANT: You need to be in the project root folder _(not in `country_utils/example/` )_ for all git commands.
```
# To go back to the project root from example folder
$ cd ..
```
  > or you can just launch a new terminal window in `country_utils/` folder 

- Add all the files/folders needed.
- After you've made changes or made your contribution to the project add changes to the branch you've just created by:
```
# To add all new files and changes to branch branch_name
$ git add .
```
- To commit give a descriptive message for the convenience of reviewer by following the [**Conventional Commits**](https://www.conventionalcommits.org/en/v1.0.0/) standard:
```
# This message get associated with all files you have changed
$ git commit -m 'feat: message summarizing changes'
```
### Step 7 : Push changes
- Now you are ready to push your work to the remote repository.
- When your work is ready, complies with the project conventions and is working all fine, upload your changes to your fork:

```
# To push your work to your remote repository
$ git push -u origin branch_name
```

### Step 8 : Create the Pull Request (PR)
- Go to the forked repository in your browser and click on *Compare and pull requests*. Then add a **title** and **description** to your pull request that explains your contribution.
- I also encourage you to add any screenshots/examples that explain your changes.

- Voila! Your Pull Request has been submitted and will be reviewed by the moderators and merged.🥳

---

## Need more help? 🤔
You can refer to the following articles on basics of Git and Github and also contact us, the Project Maintainers, in case you are stuck:
- [Forking a Repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)
- [Cloning a Repo](https://help.github.com/en/desktop/contributing-to-projects/creating-an-issue-or-pull-request)
- [How to create a Pull Request](https://opensource.com/article/19/7/create-pull-request-github)
- [Getting started with Git and GitHub](https://towardsdatascience.com/getting-started-with-git-and-github-6fcd0f2d4ac6)
- [Learn GitHub from Scratch](https://lab.github.com/githubtraining/introduction-to-github)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)


## Tip from us 😇
It always takes time to understand and learn. So, do not worry at all. We know **you have got this**!💪