# Cranky Coop

A physics slingshot game. The raccoons raided the henhouse and ate every egg;
the hens take it personally.

- **Play locally:** https://cranky-coop.localhost:8443 (Caddy serves this directory)
- **Engine:** [Matter.js](https://brm.io/matter-js/) 0.20.0 from cdnjs; everything else
  (art, sound, levels) is hand-drawn canvas and synthesized Web Audio in `game.html`.

## Build

`game.html` is the page body (also what gets published as the claude.ai artifact).
`./build.sh` syntax-checks the script and wraps it into `index.html`.

## How to play

Drag the hen back from the slingshot and let go. Tap (or press Space) mid-flight
to use a power. `R` restarts, `M` mutes, `Esc` opens the level select.

| Hen | Power |
| --- | --- |
| Clucky (red) | None. Pure rage. |
| Zippy (yellow) | Dash forward. Extra damage on wood. |
| Big Bertha (black) | Explode, or wait for the fuse after landing. |
| The Triplets (blue) | Split into three. Extra damage on glass. |

Raccoons come in regular, hard-hat (tougher) and the Raccoon King.

## Adding a level

Append to `LEVELS` in `game.html`. `build(b)` gets builders that take a
bottom y (`base`) and return the new top: `b.hut(mat, x, base, w, h)`,
`b.post`, `b.beam`, `b.crate`, `b.hay` (static platform), `b.coon(x, base, type)`.
Ground is at `G = 900`; the slingshot is at x = 250; keep forts within x ≈ 950–1750.
Materials: `wood`, `glass`, `stone`. Raccoon types: `coon`, `hat`, `king`.

## Credits

- Art, sound, levels and code: original to this project.
- Physics: [Matter.js](https://brm.io/matter-js/) by Liam Brummitt, MIT License, loaded from cdnjs.
- Fonts: Titan One and Nunito from Google Fonts, SIL Open Font License 1.1.

## License

MIT (see [`LICENSE`](LICENSE)).
