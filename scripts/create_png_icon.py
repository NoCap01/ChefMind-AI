#!/usr/bin/env python3
"""
Simple script to create a PNG version of the app icon
Requires: pip install Pillow
"""

from PIL import Image, ImageDraw
import math

def create_app_icon():
    # Create a 1024x1024 image
    size = 1024
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Background circle with gradient effect (simplified)
    center = size // 2
    radius = 480
    
    # Create background circle
    draw.ellipse([center-radius, center-radius, center+radius, center+radius], 
                fill=(99, 102, 241, 255))  # Indigo color
    
    # Inner highlight circle
    highlight_radius = 440
    draw.ellipse([center-highlight_radius, center-highlight_radius, 
                 center+highlight_radius, center+highlight_radius], 
                outline=(255, 255, 255, 40), width=3)
    
    # Chef hat main body
    hat_center_y = 420
    hat_width = 180
    hat_height = 140
    draw.ellipse([center-hat_width, hat_center_y-hat_height, 
                 center+hat_width, hat_center_y+hat_height], 
                fill=(255, 255, 255, 255), outline=(148, 163, 184, 80), width=4)
    
    # Chef hat puffs
    puff_radius = 60
    # Left puff
    draw.ellipse([450-puff_radius, 320-puff_radius, 450+puff_radius, 320+puff_radius], 
                fill=(255, 255, 255, 255), outline=(148, 163, 184, 80), width=3)
    # Center puff (larger)
    center_puff_radius = 70
    draw.ellipse([center-center_puff_radius, 300-center_puff_radius, 
                 center+center_puff_radius, 300+center_puff_radius], 
                fill=(255, 255, 255, 255), outline=(148, 163, 184, 80), width=3)
    # Right puff
    draw.ellipse([574-puff_radius, 320-puff_radius, 574+puff_radius, 320+puff_radius], 
                fill=(255, 255, 255, 255), outline=(148, 163, 184, 80), width=3)
    
    # Chef hat band
    band_y = 520
    band_height = 50
    draw.rounded_rectangle([332, band_y, 692, band_y+band_height], 
                          radius=25, fill=(16, 185, 129, 255))  # Emerald color
    
    # AI sparkle (simplified as a star)
    sparkle_x, sparkle_y = 420, 380
    sparkle_size = 25
    # Create star points
    star_points = []
    for i in range(8):
        angle = i * math.pi / 4
        if i % 2 == 0:
            # Outer points
            x = sparkle_x + sparkle_size * math.cos(angle)
            y = sparkle_y + sparkle_size * math.sin(angle)
        else:
            # Inner points
            x = sparkle_x + (sparkle_size * 0.4) * math.cos(angle)
            y = sparkle_y + (sparkle_size * 0.4) * math.sin(angle)
        star_points.append((x, y))
    
    draw.polygon(star_points, fill=(245, 158, 11, 230))  # Amber color
    
    # Small sparkle circles
    draw.ellipse([572, 352, 588, 368], fill=(239, 68, 68, 200))  # Red
    draw.ellipse([434, 474, 446, 486], fill=(16, 185, 129, 180))  # Emerald
    draw.ellipse([585, 445, 595, 455], fill=(245, 158, 11, 150))  # Amber
    
    # Cooking utensils (simplified)
    utensil_y = 680
    utensil_opacity = 80
    
    # Spoon
    spoon_x = center - 40
    draw.ellipse([spoon_x-15, utensil_y-85, spoon_x+15, utensil_y-35], 
                fill=(255, 255, 255, utensil_opacity))
    draw.rounded_rectangle([spoon_x-5, utensil_y-35, spoon_x+5, utensil_y+45], 
                          radius=5, fill=(255, 255, 255, utensil_opacity))
    
    # Fork
    fork_x = center + 40
    draw.rounded_rectangle([fork_x-5, utensil_y-60, fork_x+5, utensil_y+45], 
                          radius=5, fill=(255, 255, 255, utensil_opacity))
    # Fork tines
    for i in range(3):
        tine_x = fork_x - 10 + i * 10
        draw.rounded_rectangle([tine_x-3, utensil_y-75, tine_x+3, utensil_y-45], 
                              radius=3, fill=(255, 255, 255, utensil_opacity))
    
    # Bottom highlight
    draw.ellipse([212, 800, 812, 900], fill=(255, 255, 255, 25))
    
    # Tech dots
    tech_dots = [(300, 200, 4), (724, 180, 3), (280, 800, 3), (744, 820, 4)]
    for x, y, r in tech_dots:
        draw.ellipse([x-r, y-r, x+r, y+r], fill=(255, 255, 255, 50))
    
    return img

if __name__ == "__main__":
    icon = create_app_icon()
    icon.save("assets/icons/app_icon_1024.png", "PNG")
    print("App icon created successfully: assets/icons/app_icon_1024.png")