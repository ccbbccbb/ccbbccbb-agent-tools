# CLI Tool Reference

## fd (find replacement)
```bash
fd pattern              # find files matching pattern
fd -e tsx               # by extension
fd -t d                 # directories only
fd -t f                 # files only
fd -H                   # include hidden
fd -I                   # include gitignored
fd -H -I                # find everything
fd -x cmd {}            # execute on each result
fd -X cmd               # execute once with all results
```

## rg (grep replacement)
```bash
rg pattern              # search recursively
rg -i pattern           # case insensitive
rg -w pattern           # whole word
rg -l pattern           # list files only
rg -c pattern           # count per file
rg -t js pattern        # filter by type
rg -g '*.tsx' pattern   # filter by glob
rg -C 3 pattern         # 3 lines context
rg --hidden pattern     # include hidden files
rg -uuu pattern         # search everything
```

## sg (ast-grep - structural search)
```bash
sg -p 'pattern'                    # search pattern
sg -p 'pattern' -r 'replacement'   # search and replace
sg -p 'pattern' --lang tsx         # specify language
sg -p 'pattern' -i                 # interactive mode
sg -p 'pattern' --json             # JSON output
sg -p 'pattern' -U                 # apply changes
```

Pattern syntax:
- `$NAME` - named metavariable
- `$_` - anonymous wildcard
- `$$$` - matches multiple nodes

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
