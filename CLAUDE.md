# Cranky Coop

A physics slingshot game in one file. See `README.md` for how to play, build and add levels.
Live at https://games.nouriloop.com/cranky-coop/.

## Files

- `game.html` is the source (a page body, no doctype). It is also published as the claude.ai
  artifact https://claude.ai/artifact/A3v6QaaFkAV96H7niCF7Yu.
- `build.sh` syntax-checks the game script and writes `index.html` (gitignored; never edit it by hand).
- `githooks/` holds the git hooks; `.github/workflows/ci.yml` runs the checks on every PR.

## Commands

- `./build.sh` checks that the script between the lines `<script>` and `</script>` parses
  (`node --check`) and writes `index.html`. It refuses when the script is missing, empty or unclosed,
  and says how to map a syntax error's line number back to `game.html`. Locally it is served at
  https://cranky-coop.localhost:8443.
- `git config core.hooksPath githooks` enables the hooks, once per clone (they are not enabled in
  John's clone today). `pre-commit` runs `./build.sh` on the staged `game.html` and scans the staged
  files for bidi characters; `post-commit` and `post-merge` remind you to republish the artifact when
  `game.html` changed. Until the hooks are enabled nothing runs at commit time, so run `./build.sh`
  yourself.
- CI checks that the script parses, not that the game plays: a gameplay change still needs someone to
  play it.

## Rules for agents

- Never open the game, or any window, on the user's desktop: it takes their focus while they type. To
  look at it, build and take a headless screenshot (no window; Matter.js and the fonts load from the
  network): `chromium --headless=new --disable-gpu --user-data-dir="$(mktemp -d)" --window-size=1280,720
  --virtual-time-budget=6000 --screenshot=/path/shot.png "file://$PWD/index.html"`.
- After a change to `game.html`, republish `game.html` (not `index.html`) to the artifact URL above
  with the Artifact tool, and say so.
- The live site is John's to publish: nouriloop-ops' `scripts/games/deploy.sh` builds this repo's
  `origin/main` and uploads `index.html`, so a merge to dev changes nothing there. Never run it.
- Never mention other games' trademarks (for example the bird-flinging one) in code, docs or the
  GitHub description.
- Never write a bidi control character (U+202A–U+202E, U+2066–U+2069) into a file: in JavaScript
  build one with `String.fromCharCode(0x202E)`. The hook and CI reject them.
- Commit only when asked.

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
