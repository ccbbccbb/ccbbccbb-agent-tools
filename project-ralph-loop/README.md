# Ralph Loop

**TLDR:** Ralph Loop is an iterative execution system that automatically re-feeds Claude's responses back as prompts, enabling autonomous multi-iteration workflows where Claude can build on its own previous work. It's named after Ralph Wiggum from The Simpsons, who famously says "I'm helping!" while doing the same thing over and over.

## What is Ralph Loop?

Ralph Loop is a sophisticated hook-based system that transforms Claude Code into an autonomous iterative agent. Instead of stopping after completing a task, Claude's response becomes the next iteration's prompt, allowing it to:

- Continuously refine implementations based on previous attempts
- Iteratively solve complex problems that require multiple passes
- Self-correct by seeing the results of previous iterations
- Build on previous work visible in files and git history

## How It Works

The Ralph Loop system consists of three main components working together:

### 1. State File (`.claude/ralph-loop.local.md`)

When you activate Ralph Loop with `/ralph-loop-start`, a state file is created with:

```markdown
---
active: true
iteration: 1
max_iterations: 10
completion_promise: "all tests pass"
started_at: "2025-01-01T00:00:00Z"
---

Your task prompt goes here
```

This file stores:
- **active**: Boolean flag indicating an active loop
- **iteration**: Current iteration number (starts at 1)
- **max_iterations**: Maximum iterations before stopping (0 = unlimited)
- **completion_promise**: A statement that must become TRUE for the loop to exit
- **started_at**: ISO 8601 timestamp when the loop began (for duration tracking)
- **prompt**: The task Claude should work on each iteration

### 2. Stop Hook (`.claude/hooks/stop-ralph-hook.sh`)

The stop hook intercepts Claude's attempt to exit and:

1. Checks if a ralph-loop state file exists
2. Reads the current iteration and configuration
3. Extracts Claude's last response from the conversation transcript
4. Checks if the completion promise has been fulfilled (if set)
5. Either:
   - **Stops the loop** if max iterations reached or completion promise fulfilled
   - **Continues the loop** by blocking the stop and feeding the SAME prompt back to Claude

**Key mechanism:** The hook returns JSON with `"decision": "block"` and includes the original prompt in the `"reason"` field, which Claude receives as a new user message.

### 3. Setup Script (`.claude/scripts/setup-ralph-loop.sh`)

This script is called by the `/ralph-loop-start` command to:
- Parse command-line arguments (prompt, max-iterations, completion-promise)
- Validate inputs
- Create the state file with proper frontmatter
- Initialize iteration counter to 1

## Usage Examples

### Example 1: Basic Iterative Refinement

```bash
/ralph-loop-start "Implement a pathfinding algorithm with A* and optimize it" --max-iterations 5
```

What happens:
- Iteration 1: Claude implements basic A* pathfinding
- Iteration 2: Claude sees the implementation and optimizes data structures
- Iteration 3: Claude adds heuristic improvements
- Iteration 4: Claude refines edge cases
- Iteration 5: Claude does final polish and documentation
- Loop stops after 5 iterations

### Example 2: Test-Driven Loop with Completion Promise

```bash
/ralph-loop-start "Fix all failing tests in the battle system" --completion-promise "all tests pass"
```

What happens:
- Iteration 1: Claude runs tests, sees failures, fixes some issues
- Iteration 2: Claude runs tests again, sees remaining failures, fixes more
- Iteration 3: Claude runs tests, sees different failures due to previous fixes, addresses them
- ...continues...
- Final iteration: Claude runs tests, all pass, outputs `<promise>all tests pass</promise>`
- Loop stops immediately when promise is detected

### Example 3: Unlimited Creative Loop

```bash
/ralph-loop-start "Generate test cases for edge cases" --max-iterations 0
```

What happens:
- Continues indefinitely adding more test cases
- You must manually stop with `/ralph-loop-stop` when satisfied
- Useful for exhaustive exploration tasks

