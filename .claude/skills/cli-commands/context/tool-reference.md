# CLI Tool Reference

## jq (JSON processor)
```bash
jq .                    # pretty print
jq '.field'             # extract field
jq '.[0]'               # first array element
jq '.[]'                # iterate array
jq -r '.name'           # raw output (no quotes)
jq -c                   # compact output
jq 'keys'               # object keys
jq 'length'             # count
jq '.[] | .name'        # map to field
jq 'select(.age > 20)'  # filter
```

## delta (git diff pager)
Configured in .gitconfig - works automatically.
- `n/N` - navigate sections
- `git diff --no-pager` - bypass

## tree (directory listing)
```bash
tree                    # current directory
tree -L 2               # max 2 levels
tree -d                 # directories only
tree -a                 # include hidden
tree -I 'node_modules'  # exclude pattern
tree --gitignore        # respect .gitignore
```

## gh (GitHub CLI)
```bash
gh pr list              # list PRs
gh pr create            # create PR
gh pr view              # view current PR
gh pr view --web        # open in browser
gh pr checkout 123      # checkout PR
gh issue list           # list issues
gh issue create         # create issue
```
