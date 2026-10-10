# File and Folder Naming

Follows the official Godot style guide.

- **Folders**: `snake_case`, lowercase. E.g. `board/`, `main_menu/`.
- **Scenes (`.tscn`)**: `snake_case`, matching the script/root node name.
  E.g. `piece.tscn`, `main_menu.tscn`.
- **Scripts (`.gd`)**: `snake_case`, matching the scene name when attached to
  it. E.g. `piece.gd` for `piece.tscn`.
- **Resources (`.tres`, `.res`)**: `snake_case`, describing the content. E.g.
  `cpu_easy.tres`, `level_01.tres`.
- **Classes (`class_name`)**: `PascalCase`, to stay consistent with the
  engine's native classes. E.g. `class_name Piece`.
- **Autoloads/Singletons**: file name in `snake_case`, but the name
  registered in the project (used as the global identifier) in `PascalCase`.
  E.g. `game_state.gd` registered as `GameState`.
- Avoid spaces, accents, and uppercase letters in file/folder names — only
  `a-z`, `0-9`, and `_`.

## Assets

- **Art, audio and fonts**: `snake_case`, `<thing>_<variant>`, so related files
  sort together. E.g. `piece_white.png`, `piece_black.png`, `sfx_capture.ogg`,
  `music_menu.ogg`.
- Prefix audio with `sfx_` or `music_`.
- **Materials**: prefix `mat_`. E.g. `mat_piece_white.tres`.
- **Textures**: prefix `txt_`. E.g. `txt_board_albedo.png`.
- **Level scenes**: prefix `lvl_`. E.g. `lvl_game.tscn`, `lvl_puzzle_01.tscn`.
- Placeholder art is named like the final art, so swapping it later only
  replaces the file and keeps the references.
- Numbered files use two digits: `lvl_puzzle_01`, `lvl_puzzle_02`, ...

## Class names

GDScript has no namespaces: `class_name` and autoload names are global to the
project. Keep them specific enough not to clash with Godot's native classes
(`Piece` is fine, `Node` or `Timer` is not).
