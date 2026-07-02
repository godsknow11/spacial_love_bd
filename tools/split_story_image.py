#!/usr/bin/env python3
"""
Split a single collage image into N pieces for story chapters.
Defaults to a 2x2 grid producing 4 images: story_chapter_01.png ... _04.png

Usage:
    python tools/split_story_image.py --input assets/story_collage.png --outdir assets --rows 2 --cols 2

Requires: Pillow (pip install pillow)
"""
import os
import argparse
from PIL import Image


def split_image(input_path, out_dir, rows=2, cols=2, prefix='story_chapter'):
    img = Image.open(input_path)
    w, h = img.size
    os.makedirs(out_dir, exist_ok=True)
    written = []
    idx = 1
    for r in range(rows):
        for c in range(cols):
            left = int(c * w / cols)
            upper = int(r * h / rows)
            right = int((c + 1) * w / cols)
            lower = int((r + 1) * h / rows)
            crop = img.crop((left, upper, right, lower))
            out_name = f"{prefix}_{idx:02d}.png"
            out_path = os.path.join(out_dir, out_name)
            crop.save(out_path)
            written.append(out_path)
            print(f"Wrote: {out_path}")
            idx += 1
    return written


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Split an image into a grid for story chapters.')
    parser.add_argument('--input', '-i', required=True, help='Path to input collage image')
    parser.add_argument('--outdir', '-o', default='assets', help='Output directory for chapter images')
    parser.add_argument('--rows', '-r', type=int, default=2, help='Number of rows to split')
    parser.add_argument('--cols', '-c', type=int, default=2, help='Number of columns to split')
    parser.add_argument('--prefix', '-p', default='story_chapter', help='Output filename prefix')

    args = parser.parse_args()
    files = split_image(args.input, args.outdir, rows=args.rows, cols=args.cols, prefix=args.prefix)
    print(f"Done. Generated {len(files)} files.")
