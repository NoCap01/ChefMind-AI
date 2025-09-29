#!/usr/bin/env python3
"""
Create a clean kitchen tools app icon with gradient background
"""
import struct
import zlib
import os
import math

def create_kitchen_tools_icon():
    """Create a 1024x1024 PNG icon with kitchen tools on gradient background"""
    width, height = 1024, 1024
    
    # Create image data (RGBA)
    img_data = []
    center_x, center_y = width // 2, height // 2
    
    for y in range(height):
        row = []
        for x in range(width):
            # Calculate distance from center for circular shape
            dx = x - center_x
            dy = y - center_y
            distance = (dx * dx + dy * dy) ** 0.5
            
            if distance <= 480:  # Main circle
                # Gradient from indigo to violet (matching home screen)
                ratio = (x + y) / (width + height)  # Diagonal gradient
                r = int(99 + (139 - 99) * ratio)    # 99 -> 139 (indigo to violet)
                g = int(102 + (92 - 102) * ratio)   # 102 -> 92
                b = int(241 + (246 - 241) * ratio)  # 241 -> 246
                a = 255
                
                # Large Chef's Knife (center-left, diagonal)
                # Blade
                if 250 <= x <= 450 and 300 <= y <= 500:
                    blade_line = (y - 300) - 0.5 * (x - 250)  # Diagonal line
                    if -20 <= blade_line <= 20:  # Blade thickness
                        r, g, b = 240, 240, 240  # Bright silver blade
                
                # Knife handle
                if 180 <= x <= 280 and 480 <= y <= 580:
                    r, g, b = 139, 69, 19  # Saddle brown handle
                
                # Wooden Spoon (center-right)
                # Spoon bowl (circular)
                spoon_dx = x - 650
                spoon_dy = y - 350
                if spoon_dx * spoon_dx + spoon_dy * spoon_dy <= 1600:  # Circle radius 40
                    r, g, b = 160, 82, 45  # Brown wood
                
                # Spoon handle
                if 620 <= x <= 640 and 350 <= y <= 650:
                    r, g, b = 160, 82, 45  # Brown wood
                
                # Fork (bottom center)
                # Fork tines
                for tine_x in [480, 500, 520, 540]:
                    if tine_x - 5 <= x <= tine_x + 5 and 600 <= y <= 680:
                        r, g, b = 220, 220, 220  # Silver tines
                
                # Fork handle
                if 495 <= x <= 525 and 680 <= y <= 780:
                    r, g, b = 139, 69, 19  # Brown handle
                
                # Whisk (top right)
                # Whisk wires (simplified as lines)
                whisk_center_x, whisk_center_y = 750, 280
                for wire_angle in [0, 0.3, -0.3, 0.6, -0.6]:
                    wire_x = whisk_center_x + 60 * math.cos(wire_angle + math.pi/2)
                    wire_y = whisk_center_y + 60 * math.sin(wire_angle + math.pi/2)
                    
                    # Draw wire from center to end
                    for t in range(0, 60, 2):
                        wx = int(whisk_center_x + t * math.cos(wire_angle + math.pi/2))
                        wy = int(whisk_center_y + t * math.sin(wire_angle + math.pi/2))
                        if abs(x - wx) <= 2 and abs(y - wy) <= 2:
                            r, g, b = 200, 200, 200  # Silver wire
                
                # Whisk handle
                if 735 <= x <= 755 and 340 <= y <= 420:
                    r, g, b = 139, 69, 19  # Brown handle
                
                # Add subtle AI sparkles
                sparkle_positions = [
                    (350, 200, 8), (650, 200, 6), (200, 600, 7), 
                    (800, 500, 5), (400, 800, 6), (700, 750, 7)
                ]
                
                for sx, sy, size in sparkle_positions:
                    sparkle_dist = ((x - sx) ** 2 + (y - sy) ** 2) ** 0.5
                    if sparkle_dist <= size:
                        # Create star-like sparkle
                        angle = math.atan2(y - sy, x - sx)
                        star_factor = abs(math.cos(4 * angle))
                        if sparkle_dist <= size * star_factor:
                            r, g, b = 255, 215, 0  # Gold sparkle
                
            else:
                r, g, b, a = 0, 0, 0, 0  # Transparent outside circle
            
            row.extend([r, g, b, a])
        img_data.extend(row)
    
    # Create PNG
    def write_png(filename, width, height, img_data):
        def write_chunk(f, chunk_type, data):
            f.write(struct.pack('>I', len(data)))
            f.write(chunk_type)
            f.write(data)
            crc = zlib.crc32(chunk_type + data) & 0xffffffff
            f.write(struct.pack('>I', crc))
        
        with open(filename, 'wb') as f:
            # PNG signature
            f.write(b'\x89PNG\r\n\x1a\n')
            
            # IHDR chunk
            ihdr = struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0)
            write_chunk(f, b'IHDR', ihdr)
            
            # IDAT chunk
            compressor = zlib.compressobj()
            png_data = b''
            for y in range(height):
                png_data += b'\x00'  # Filter type
                start = y * width * 4
                png_data += bytes(img_data[start:start + width * 4])
            
            compressed = compressor.compress(png_data)
            compressed += compressor.flush()
            write_chunk(f, b'IDAT', compressed)
            
            # IEND chunk
            write_chunk(f, b'IEND', b'')
    
    # Ensure directory exists
    os.makedirs('assets/icons', exist_ok=True)
    
    # Write the PNG file
    write_png('assets/icons/app_icon_1024.png', width, height, img_data)
    print('Kitchen tools app icon created: assets/icons/app_icon_1024.png')

if __name__ == '__main__':
    create_kitchen_tools_icon()