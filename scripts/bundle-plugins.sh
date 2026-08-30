#!/usr/bin/env bash
# Mirror-clone every plugin from init.lua and pack each as <name>.bundle (full: all refs).
set -euo pipefail

OUT="${1:-$(cd "$(dirname "$0")/.." && pwd)/bundles}"
mkdir -p "$OUT"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

repos=(
  "https://github.com/windwp/nvim-autopairs"
  "https://github.com/neovim/nvim-lspconfig"
  "https://github.com/folke/lazydev.nvim"
  "https://github.com/nvim-treesitter/nvim-treesitter"
  "https://github.com/saghen/blink.cmp"
  "https://github.com/rafamadriz/friendly-snippets"
  "https://github.com/nvim-tree/nvim-web-devicons"
  "https://github.com/nvim-lualine/lualine.nvim"
  "https://github.com/folke/flash.nvim"
  "https://github.com/lewis6991/gitsigns.nvim"
  "https://github.com/folke/snacks.nvim"
  "https://github.com/stevearc/conform.nvim"
  "https://github.com/catppuccin/nvim|catppuccin"
  "https://github.com/tree-sitter/tree-sitter-c"
  "https://github.com/tree-sitter/tree-sitter-cpp"
  "https://github.com/tree-sitter/tree-sitter-javascript"
  "https://github.com/tree-sitter/tree-sitter-json"
  "https://github.com/tree-sitter-grammars/tree-sitter-lua"
  "https://github.com/tree-sitter-grammars/tree-sitter-markdown"
  "https://github.com/tree-sitter/tree-sitter-python"
)

for entry in "${repos[@]}"; do
  url="${entry%%|*}"
  name="${entry##*|}"
  [ "$name" = "$url" ] && name="$(basename "$url" .git)"
  echo ">> $name"
  git clone --mirror "$url" "$work/$name.git"
  git -C "$work/$name.git" bundle create "$OUT/$name.bundle" --all
  git bundle verify "$OUT/$name.bundle" >/dev/null
done

echo
echo "Bundles in $OUT:"
ls -lh "$OUT"
