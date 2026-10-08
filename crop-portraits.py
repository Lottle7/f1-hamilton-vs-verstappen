# Crop the two driver portraits to a 3:4 head-and-shoulders frame.
# The F1 source asset is a 720x2069 full-length shot with the head near the top
# (roughly y=30-360), so we keep the upper 827px of the 720px width.
# Run after fetch-assets.ps1:  python .\crop-portraits.py
from PIL import Image
import os

BASE = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'assets')
BOX = (50, 0, 670, 827)          # (left, upper, right, lower) -> 620 x 827 = 3:4

for name in ('ham', 'ver'):
    src = os.path.join(BASE, name + '.webp')
    full = os.path.join(BASE, '_' + name + '_full.webp')
    if not os.path.exists(full):
        os.replace(src, full)    # keep the untouched original
    im = Image.open(full).convert('RGBA').crop(BOX)
    im.save(src, 'WEBP', quality=90)
    print('%s -> %dx%d (%.3f)' % (name, im.width, im.height, im.width / im.height))