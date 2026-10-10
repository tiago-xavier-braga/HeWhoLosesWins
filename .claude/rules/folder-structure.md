# Folder Structure

This is a single Godot 4.7 game. Layout follows `LearnGodotEngine`: top-level
folders by file type, with a subfolder per feature inside each.

```
res://
├── assets/                # media, grouped by kind
│   ├── materials/
│   ├── models/
│   ├── textures/
│   ├── audio/
│   └── fonts/
├── scenes/                # .tscn, one subfolder per feature
│   ├── levels/            # e.g. lvl_game.tscn
│   ├── board/
│   ├── pieces/
│   └── ui/
├── scripts/               # .gd, one subfolder per feature
│   ├── board/
│   ├── pieces/
│   ├── cpu/
│   └── ui/
├── resources/             # custom .tres data (e.g. levels, CPU difficulty)
├── docs/                  # gdd.md, roadmap.md, design notes
├── icon.svg
└── project.godot
```

Rules:

- Scenes go in `scenes/<feature>/`, scripts in `scripts/<feature>/`. The
  feature folder name matches in both (`scenes/pieces/piece.tscn` +
  `scripts/pieces/piece_controller.gd`).
- Level scenes live in `scenes/levels/` and are prefixed `lvl_`.
- Materials are prefixed `mat_`, textures `txt_`, and live under `assets/`.
- Custom resources (`.tres` data defined by a `Resource` script) go in
  `resources/`; the script that defines them stays in `scripts/`.
- Project documentation lives in `docs/`.
- Don't create empty folders "for the future". A folder only exists once it
  has content — this includes the subfolders above.
- Build output (web export) is never committed; it goes in `build/`, which is
  git-ignored.
