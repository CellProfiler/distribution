#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ICONS="$ROOT/cp/cellprofiler/data/icons"
HICOLOR="$ROOT/distribution/linux/icons/hicolor"
APP_ID="org.cellprofiler.CellProfiler"

ICON_NAMES=(
  "CellProfiler:CellProfiler_square.svg"
  "CellebrateProfiler:CellebrateProfiler.svg"
  "CellentinesProfiler:CellentinesProfiler.svg"
  "SpellProfiler:SpellProfiler.svg"
  "CellProfaller:CellProfaller.svg"
  "JingleCellProfiler:JingleCellProfiler.svg"
)

ICO_SIZES=(16 20 24 32 40 48 64 256)
HICOLOR_SIZES=(16 24 32 48 64 128 256 512)
RUNTIME_SIZE=1024

for tool in rsvg-convert iconutil magick; do
  command -v "$tool" >/dev/null || { echo "missing required tool: $tool" >&2; exit 1; }
done

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

render() {
  rsvg-convert --width "$2" --height "$2" --keep-aspect-ratio "$1" --output "$3"
}

for entry in "${ICON_NAMES[@]}"; do
  name="${entry%%:*}"
  svg="$ICONS/${entry#*:}"
  [[ -f "$svg" ]] || { echo "missing source: $svg" >&2; exit 1; }
  echo "==> $name"

  iconset="$WORK/$name.iconset"
  mkdir -p "$iconset"
  for s in 16 32 128 256 512; do
    render "$svg" "$s" "$iconset/icon_${s}x${s}.png"
    render "$svg" $((s * 2)) "$iconset/icon_${s}x${s}@2x.png"
  done
  iconutil --convert icns --output "$ICONS/$name.icns" "$iconset"

  ico_pngs=()
  for s in "${ICO_SIZES[@]}"; do
    render "$svg" "$s" "$WORK/$name-ico-$s.png"
    ico_pngs+=("$WORK/$name-ico-$s.png")
  done
  rm -f "$ICONS/$name.ico"
  magick "${ico_pngs[@]}" "$ICONS/$name.ico"

  render "$svg" "$RUNTIME_SIZE" "$ICONS/$name.png"

  if [[ "$name" == "CellProfiler" ]]; then
    for s in "${HICOLOR_SIZES[@]}"; do
      mkdir -p "$HICOLOR/${s}x${s}"
      render "$svg" "$s" "$HICOLOR/${s}x${s}/$APP_ID.png"
    done
  fi
done

echo "done"
