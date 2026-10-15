# Playtest Feedback

Feedback from players, translated to English. Items that become work go to the
backlog in `roadmap.md`, not straight into code.

## Open

### 1. Draw is never triggered when both sides only shuffle kings

- **Date:** 2026-10-14
- **Source:** playtester (vs. CPU)
- **Feedback:** "You need to look at the draw case. I made a move on purpose
  here... Then the CPU kept moving its king to one corner and I moved mine to
  the other corner... Different rows. We repeated the same move more than 20
  times and it never ended in a draw."
- **Summary:** After a deliberate move by the player, both sides kept moving a
  king back and forth between corners, on different rows. The same moves were
  repeated more than 20 times and the game never ended in a draw.
- **Likely cause:** the draw rule is missing or only detects an exact repeat of
  the same position, which does not happen when the two kings alternate between
  different squares/rows.
- **Status:** not triaged. Check how the draw is currently detected before
  deciding on the rule (position repetition count, N moves without a capture
  or a man move, or both).

### 2. Battlefield evolution: rockets or mines on the board

- **Date:** 2026-10-14
- **Source:** playtester
- **Feedback:** "If one day the board format could evolve and include rockets or
  mines... Like an evolution into a battlefield... Maybe the game would become
  more competitive and interesting."
- **Status:** idea, not triaged. Out of the current roadmap phase; candidate for
  the backlog.

### 3. Two-player team mode (one on each side of the board)

- **Date:** 2026-10-14
- **Source:** playtester
- **Feedback:** "And playing as a duo... Like one player on each side of the
  board, defending and eliminating the pieces."
- **Status:** idea, not triaged. Out of the current roadmap phase; candidate for
  the backlog.
