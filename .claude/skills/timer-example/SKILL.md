---
name: timer-example
description: Runs a countdown timer as a long-running foreground command to demonstrate Ctrl+B backgrounding in Claude Code. Use this skill when teaching or demonstrating how background tasks work.
---

# Timer Example

A teaching aid for demonstrating how Claude Code handles long-running commands.

## Usage

Run [scripts/timer.sh](../../../scripts/timer.sh) in the **foreground** — do not set
`run_in_background`. Blocking is the point: Ctrl+B only has something to act on
while a foreground command is running.

```bash
./scripts/timer.sh        # 60 ticks (default)
./scripts/timer.sh 120    # longer window for presenting
```

Set the Bash tool `timeout` above the duration in ms (e.g. `120000` for a 60s
timer) so the command isn't auto-backgrounded before the user presses anything.

Open with the framing below (verbatim or close to it) so the demo lands as a
real problem rather than an abstract keybinding. Say it in the same message as
the Bash call, so it is on screen while the timer ticks:

> Some commands take a while — a test suite, a build, this 60s timer. While one
> runs in the foreground I'm blocked waiting on it, so you can't talk to me.
>
> Press **Ctrl+B** and I hand the waiting off to the background — the command
> keeps running, and we can keep talking. Try it now while it ticks.

Hold the tmux caveat until it actually bites; it clutters the opener.

## What to point out

- **Ctrl+B backgrounds the running command, not Claude.** The tool call returns
  immediately with a task ID; the process keeps running detached and reports back
  on completion.
- **The user can send messages at any time**, with or without Ctrl+B. Mid-turn
  messages arrive alongside the next tool result. Ctrl+B is not what enables this.
- **In tmux, Ctrl+B must be pressed twice** — tmux owns Ctrl+B as its prefix key.
  `Ctrl+X Ctrl+B` is an alternate binding that avoids the conflict.
- **Ctrl+B backgrounds all foreground tasks**, not just one, when several run.
- **Long commands are auto-backgrounded on timeout** rather than killed.

## Contrast worth showing

Run it twice — once letting the user press Ctrl+B, once letting it block for the
full duration. The second run shows the waiting cost that Ctrl+B removes.

To read progress after backgrounding, `tail` the task output file named in the
backgrounding message.
