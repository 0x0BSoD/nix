#!/usr/bin/env bash
# Usage: nixup <flake-dir> [inputs...] — update flake.lock, then let an agent commit it.
set -euo pipefail

dir=${1:-.}
sudo nix flake update --flake "$dir" "${@:2}"
cd "$dir"

# One line per node whose revision differs from HEAD: name, old, new, compare link.
changes=$(jq -rn --slurpfile old <(git show HEAD:./flake.lock) --slurpfile new flake.lock '
  $new[0].nodes | to_entries[]
  | .key as $name | .value.locked as $n | $old[0].nodes[$name].locked.rev as $o
  | select($o != null and $n.rev != null and $o != $n.rev)
  | (if $n.type == "github" then "https://github.com/\($n.owner)/\($n.repo)"
     else $n.url | rtrimstr(".git") end) as $repo
  | "\($name) \($o) \($n.rev) \($repo)/compare/\($o)...\($n.rev)"')

if [[ -z $changes ]]; then
  echo "nixup: no revision changes, nothing to commit"
  exit 0
fi
printf '%s\n' "$changes"

# --safe-mode: no hooks or plugins, so nothing restyles the commit message.
claude -p --safe-mode --model sonnet \
  --tools "Bash" \
  --allowedTools "Bash(git add flake.lock)" "Bash(git commit -m:*)" <<EOF
flake.lock was updated. Changed inputs (name, old rev, new rev, compare link):
$changes

Then run exactly "git add flake.lock", then "git commit -m '<message>' -- flake.lock".
The message is one compact line summarizing what was bumped. You must check what changed in revisions by fetching them.
Bad example: nixpkgs, nix-homebrew, homebrew core/cask bump
Good example: zhaofengli-wip/nix-homebrew - nix(deps): bump brew-src from 7.0.11 to 7.0.15, homebrew/homebrew-core - agent-deck 1.16.41, NixOS/nixpkgs - linuxPackages.bcachefs: apply patches for compatibility with latest kernel batch (#592440)
As a rule, use the commit title or body, whichever is shorter.
Recent style:
$(git log -5 --format=%s -- flake.lock)
Finally print the commit message you used.
EOF
