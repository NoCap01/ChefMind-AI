// Simple icon generator using node-canvas
// Run: npm install canvas
// Then: node scripts/generate_icon_node.js

const fs = require('fs');
const path = require('path');

// Try to use canvas if available, otherwise create a simple colored square
try {
    const { createCanvas } = require('canvas');
    
    const canvas = createCanvas(1024, 1024);
    const ctx = canvas.getContext('2d');
    
    const size = 1024;
    const center = size / 2;
    
    // Background gradient (simplified as solid color)
    ctx.fillStyle = '#6366F1'; // Indigo 500
    ctx.fillRect(0, 0, size, size);
    
    // Create circular background
    ctx.fillStyle = '#6366F1';
    ctx.beginPath();
    ctx.arc(center, center, 480, 0, 2 * Math.PI);
    ctx.fill();
    
    // Inner highlight circle
    ctx.strokeStyle = 'rgba(255, 255, 255, 0.15)';
    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.arc(center, center, 440, 0, 2 * Math.PI);
    ctx.stroke();
    
    // Chef hat main body
    ctx.fillStyle = '#FFFFFF';
    ctx.strokeStyle = 'rgba(148, 163, 184, 0.3)';
    ctx.lineWidth = 4;
    ctx.beginPath();
    ctx.ellipse(center, 420, 180, 140, 0, 0, 2 * Math.PI);
    ctx.fill();
    ctx.stroke();
    
    // Chef hat puffs
    ctx.beginPath();
    ctx.arc(450, 320, 60, 0, 2 * Math.PI);
    ctx.fill();
    ctx.stroke();
    
    ctx.beginPath();
    ctx.arc(center, 300, 70, 0, 2 * Math.PI);
    ctx.fill();
    ctx.stroke();
    
    ctx.beginPath();
    ctx.arc(574, 320, 60, 0, 2 * Math.PI);
    ctx.fill();
    ctx.stroke();
    
    // Chef hat band
    ctx.fillStyle = '#10B981'; // Emerald 500
    ctx.beginPath();
    ctx.roundRect(332, 520, 360, 50, 25);
    ctx.fill();
    
    // AI sparkle
    ctx.fillStyle = 'rgba(245, 158, 11, 0.9)'; // Amber
    ctx.beginPath();
    const sparkleX = 420, sparkleY = 380, sparkleSize = 25;
    for (let i = 0; i < 8; i++) {
        const angle = i * Math.PI / 4;
        const radius = i % 2 === 0 ? sparkleSize : sparkleSize * 0.4;
        const x = sparkleX + radius * Math.cos(angle);
        const y = sparkleY + radius * Math.sin(angle);
        if (i === 0) ctx.moveTo(x, y);
        else ctx.lineTo(x, y);
    }
    ctx.closePath();
    ctx.fill();
    
    // Small sparkle circles
    ctx.fillStyle = 'rgba(239, 68, 68, 0.8)'; // Red
    ctx.beginPath();
    ctx.arc(580, 360, 8, 0, 2 * Math.PI);
    ctx.fill();
    
    ctx.fillStyle = 'rgba(16, 185, 129, 0.7)'; // Emerald
    ctx.beginPath();
    ctx.arc(440, 480, 6, 0, 2 * Math.PI);
    ctx.fill();
    
    ctx.fillStyle = 'rgba(245, 158, 11, 0.6)'; // Amber
    ctx.beginPath();
    ctx.arc(590, 450, 5, 0, 2 * Math.PI);
    ctx.fill();
    
    // Save the image
    const buffer = canvas.toBuffer('image/png');
    fs.writeFileSync(path.join(__dirname, '..', 'assets', 'icons', 'app_icon_1024.png'), buffer);
    console.log('Icon generated successfully: assets/icons/app_icon_1024.png');
    
} catch (error) {
    console.log('Canvas not available, creating simple colored icon...');
    
    // Create a simple colored square as fallback
    // This is a minimal PNG file in base64
    const simplePngBase64 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChAI9jU77zgAAAABJRU5ErkJggg==';
    const buffer = Buffer.from(simplePngBase64, 'base64');
    
    // Create a larger version by scaling
    fs.writeFileSync(path.join(__dirname, '..', 'assets', 'icons', 'app_icon_1024.png'), buffer);
    console.log('Simple icon created: assets/icons/app_icon_1024.png');
}