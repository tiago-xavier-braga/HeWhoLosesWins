# Sound Effects

All files live in `assets/audio/` as OGG Vorbis, named `sfx_<thing>` and `music_<thing>`.
Only the essential sounds are kept for now.

**Style:** cozy, with chess.com as the reference for restraint: natural, quiet and short,
never cartoon effects.

**Source:** the sound effects are real recordings from Kenney's free packs (kenney.nl), all
**CC0** (public domain: free for commercial use, credit optional). Each one was trimmed at the
start and leveled; the original file is listed below, so it can be swapped for an alternate
from the same pack. To replace a sound, keep its file name: nothing else changes.

Every sound plays through the `Sfx` autoload (`scripts/audio/sfx.gd`) on the `SFX` audio
bus, with `Sfx.play(Sfx.NAME)`. **Plays from** is the line that calls it.

## Board and pieces

| File | When it plays | Plays from | Source (Kenney pack: file) | Alternates |
|---|---|---|---|---|
| `sfx_piece_move` | A piece lands on a square (each hop of a multi-jump); pitch 0.85 for the CPU | `PieceMover._animate_step` | Casino Audio: `chip-lay-3` | `chip-lay-1`, `chip-lay-2`; Impact Sounds: `impactWood_light_000`–`004` (duller, wooden) |

## Results

| File | When it plays | Plays from | Source (Kenney pack: file) | Alternates |
|---|---|---|---|---|
| `sfx_win` | You win, or solve a puzzle | `WinPanel.show_result` | Original, from `music_main`'s instruments (see below): a rising pluck arpeggio over F resolving to a held Cmaj9, 3.5 s | Kenney Music Jingles `jingles_SAX02` with a lo-fi treatment; `jingles_STEEL02`; `jingles_PIZZI02` |
| `sfx_lose` | The CPU wins, or the puzzle fails | `WinPanel.show_result` | Original, from `music_main`'s instruments: a slower falling pluck line over Dm7 settling on Am7, gentle rather than sad, 3.6 s | Kenney Music Jingles `jingles_SAX01` with a lo-fi treatment; `jingles_STEEL01`; `jingles_PIZZI01` |

**Matching the music:** the win and lose stingers use the same warm pad, tuned plucked string,
soft bass and stereo room as `music_main`, and only chords from C major, the music's key. The
music keeps playing under them, so they blend with whatever chord it is on instead of clashing.

**Lo-fi alternate:** to bring back the lo-fi sax, process the Kenney jingle with ffmpeg: played
11% slower (about 2 semitones lower), a slow tape "wow" (`vibrato=f=0.55:d=0.08`), soft tape
saturation (`asoftclip=type=tanh`), highs and lows rolled off (`highpass=f=140`,
`lowpass=f=3200`), a small room (`aecho`), and a faint vinyl crackle mixed under it.

## UI

| File | When it plays | Plays from | Source (Kenney pack: file) | Alternates |
|---|---|---|---|---|
| `sfx_button_click` | Any button press | `Sfx`, connected to every button as it enters the tree | Impact Sounds: `impactSoft_medium_004` (deep, soft thud, ~400 Hz, 4 ms attack) | Interface Sounds: `drop_002` (lighter pop); Impact Sounds: `impactSoft_medium_002` (deeper, but too low for phone speakers) |

## Music

| File | When it plays | Plays from | Feel | Length |
|---|---|---|---|---|
| `music_main` | Always, from the start screen on, without restarting on scene changes | `Music` autoload (`scenes/audio/music.tscn`, an `AudioStreamPlayer` with autoplay) on the `Music` bus at -8 dB | Minimal and relaxing: 72 BPM, Fmaj7–Em7–Dm7–Cmaj7, a warm slow pad, a sparse plucked arpeggio, a soft bass and a rare kalimba-like melody on the second pass, in a stereo room. Original procedural composition. | 53.3 s seamless loop (import `loop=true`) |

## Credits

Sound effects by Kenney (www.kenney.nl), CC0.

## Out of scope for now

- A Sound on/off button; it would mute the `SFX` and `Music` buses.
- Removed from the first list: piece select, piece lost, piece captured, promote, must
  capture, invalid move, your turn, moves warning, locked button and puzzle unlock.
