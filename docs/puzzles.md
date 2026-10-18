# Puzzles

Levels live in `resources/puzzles/` and are listed in order in `scenes/ui/puzzle_menu.tscn`.
Squares are `(column, row)`, with row 0 at the top (the CPU's side). The player is always
white and moves up.

Every level was checked against **every** CPU reply, not only the Extreme CPU's choice: the
player has a forced win within the move limit, and only one first move wins. Later moves
depend on how the CPU answers.

Levels 11–50 were found by a search and also pass two more checks: no level can be solved
in fewer moves than its limit, and every piece is needed (removing any one breaks the level).
Each section teaches one idea, from easier to harder.

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

## Forcing (11–15)

Give a piece away so the mandatory capture moves the CPU's man where you need it.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 11 | Sacrifice | 2 | 2 v 1 | (5,2) → (4,1): the CPU must jump it and lands on (3,2). Then (3,4) → (4,3) is the second gift. |
| 12 | Double gift | 2 | 4 v 1 | (3,2) → (4,1): the CPU takes two and lands on (3,2). Then (5,4) → (4,3) lets it take the last two. |
| 13 | Sacrifice and crown | 3 | 3 v 4 | (7,2) → (6,1). Whatever the CPU takes first, crown with (2,1) → (1,0); your king is forced to take (4,3) and lands on (5,4), where it is taken. |
| 14 | Sacrifice to crown the CPU | 3 | 3 v 1 | (4,7) → (5,6) crowns the CPU's man. Then (2,3) → (1,2) and (2,5) → (3,4) feed its king one piece at a time. |
| 15 | Walk into it | 3 | 4 v 1 | (4,5) → (3,4): the CPU's double capture ends on (3,2). Then (3,4) → (2,3) and (1,6) → (2,5). |

## Longest capture (16–20)

The CPU must take the most pieces it can. Set things up so the long line is the one you want.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 16 | Majority rule | 2 | 4 v 2 | (1,2) → (2,1). The CPU crowns on (2,7) taking (1,6); then (4,5) → (5,4) and its king must take all three. |
| 17 | Majority rule | 3 | 5 v 2 | (1,4) → (2,3). After (7,0) takes (6,1), (3,4) → (4,3) forces a triple; (7,2) → (6,1) gives the last piece. |
| 18 | Majority rule | 3 | 5 v 2 | (3,6) → (4,5): the CPU must take two. Then (1,6) → (2,5) and (5,4) → (4,3) for the final double. |
| 19 | Two doubles | 3 | 5 v 3 | (2,5) → (3,4). The CPU picks one of two doubles; either way, (5,2) → (4,1) and then (3,4) → (4,3) finish. |
| 20 | Four in one | 3 | 5 v 2 | (6,3) → (7,2). You are forced to take back with (7,2); after the CPU crowns, (1,6) → (2,5) makes its king take your last four in one move. |

## Feed the king (21–25)

Let the CPU crown, then line your pieces up so its king takes them in one long move. Only the
CPU gets a king here.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 21 | Promote the enemy | 3 | 3 v 1 | (3,4) → (4,3) and let the CPU crown. On (2,7): (1,2) → (2,1) and its king takes all three. On (0,7): (4,5) → (5,4), then (5,4) → (4,3). |
| 22 | Promote the enemy | 3 | 4 v 1 | (6,5) → (5,4) and wait for the CPU to crown on (6,7). Then (0,5) → (1,4) and (0,7) → (1,6): its king takes two each time. |
| 23 | Crown it by capture | 3 | 4 v 1 | (4,7) → (5,6): the CPU crowns by taking it. (2,5) → (3,4) gives its king a double, and (5,2) → (4,1) the last piece. |
| 24 | Crown it by capture | 3 | 5 v 1 | (0,3) → (1,2): the CPU's double ends on (0,5). (2,7) → (1,6) lets it crown, and (5,6) → (4,5) lines up the final double. |
| 25 | Five in one | 3 | 6 v 1 | (1,2) → (2,1). Then (4,7) → (5,6) crowns the CPU, and (4,5) → (5,4) builds a five-piece path for its king. |

## Your own king (26–30)

Crown your own man: a king can offer itself from anywhere along a diagonal.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 26 | Promote to give away | 3 | 2 v 3 | (4,3) → (3,2) is taken. Crown with (2,1) → (3,0); next turn the king steps next to a CPU man, usually on (6,3). |
| 27 | Crown by capture | 4 | 2 v 4 | The first move is a forced capture: pick (5,2) → (3,0), which crowns. Your king then has to take (6,3); after that, offer it next to a CPU man. |
| 28 | Wait with the king | 4 | 2 v 2 | (3,6) → (2,5) is taken. Crown with (2,1) → (3,0), keep the king safe until the CPU crowns, then offer it. |
| 29 | Long-range offer | 4 | 2 v 3 | (3,6) → (2,5) is taken. Crown with (4,1) → (3,0) and use the king's range to reach a square next to a CPU piece; most lines go (3,0) → (7,4) → (6,5). |
| 30 | Crown at once | 4 | 3 v 2 | (4,1) → (5,0). Then (5,0) → (6,1) makes the CPU take two, and (5,6) → (4,5) gives the last piece. If the CPU blocks with (7,0) → (6,1), your king must take it; keep offering. |

## Blocked (31–35)

You also win when you can't move. And the other way round: if your move leaves the CPU with no
move, the CPU wins.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 31 | Win with no moves | 2 | 3 v 4 | (6,3) → (5,2) and then (4,7) → (3,6) are both taken. Your man on (0,1) is stuck behind (1,0), so you win blocked. |
| 32 | Win with no moves | 2 | 4 v 2 | (3,6) → (2,5), then (5,6) → (4,5): the CPU's double ends on (1,4), in front of your man on (0,5), which can't move. |
| 33 | Park a man | 3 | 4 v 4 | (1,2) → (0,1) parks a man behind (1,0), and the CPU takes (6,1). Then give away (4,7) → (3,6) and (2,5) → (3,4); the parked man is blocked. |
| 34 | Don't block the CPU | 3 | 3 v 1 | The CPU's only man can't move, and a move that keeps it stuck loses. (2,5) → (3,4) frees it with a double capture; then walk (4,7) into it. |
| 35 | Don't block the CPU | 3 | 4 v 1 | Same trap. (3,4) → (4,3) opens a double that crowns the CPU on (0,7). Crown with (2,1) → (1,0) and offer the king on (4,3). |

## Tempo (36–40)

Sometimes the right move gives nothing away: wait, and make the CPU move into your pieces.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 36 | Waiting move | 3 | 4 v 2 | (7,6) → (6,5) gives nothing away. Wait again with (3,2) → (2,1), then (5,6) → (4,5) opens a four-piece capture. |
| 37 | Wait with a king | 4 | 3 v 2 | Crown with (0,1) → (1,0) and wait with the king, usually on (2,1), until the CPU crowns. Its king then takes your pieces, often three in one move. |
| 38 | Waiting move | 4 | 3 v 2 | (4,5) → (5,4). If the CPU crowns, feed it with (5,4) → (6,3) and (3,2) → (4,1); if it offers (6,5), take it and keep feeding. (6,7) → (5,6) is the last piece. |
| 39 | Keep the king back | 4 | 3 v 2 | Crown with (2,1) → (1,0). In the main line, keep the king back, feed the men with (1,6) → (2,5) and (3,4) → (2,3), and offer the king last. |
| 40 | Wait with a king | 4 | 4 v 3 | Crown with (4,1) → (5,0) and wait. In the main line, (5,0) → (6,1) is taken by (7,2); then (1,2) → (2,1) sets up a triple capture whatever the CPU does. |

## Rule tricks (41–45)

Rules from the GDD that change the result: captured pieces stay on the board until the move
ends, a man passing the last row mid-capture stays a man, and you choose where a capture ends.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 41 | Captured pieces stay | 3 | 3 v 1 man + 1 king | Crown with (0,1) → (1,0). The CPU's king can't take both (4,3) and (2,5) in one move: the first piece it takes stays on the board and blocks the way back. Your king takes (6,5), then offers itself. |
| 42 | Captured pieces stay | 3 | 6 v 1 man + 1 king | (3,4) → (4,3): the CPU's king takes three, but (6,3) is still on the board and blocks its way to (4,1). Then (2,7) → (3,6) and (0,5) → (1,4). |
| 43 | Through the last row | 3 | 4 v 1 | (7,6) → (6,5). The CPU's man jumps through (2,7) and keeps capturing as a man, ending on (4,5). (4,7) → (3,6) lets it crown, and (6,5) → (5,4) is the last piece. |
| 44 | Choose your landing | 2 | 1 man + 1 king v 3 | Capture is forced: take (5,4) with the king and land on (6,3), not (7,2). The CPU takes it, and (0,3) → (1,2) gives the last piece. |
| 45 | Choose your landing | 3 | 3 men + 1 king v 4 | Take (4,3) with the king and land on (5,4), not (6,5). The CPU takes two; you must take back with (7,6), and (5,4) → (6,3) finishes. |

## Masters (46–50)

Longer limits and several ideas in one level.

| # | Theme | Limit | Pieces (you v CPU) | Solution |
|---|---|---|---|---|
| 46 | 1 vs All | 4 | 1 v 9 | Crown at once with (6,1) → (5,0), then (5,0) → (4,1) offers the king. If the CPU opens a capture instead, you must take it; end it next to a CPU man. |
| 47 | All vs 1 | 4 | 7 v 1 | (4,3) → (5,2): the CPU's man takes three. (0,7) → (1,6) lets it crown, (6,1) → (7,0) crowns you, its king takes two, and your king on (4,3) is the last piece. |
| 48 | Mixed | 4 | 5 v 5 | (4,7) → (5,6) gives a triple that crowns the CPU. (7,4) → (6,3) is taken; crown with (2,1) → (3,0) and offer the king. |
| 49 | Mixed | 5 | 5 v 5 | (2,3) → (1,2) gives a double, (5,2) → (6,1) another. Crown with (2,1) → (3,0) and offer the king, usually on (6,3). |
| 50 | Mixed | 5 | 8 v 4 | (6,3) → (5,2), (4,7) → (5,6), (5,2) → (4,1) for a triple, (2,3) → (1,2) for a double, and (6,7) → (5,6) last. Every CPU reply is forced. |
