# Puzzles

Levels live in `resources/puzzles/` and are listed in order in `scenes/ui/puzzle_menu.tscn`.
Squares are `(column, row)`, with row 0 at the top (the CPU's side). The player is always
white and moves up.

Every level was checked against **every** CPU reply, not only the Extreme CPU's choice: the
player has a forced win within the move limit, and only one first move wins. Later moves
depend on how the CPU answers.

## Tutorial (1–5)

Each one introduces a single idea. There is no on-screen tutorial text yet.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 1 | Move a piece and win | 1 | 1 v 1 | (4,5) → (3,4). The CPU must capture your last piece. |
| 2 | First moves | 2 | 1 v 1 | (4,7) → (3,6), then step next to the CPU's man so it has to capture. |
| 3 | Finish a match | 1 | 2 v 1 | (4,5) → (3,4). The CPU must take both pieces in one double capture. |
| 4 | Win in 3 turns | 3 | 2 v 2 | (5,6) → (6,5) gives one man away; (0,1) → (1,0) promotes, and the king offers itself. |
| 5 | Capture 3 and still win | 2 | 2 v 4 | Your triple capture is forced: end it on (6,5), not (6,1). Then (6,5) → (5,4) lets the CPU take both men at once. |

## Challenges (6–10)

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 6 | Blocked | 2 | 3 v 4 | (4,3) → (3,2) and then (2,3) → (3,2): the same CPU man captures twice. Your corner man on (0,7) can't move, so you win by being blocked. |
| 7 | King | 2 | 1 king v 2 | King (3,2) → (2,3), the only winning move out of 11. Next turn, offer the king to the CPU's new king. |
| 8 | 1 vs All | 3 | 1 v 12 | (5,6) → (6,5) → (7,4) → (6,3), walking into the army along the edge. |
| 9 | All vs 1 | 3 | 6 v 1 | (2,7) → (1,6) first. The CPU's man gets promoted, and its king takes five of your pieces in one move. |
| 10 | Final | 3 | 2 men + 1 king v 3 men + 1 king | (4,3) → (5,2) sacrifice. You are then forced to capture with (7,2), and your king finishes. |
