# Cranky Coop

A physics slingshot game in one file. See `README.md` for how to play, build and add levels.

- `game.html` is the source (a page body, no doctype). It is also published as the claude.ai artifact
  https://claude.ai/artifact/A3v6QaaFkAV96H7niCF7Yu, so republish it after changes.
- `./build.sh` syntax-checks the script and writes `index.html` (gitignored; never edit it by hand).
- Never mention other games' trademarks (for example the bird-flinging one) in code, docs or the GitHub description.

## Git

`main` is John's: never commit or push to it, and never force-push. `dev` is the integration branch.

1. Before any new work: `git checkout dev && git pull --ff-only`.
2. Branch from dev: `git checkout -b <feature>`. Check `git branch --show-current` before every commit.
3. Commit there, push the branch, and open a PR into dev: `gh pr create --base dev`.
4. Request a Copilot review (`gh pr edit <n> --add-reviewer @copilot`) and address its comments with follow-up commits.
5. John merges to main. Wait for him.
