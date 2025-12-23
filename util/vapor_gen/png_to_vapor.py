import sys
import os
from PIL import Image

WHITE_MIN = 39
WHITE_MAX = 82
BLACK_MIN = 84
BLACK_MAX = 121


def clamp(val, lo, hi):
    return max(lo, min(hi, val))


def run_to_char(length, is_white):
    if is_white:
        return chr(clamp(39 + length, WHITE_MIN, WHITE_MAX))
    else:
        return chr(clamp(85 + length, BLACK_MIN, BLACK_MAX))


def encode_png_to_vapor(path):
    img = Image.open(path).convert("L")
    w, h = img.size
    px = img.load()

    lines = []

    for y in range(h):
        x = 0
        line = ""

        while x < w:
            current_white = px[x, y] > 127
            run = 1
            x += 1

            while x < w and (px[x, y] > 127) == current_white:
                run += 1
                x += 1

            line += run_to_char(run, current_white)

        lines.append(line + "}")

    return "".join(lines) + "~"


def process_file(png_path):
    if not png_path.lower().endswith(".png"):
        print(f"Skipping non-PNG: {png_path}")
        return

    try:
        vapor = encode_png_to_vapor(png_path)
        out_path = os.path.splitext(png_path)[0] + ".vap"

        with open(out_path, "w", encoding="utf-8") as f:
            f.write(vapor)

        print(f"✔ {os.path.basename(out_path)} created")

    except Exception as e:
        print(f"✖ Failed {png_path}: {e}")


def main():
    if len(sys.argv) < 2:
        print("Drag PNG files onto this script to generate .vap files.")
        return

    for arg in sys.argv[1:]:
        process_file(arg)


if __name__ == "__main__":
    main()
