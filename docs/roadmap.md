# Roadmap

A web game to be published on third-party sites such as itch.io and CrazyGames.
All project documentation must be kept in the `docs/` folder.

## Phase 1: Core game

- [x] Create the project base and set up the default settings
- [x] Create the mechanics to control the pieces, using placeholder art
- [x] Create the turn rule
- [x] Create the win rule
- [x] Export the project as a web build

## Phase 2: CPU and puzzles

- [x] Create the CPU mechanics:
    - Decide between difficulty modes or a chess-like rating
    - Implement 3 modes (easy, medium, hard)
- [x] Create the puzzle mechanics:
    - Create a system to control the puzzles
    - [x] Create as many levels as possible (minimum 15)
- [ ] Save the puzzle progress with Save Kit (see `save_kit/roadmap.md`)
- [ ] Publish a web build with the CPU and puzzles

## Phase 3: Multiplayer and rewards

- [ ] Create the multiplayer modes:
    - Local
    - ~~Remote (out of scope)~~
- [ ] Create a reward system:
    - Coins?
    - Daily puzzle?

## Phase 4: Final art, UI and audio

- [x] Create the final art and import it into the project
- [x] Create the UIs
- [x] Import the sound files and add them to the project
- [x] Sign the game with the Xavi Games brand: boot splash and the studio lockup in the start
  menu footer (prototype in Penpot, "Boot Splash" and "Start Menu / Studio Credit")

## Phase 5: Content

- [x] Create more puzzle levels, beyond the minimum of 15 from Phase 2 (50 in total; see
  `puzzles.md`)
- [x] Make the puzzle menu fit more than 16 levels: a scrolling list of sections, one theme
  each (prototype in Penpot, "Puzzle Menu / Sections")
