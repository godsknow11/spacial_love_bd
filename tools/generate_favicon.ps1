Add-Type -AssemblyName System.Drawing

$sourcePath = "f:\secret_project\spacial_love_bd\assets\chibi_cats_favicon.png"
$outputPath = "f:\secret_project\spacial_love_bd\favicon.ico"

$sizes = @(16, 32, 48, 64)
$pngStreams = @()
$bmp = [System.Drawing.Bitmap]::new($sourcePath)

foreach ($size in $sizes) {
    $resized = [System.Drawing.Bitmap]::new($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($resized)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($bmp, 0, 0, $size, $size)
    $g.Dispose()
    
    $ms = [System.IO.MemoryStream]::new()
    $resized.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
    $resized.Dispose()
    $pngStreams += $ms
}
$bmp.Dispose()

# Now construct the ICO file
$fs = [System.IO.File]::Create($outputPath)
$w = [System.IO.BinaryWriter]::new($fs)

# Write ICONHEADER
$w.Write([uint16]0) # Reserved
$w.Write([uint16]1) # Type (1 = Icon)
$w.Write([uint16]$sizes.Count) # Count

# Compute offsets
$offset = 6 + (16 * $sizes.Count)

for ($i = 0; $i -lt $sizes.Count; $i++) {
    $size = $sizes[$i]
    $ms = $pngStreams[$i]
    $dataLength = $ms.Length
    
    # Write ICONDIRENTRY
    $val = if ($size -eq 256) { 0 } else { $size }
    $w.Write([byte]$val) # Width
    $w.Write([byte]$val) # Height
    $w.Write([byte]0) # Color count
    $w.Write([byte]0) # Reserved
    $w.Write([uint16]1) # Color planes
    $w.Write([uint16]32) # Bits per pixel
    $w.Write([uint32]$dataLength) # Image size in bytes
    $w.Write([uint32]$offset) # Image offset
    
    $offset += $dataLength
}

# Write PNG image data
for ($i = 0; $i -lt $sizes.Count; $i++) {
    $ms = $pngStreams[$i]
    $bytes = $ms.ToArray()
    $w.Write($bytes)
    $ms.Dispose()
}

$w.Close()
$fs.Close()
Write-Output "Successfully generated favicon.ico at $outputPath"
