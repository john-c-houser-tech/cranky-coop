# Cranky Coop

A physics slingshot game in one file. See `README.md` for how to play, build and add levels.

- `game.html` is the source (a page body, no doctype). It is also published as the claude.ai artifact
  https://claude.ai/artifact/A3v6QaaFkAV96H7niCF7Yu, so republish it after changes.
- `./build.sh` syntax-checks the script (`node --check`) and writes `index.html` (gitignored; never edit it by hand).
- Never mention other games' trademarks (for example the bird-flinging one) in code, docs or the GitHub description.
- Never write a bidi control character (U+202A–U+202E, U+2066–U+2069) into a file. The hook and CI reject them.

## Checks

- `git config core.hooksPath githooks` enables the hooks, once per clone. `githooks/pre-commit` runs
  `./build.sh` and the bidi scan of the staged files (build.sh reads the working tree, so unstaged edits
  count); `githooks/post-commit` reminds you to republish the artifact when `game.html` changed. Until
  the hooks are enabled nothing runs at commit time, so run `./build.sh` yourself.
- `.github/workflows/ci.yml` runs the same checks on every PR. It checks that the script parses, not
  that the game plays: a gameplay change still needs someone to play it.

## Git

The repository is https://github.com/john-c-houser-tech/cranky-coop. `main` is John's: never commit or
push to it, and never force-push. `dev` is the integration branch.

1. Before any new work: `git checkout dev && git pull --ff-only`.
2. Branch from dev: `git checkout -b <feature>`. Check `git branch --show-current` before every commit.
3. Commit there, push the branch, and open a PR into dev: `gh pr create --base dev`.
4. Wait for CI to pass: `gh pr checks <n> --watch`. dev's ruleset doesn't require CI, but main's requires
   the `CI result` check, so a red PR merged into dev blocks the next merge to main. Keep that job's name.
5. Before review requests, run independent agent reviews of the PR and fix what they find. Then request
   a Copilot review (`gh pr edit <n> --add-reviewer @copilot`) when Copilot credits are available, and
   address its comments with follow-up commits.
6. John merges to main. Wait for him.
