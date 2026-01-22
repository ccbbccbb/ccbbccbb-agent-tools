---
description: "Explain Ralph Wiggum technique and available commands"
---

# Ralph Wiggum Loop Help

Please explain the following to the user:

## What is the Ralph Wiggum Technique?

The Ralph Wiggum technique is an iterative development methodology based on continuous AI loops, pioneered by Geoffrey Huntley.

**Core concept:**
```bash
while :; do
  cat PROMPT.md | claude-code --continue
done
```

The same prompt is fed to Claude repeatedly. The "self-referential" aspect comes from Claude seeing its own previous work in the files and git history, not from feeding output back as input.

**Each iteration:**
1. Claude receives the SAME prompt
2. Works on the task, modifying files
3. Tries to exit
4. Stop hook intercepts and feeds the same prompt again
5. Claude sees its previous work in the files
6. Iteratively improves until completion

The technique is described as "deterministically bad in an undeterministic world" - failures are predictable, enabling systematic improvement through prompt tuning.

## Available Commands

### /ralph-loop-start <PROMPT> [OPTIONS]

Start a Ralph loop in your current session.

**Usage:**
```
/ralph-loop-start "Refactor the cache layer" --max-iterations 20
/ralph-loop-start "Add tests" --completion-promise "TESTS COMPLETE"
/ralph-loop-start "Fix all failing tests. Output <promise>ALL TESTS PASS</promise> when done." --completion-promise "ALL TESTS PASS" --max-iterations 50
```

**Options:**
- `--max-iterations <n>` - Max iterations before auto-stop (0 = unlimited)
- `--completion-promise <text>` - Promise phrase to signal completion

**How it works:**
1. Creates `.claude/ralph-loop.local.md` state file
2. Records `started_at` timestamp for duration tracking
3. You work on the task
4. When you try to exit, stop hook intercepts
5. Same prompt fed back with iteration count and duration
6. Continues until promise detected or max iterations

---

### /ralph-loop-stop

Stop an active Ralph loop (removes the loop state file).

**Usage:**
```
/ralph-loop-stop
```

**How it works:**
- Checks for active loop state file
- Removes `.claude/ralph-loop.local.md`
- Reports stopped iteration count and total duration

---

## Key Concepts

### Completion Promises

To signal completion, Claude must output a `<promise>` tag:

```
<promise>TASK COMPLETE</promise>
```

The stop hook looks for this specific tag. Without it (or `--max-iterations`), Ralph runs infinitely.

**CRITICAL RULE:** You may ONLY output a promise when the statement is completely and unequivocally TRUE. Do not output false promises to escape the loop, even if you think you're stuck or should exit for other reasons.

### Self-Reference Mechanism

The "loop" doesn't mean Claude talks to itself. It means:
- Same prompt repeated
- Claude's work persists in files
- Each iteration sees previous attempts via git history and file state
- Builds incrementally toward goal

### Duration Tracking

The loop tracks:
- `started_at` timestamp when loop begins
- Running duration shown on each iteration
- Total duration reported on completion or cancellation

## State File Format

The state file (`.claude/ralph-loop.local.md`) uses YAML frontmatter:

```yaml
---
active: true
iteration: 1
max_iterations: 10
completion_promise: "ALL TESTS PASS"
started_at: "2025-01-01T00:00:00Z"
---

Your prompt text here
```

## When to Use Ralph

**Good for:**
- Well-defined tasks with clear success criteria
- Tasks requiring iteration and refinement (e.g., getting tests to pass)
- Greenfield projects where you can walk away
- Tasks with automatic verification (tests, linters, build passing)

**Not good for:**
- Tasks requiring human judgment or design decisions
- One-shot operations
- Tasks with unclear success criteria
- Debugging production issues (use targeted debugging instead)

## Real-World Results

From Geoffrey Huntley's experience:
- Successfully generated 6 repositories overnight in Y Combinator hackathon testing
- One $50k contract completed for $297 in API costs
- Created entire programming language ("cursed") over 3 months

## Learn More

- Original technique: https://ghuntley.com/ralph/
- Ralph Orchestrator: https://github.com/mikeyobrien/ralph-orchestrator
- Local documentation: `.claude/scripts/README.md`