## Completion Promises

Completion promises are the most powerful feature of Ralph Loop. They enable **goal-oriented iteration** where Claude works until a specific condition is TRUE.

**Format:**
```bash
--completion-promise "STATEMENT THAT MUST BE TRUE"
```

**Examples of good completion promises:**
- `"all tests pass"` - Clear, verifiable, testable
- `"code coverage exceeds 90%"` - Measurable goal
- `"no compiler errors or warnings"` - Objective criterion
- `"all TODO comments resolved"` - Concrete completion state

**How it works:**
1. Claude must output the EXACT text in XML tags: `<promise>your statement here</promise>`
2. The stop hook detects this pattern and verifies the statement matches
3. Loop stops immediately when detected
4. **CRITICAL**: Claude must NEVER output a false promise - the statement MUST be actually true

**Why promises work:**
- Claude can verify the condition (run tests, check coverage, etc.)
- Provides clear exit criteria for complex tasks
- Prevents infinite loops on bounded problems
- Self-documenting: the promise describes what success looks like

## Advanced Features

### Iteration Context

Each iteration has access to:
- **Git history**: `git log` shows previous commits from earlier iterations
- **File changes**: `git diff` shows cumulative changes
- **Test results**: Previous test runs visible in output
- **Build artifacts**: Compiled code from previous iterations

This allows Claude to learn from previous attempts without re-reading the entire history.

### Safety Mechanisms

**Max iterations cap:**
- Default: Set by user (or 0 for unlimited)
- Prevents runaway loops
- Can be adjusted in state file if needed

**State file validation:**
- Hook validates iteration numbers are valid integers
- Checks for corrupted frontmatter
- Gracefully handles missing files or bad data

**Promise integrity:**
- Claude is instructed to NEVER output false promises
- Promise must match exactly (case-sensitive, whitespace-normalized)
- System prevents "escape hatch" lies

**Error handling:**
- Corrupted state files are deleted with helpful error messages
- Missing transcripts don't crash the hook
- Failed JSON parsing is caught and reported

### Best Practices

**1. Start with bounded iterations:**
```bash
/ralph-loop-start "Your task" --max-iterations 10
```
Better than unlimited for most tasks.

**2. Use completion promises for goal-oriented work:**
```bash
/ralph-loop-start "Implement feature X" --completion-promise "all tests pass and feature works"
```
Clearer than just counting iterations.

**3. Monitor early iterations:**
Watch the first 2-3 iterations to ensure Claude is making progress before letting it run.

**4. Stop if stuck:**
```bash
/ralph-loop-stop
```
If Claude is spinning or not making progress, stop and try a different approach.

**5. Craft specific promises:**
```bash
# Too vague:
--completion-promise "done"

# Better:
--completion-promise "all compilation errors fixed and tests pass"
```

**6. Use for incremental refinement:**
Ralph Loop excels at:
- Fixing multiple test failures iteratively
- Optimizing code performance in stages
- Addressing compiler warnings one by one
- Refactoring large codebases step by step

**7. Avoid for one-shot tasks:**
Don't use Ralph Loop for:
- Simple file reads or searches
- Single-answer questions
- Tasks that don't benefit from iteration

## Common Use Cases

**Test fixing workflow:**
```bash
/ralph-loop-start "Fix all failing tests in src/systems/" --completion-promise "all tests pass"
```

**Incremental optimization:**
```bash
/ralph-loop-start "Optimize database queries for speed" --max-iterations 5
```

**Documentation generation:**
```bash
/ralph-loop-start "Add NatSpec comments to all public functions" --completion-promise "all functions documented"
```

**Refactoring campaign:**
```bash
/ralph-loop-start "Refactor battle system to use ECS patterns" --max-iterations 8
```

**Code quality improvement:**
```bash
/ralph-loop-start "Fix all clippy warnings" --completion-promise "cargo clippy shows no warnings"
```

## Troubleshooting

