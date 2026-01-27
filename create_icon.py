#!/usr/bin/env python3
try:
    from PIL import Image, ImageDraw, ImageFont
except ImportError:
    import subprocess
    import sys
    subprocess.check_call([sys.executable, "-m", "pip", "install", "pillow", "-q"])
    from PIL import Image, ImageDraw

def create_computer_icon():
    size = 1024
    img = Image.new('RGBA', (size, size), color=(255, 255, 255, 0))
    draw = ImageDraw.Draw(img)
    
    # Monitor body
    monitor_left = 150
    monitor_top = 200
    monitor_right = 874
    monitor_bottom = 650
    
    # Draw the screen (light blue)
    draw.rectangle(
        [monitor_left, monitor_top, monitor_right, monitor_bottom],
        fill=(100, 180, 255),
        outline=(40, 120, 200),
        width=8
    )
    
    # Draw inner screen (white)
    draw.rectangle(
        [monitor_left+30, monitor_top+30, monitor_right-30, monitor_bottom-80],
        fill=(255, 255, 255),
        outline=(100, 100, 100),
        width=4
    )
    
    # Draw stand
    stand_left = 400
    stand_right = 624
    stand_top = monitor_bottom - 60
    stand_bottom = monitor_bottom + 100
    
    draw.rectangle(
        [stand_left, stand_top, stand_right, stand_bottom],
        fill=(100, 100, 100),
        outline=(50, 50, 50),
        width=4
    )
    
    # Draw base
    draw.ellipse(
        [200, stand_bottom-50, 824, stand_bottom+50],
        fill=(100, 100, 100),
        outline=(50, 50, 50),
        width=4
    )
    
    # Save the image
    output_path = r'c:\Users\TUF\Desktop\untitled-\assets\icon.png'
    img.save(output_path, 'PNG')
    print(f'Computer icon created at {output_path}')

if __name__ == '__main__':
    create_computer_icon()
