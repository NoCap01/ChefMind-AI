#!/usr/bin/env python3
"""
Create the ChefMind logo as PNG
"""
import struct
import zlib
import os
import math

def create_chefmind_logo():
    """Create a 200x200 PNG logo matching the design"""
    width, height = 200, 200
    
    # Create image data (RGBA)
    img_data = []
    
    for y in range(height):
        row = []
        for x in range(width):
            # Default transparent
            r, g, b, a = 0, 0, 0, 0
            
            # Chef hat main shape (rounded rectangle-like)
            center_x, center_y = 100, 100
            
            # Main hat body
            if 25 <= x <= 175 and 50 <= y <= 180:
                # Create rounded chef hat shape
                dx = x - center_x
                dy = y - center_y
                
                # Elliptical chef hat
                if (dx * dx) / 6400 + ((dy - 10) * (dy - 10)) / 4900 <= 1:
                    # Gradient from emerald to sky blue
                    ratio = (x + y) / (width + height)
                    r = int(16 + (14 - 16) * ratio)      # 16 -> 14 (emerald to sky)
                    g = int(185 + (165 - 185) * ratio)   # 185 -> 165
                    b = int(129 + (233 - 129) * ratio)   # 129 -> 233
                    a = 255
            
            # Chef hat band
            if 32 <= x <= 168 and 160 <= y <= 180:
                r, g, b, a = 255, 255, 255, 80  # Semi-transparent white
            
            # Brain pattern overlay (simplified)
            brain_patterns = [
                # Left hemisphere
                (40, 40, 15), (35, 60, 12), (45, 80, 10),
                # Right hemisphere  
                (140, 40, 15), (145, 60, 12), (135, 80, 10),
                # Central connection
                (100, 50, 18)
            ]
            
            for bx, by, radius in brain_patterns:
                if (x - bx) ** 2 + (y - by) ** 2 <= radius ** 2:
                    # Brain pattern overlay
                    if a > 0:  # Only if we're already on the hat
                        r = min(255, r + 40)
                        g = min(255, g + 40) 
                        b = min(255, b + 40)
                        a = min(255, a + 60)
            
            # Add sparkles
            sparkles = [(35, 35, 3), (150, 32, 2), (160, 65, 2.5)]
            for sx, sy, sr in sparkles:
                if (x - sx) ** 2 + (y - sy) ** 2 <= sr ** 2:
                    r, g, b, a = 255, 255, 255, 200
            
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
    os.makedirs('assets/images', exist_ok=True)
    
    # Write the PNG file
    write_png('assets/images/chefmind_logo.png', width, height, img_data)
    print('ChefMind logo created: assets/images/chefmind_logo.png')

if __name__ == '__main__':
    create_chefmind_logo()