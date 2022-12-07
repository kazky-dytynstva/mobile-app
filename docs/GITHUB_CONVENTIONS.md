### Table of content:

1) [Commits](#commits)
1) [Commit messages](#commit-messages)
1) [Branch naming rules](#branch-naming-rules)
1) [Creating PR](#creating-prs)
1) [Merging PRs](#merging-prs)
1) [Reviewing](#reviewing)
1) [Emoji for review](#emoji-for-review)

---------------

### Commits

- Each commit should be a single logical change. Don't make several logical changes in one commit.
  For example, if a patch fixes a bug and optimizes the performance of a feature, split it into two
  separate commits.

- Don't split a single logical change into several commits. For example, the implementation of a
  feature and the corresponding tests should be in the same commit.

- Commit early and often. Small, self-contained commits are easier to understand and revert when
  something goes wrong. Or cherry-pick, if needed.

- Commits should be ordered logically. For example, if commit X depends on changes done in commit Y,
  then commit Y should come before commit X.

_*Note*_: While working alone on a local branch that has not yet been pushed, it's fine to use
commits as temporary snapshots of your work. However, it still holds true that you should apply all
of the above before pushing it.


---------------

### Commit messages

- Use the editor, not the terminal, when writing a commit message:
  ```bash
  # good ✅
  $ git commit

  # bad ❌
  $ git commit -m "Quick fix"
  ```
  Committing from the terminal encourages a mindset of having to fit everything in a single line
  which usually results in non-informative, ambiguous commit messages.

- The summary line (_ie. the first line of the message_) should be descriptive yet succinct.
  Ideally, it should be no longer than 50 characters. It should be capitalized and *written in
  imperative present tense*. It should not end with a period since it is effectively the commit
  title:
  ```bash
  # good ✅ - imperative present tense, capitalized, fewer than 50 characters
  Mark huge records as obsolete when clearing hinting faults

  # bad ❌
  fixed ActiveModel::Errors deprecation messages failing when AR was used outside of Rails.
  ```

- After that should come a blank line followed by a more thorough description. It can also provide
  pointers to related resources (eg. link to the corresponding issue in a bug tracker):
  ```bash
  Short (50 chars or fewer) summary of changes
  
  More detailed explanatory text, if necessary. In some contexts, the first
  line is treated as the subject of an email and the rest of the text as the body. The blank line
  separating the summary from the body is critical (unless you omit the body entirely); 
  tools like rebase can get confused if you run the two together.
  
  Resolves: #56, #78 See also: #12, #34
  
  Source http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
  ```

- Avoid submitting useless commit messages
  ```bash
  # bad ❌
  * clean up search result list
  * fix
  * wip again
  * wip 
  ```

- During development process this is totally okay to create _wip_ commits, but when submitting this
  as a PR, squash your commits into a single or multiple distinct and well documented commits.  
  For this you can
  use [rebase interactive](https://hackernoon.com/beginners-guide-to-interactive-rebasing-346a3f9c3a6d) `git rebase -i HEAD~#NO_OF_COMMITS`

_Ultimately, when writing a commit message, think about what you would need to know if you run
across the commit in a year from now._

---------------

### Branch naming rules

- Use `snake_case`:
    - underscores (`_`) as a separator between words
    - lover case

- Choose short and descriptive names, which describes the problem PR is solving
  ```bash
  # good ✅
  $ git checkout -b add_settings_screen_manager

  # bad ❌ - too vague
  $ git checkout -b bug_fix
  ```

- Identifiers from corresponding tickets in an external service (eg. a GitHub issue)
  are also good candidates for use in branch names. For example:
  ```bash
  # GitHub issue #15
  $ git checkout -b github_issue_15
  ```
- If you work on some screen, name branch with the next patter: `screen_name/task_description`
  For example, `settings/initial_state`, `listen_tale/update_icons`. As a separator between screen
  name and task description use `/`.

---------------

### Creating PRs

- Aim for a good commit history (use `git blame <file>` and `git log`).
- When you just start working on your PR - mark it with label `WIP ⏳`
- When your PR is ready for review - remove `WIP ⏳` and add `Ready for review ✅` label
- When you get a few comments and decide to improve your PR - please change the labels again. Keep
  them updated - it helps others better understand which PRs are more important to review.

---------------

### Merging PRs

- PR can be merged only after 2 approvals
- Once PR is merged - do not forget to mark task as done
- To merge PR use `Rebase + Merge`:
    - `Rebase + Merge` - good ✅ - clean commits with nice messages
    - `Squash + Merge` - bad ❌ - dirty commit history - but then you need to provide a good
      non-trivial squash commit message.

---------------

### Reviewing

- Make it nice ritual: start your morning with :coffee: and PR review :sun:
- Review the oldest PR first
- Ask questions (and answer them, this helps to create a document of discussions for later)
- When writing a comment - use [emoji](#emoji-for-review)
- When reviewing - **do not hesitate to test it** (for example run the app). Some bugs are easier to
  find when you see them
- If you are the owner of the PR, please, always answer all comments.
- Conversation can be closed only when all parts are __happy__ (after the communication)

---------------

### Emoji for review

There is nice practice to use emoji during PR review, specially when you are commenting something
for the first time.

Why it might be useful:

- from the first glance you can understand what about will be this comment
- easier visually to separate more and less important comments
- looks more fancy :tada:

| emoji | code | meaning | actions |
|-------|------|---------|---------|
| :heart: | `:heart:` | nice solution, awesome code, etc | do not require any action |
| :nail_care: | `:nail_care:` | some tiny improvements, polishing stuff, etc | not critical , but probably need to be updated |
| :bulb: | `:bulb:` | idea of how this piece of code might be improved | place for discussion, probably might be updated |
| :question: | `:question:` | unclear code/meaning/destinations, etc | place for discussion, might be needed some changes |
| :stop_sign: | `:stop_sign:` | smth wrong here | blocker to merge, update is required |

Here are some examples:

- :nail_care: this empty line can be removed
- :question: what is the benefit of putting this variable here?
- :stop_sign: we should not store secrets in code like this

-----------

