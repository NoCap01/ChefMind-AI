#!/usr/bin/env python3
"""
Create a clean, simple kitchen icon with minimal tools
"""
import struct
import zlib
import os
import math

def create_clean_kitchen_icon():
    """Create a 1024x1024 PNG icon with simple kitchen tools"""
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
                
                # Simple crossed utensils design
                
                # Spoon (left diagonal)
                # Spoon bowl
                spoon_bowl_x, spoon_bowl_y = 350, 350
                if (x - spoon_bowl_x) ** 2 + (y - spoon_bowl_y) ** 2 <= 1200:  # Circle
                    r, g, b = 255, 255, 255  # White
                
                # Spoon handle (diagonal line)
                for t in range(100):
                    handle_x = spoon_bowl_x + t * 2
                    handle_y = spoon_bowl_y + t * 2
                    if abs(x - handle_x) <= 12 and abs(y - handle_y) <= 12:
                        r, g, b = 255, 255, 255  # White
                
                # Fork (right diagonal)
                fork_base_x, fork_base_y = 674, 350
                
                # Fork tines
                for tine_offset in [-20, -7, 7, 20]:
                    tine_x = fork_base_x + tine_offset
                    for t in range(60):
                        ty = fork_base_y - t
                        if abs(x - tine_x) <= 4 and abs(y - ty) <= 4:
                            r, g, b = 255, 255, 255  # White
                
                # Fork handle (diagonal line)
                for t in range(100):
                    handle_x = fork_base_x - t * 2
                    handle_y = fork_base_y + t * 2
                    if abs(x - handle_x) <= 12 and abs(y - handle_y) <= 12:
                        r, g, b = 255, 255, 255  # White
                
                # Central chef hat (simple)
                hat_x, hat_y = center_x, center_y - 50
                
                # Hat main body (ellipse)
                hat_dx = x - hat_x
                hat_dy = y - hat_y
                if (hat_dx * hat_dx) / 10000 + (hat_dy * hat_dy) / 6400 <= 1:
                    r, g, b = 255, 255, 255  # White
                
                # Hat puff (circle on top)
                puff_dx = x - hat_x
                puff_dy = y - (hat_y - 80)
                if puff_dx * puff_dx + puff_dy * puff_dy <= 2500:
                    r, g, b = 255, 255, 255  # White
                
                # Hat band
                if hat_y + 60 <= y <= hat_y + 90 and abs(hat_dx) <= 100:
                    r, g, b = 16, 185, 129  # Emerald green
                
                # Add subtle sparkles
                sparkle_positions = [
                    (300, 250), (724, 250), (200, 700), (824, 700)
                ]
                
                for sx, sy in sparkle_positions:
                    if abs(x - sx) <= 6 and abs(y - sy) <= 6:
                        sparkle_dist = ((x - sx) ** 2 + (y - sy) ** 2) ** 0.5
                        if sparkle_dist <= 4:
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
    print('Clean kitchen icon created: assets/icons/app_icon_1024.png')

if __name__ == '__main__':
    create_clean_kitchen_icon()