**Loop doesn't start:**
- Check that `/ralph-loop-start` command executed successfully
- Verify `.claude/ralph-loop.local.md` was created
- Ensure stop hook script is executable: `chmod +x .claude/hooks/stop-ralph-hook.sh`

**Loop stops immediately:**
- Check if max_iterations is set to 0 (unlimited) when you expect iteration count
- Verify completion promise isn't already true (check output for `<promise>` tags)
- Look for corrupted state file - delete and recreate

**Loop runs forever:**
- Stop with `/ralph-loop-stop`
- Set a lower `--max-iterations` for safety
- Check if completion promise is too hard to achieve
- Consider if the task is actually unbounded

**Promise not detected:**
- Ensure Claude outputs EXACT text: `<promise>your exact promise text</promise>`
- Check for typos, case differences, or extra whitespace
- Promise matching is literal string comparison
- Look in conversation for the promise output

**State file corruption:**
- Delete `.claude/ralph-loop.local.md`
- Re-run `/ralph-loop-start` command
- Don't manually edit the state file while loop is running

## Technical Details

**Hook execution flow:**
1. Claude finishes response and tries to stop
2. Stop hook receives JSON with `transcript_path` and `session_id`
3. Hook reads `.claude/ralph-loop.local.md` to check for active loop
4. Hook parses YAML frontmatter for iteration/max/promise
5. Hook validates numeric fields (iteration, max_iterations)
6. Hook checks max_iterations constraint
7. Hook reads transcript JSONL and extracts last assistant message
8. Hook checks for completion promise in Claude's output
9. Hook increments iteration counter
10. Hook returns JSON: `{"decision": "block", "reason": "<prompt>", "systemMessage": "🔄 Ralph iteration N"}`
11. Claude receives the prompt as a new user message
12. Process repeats

**File locations:**
- State: `.claude/ralph-loop.local.md` (gitignored)
- Stop hook: `.claude/hooks/stop-ralph-hook.sh`
- Setup script: `.claude/scripts/setup-ralph-loop.sh`
- Commands: `.claude/commands/ralph-loop-start.md`, `.claude/commands/ralph-loop-stop.md`, `.claude/commands/ralph-loop-help.md`

**State file format:**
```markdown
---
active: true
iteration: <number>
max_iterations: <number>
completion_promise: "<string>"
started_at: "<ISO 8601 timestamp>"
---

<prompt text>
```

**Hook JSON schema:**
```json
{
  "decision": "block",           // Prevents Claude from stopping
  "reason": "<prompt>",          // Fed back to Claude as next message
  "systemMessage": "<status>"    // Shown to user (e.g., "🔄 Ralph iteration 3 (running for 5m 30s)")
}
```

## Security and Permissions

Ralph Loop requires:
- **Bash tool access**: To run the stop hook script
- **File read access**: To read state file and transcript
- **File write access**: To update iteration counter in state file

The stop hook runs in a sandbox by default with restricted access. It only:
- Reads `.claude/ralph-loop.local.md`
- Reads conversation transcript (provided by Claude Code)
- Writes updated iteration number
- Uses standard CLI tools: `sed`, `grep`, `jq`, `perl`

No network access, no system modifications, no credential access.

## Credits and Philosophy

Ralph Loop is inspired by:
- **Agent loops** in AI research (ReAct, AutoGPT patterns)
- **Test-driven development** (iterate until tests pass)
- **Simulated annealing** (iterative optimization)
- **Ralph Wiggum** (doing the same thing over and over with enthusiasm)

The name "Ralph" captures the essence: an enthusiastic, persistent agent that keeps trying the same prompt until success is achieved, just like Ralph Wiggum's innocent determination.

## Further Reading

- Claude Code hooks documentation: https://code.claude.com/docs/en/hooks
- Stop hook reference: https://code.claude.com/docs/en/hooks#stop
- Hook JSON output format: https://code.claude.com/docs/en/hooks#hook-output

---