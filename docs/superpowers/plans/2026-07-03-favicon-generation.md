# Favicon Generation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Generate a high-quality multi-resolution `favicon.ico` file from `assets/story_collage.png` and link it inside `index.html`.

**Architecture:** A native PowerShell script will be written to load the .NET `System.Drawing` assembly, resize the source PNG image to standard dimensions (16x16, 32x32, 48x48, 64x64), pack them into a standard ICO file format using PNG streams, and save it in the root directory. Finally, `index.html` will be updated to link to this favicon.

**Tech Stack:** PowerShell, .NET `System.Drawing`, HTML5.

## Global Constraints
- Input file: [story_collage.png](file:///f:/secret_project/spacial_love_bd/assets/story_collage.png)
- Output file: `favicon.ico`
- Target page: [index.html](file:///f:/secret_project/spacial_love_bd/index.html)

---

### Task 1: Create Favicon Generator Script and Generate Favicon

**Files:**
- Create: [generate_favicon.ps1](file:///f:/secret_project/spacial_love_bd/tools/generate_favicon.ps1)

**Interfaces:**
- Consumes: [story_collage.png](file:///f:/secret_project/spacial_love_bd/assets/story_collage.png)
- Produces: `favicon.ico` in the project root directory.

- [ ] **Step 1: Create the generator script**

Write the script code to [generate_favicon.ps1](file:///f:/secret_project/spacial_love_bd/tools/generate_favicon.ps1):

```powershell
Add-Type -AssemblyName System.Drawing

$sourcePath = "f:\secret_project\spacial_love_bd\assets\story_collage.png"
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
    $w.Write([byte]($size -eq 256 ? 0 : $size)) # Width
    $w.Write([byte]($size -eq 256 ? 0 : $size)) # Height
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
```

- [ ] **Step 2: Run the script to generate the favicon**

Run the script:
```powershell
powershell -ExecutionPolicy Bypass -File tools/generate_favicon.ps1
```
Expected output:
`Successfully generated favicon.ico at f:\secret_project\spacial_love_bd\favicon.ico`

- [ ] **Step 3: Verify the output file exists and is not empty**

Run:
```powershell
Test-Path f:\secret_project\spacial_love_bd\favicon.ico
(Get-Item f:\secret_project\spacial_love_bd\favicon.ico).Length -gt 0
```
Expected output:
`True`
`True`

- [ ] **Step 4: Commit script and generated icon**

Run:
```bash
git add tools/generate_favicon.ps1 favicon.ico
git commit -m "feat: add favicon generation script and generate favicon.ico"
```

---

### Task 2: Update index.html to link the favicon

**Files:**
- Modify: [index.html](file:///f:/secret_project/spacial_love_bd/index.html) (add link to head)

**Interfaces:**
- Consumes: `favicon.ico` in the root directory.
- Produces: Updated website markup referencing the favicon.

- [ ] **Step 1: Modify index.html to add link element**

In [index.html](file:///f:/secret_project/spacial_love_bd/index.html) around line 9, add the `<link rel="icon" ...>` tag.

Before:
```html
    <link rel="stylesheet" href="styles.css">
</head>
```

After:
```html
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/x-icon" href="favicon.ico">
</head>
```

- [ ] **Step 2: Verify index.html changes**

Verify index.html contains the favicon tag.
Run:
```powershell
Select-String -Path f:\secret_project\spacial_love_bd\index.html -Pattern "favicon.ico"
```
Expected output:
`<link rel="icon" type="image/x-icon" href="favicon.ico">`

- [ ] **Step 3: Commit frontend changes**

Run:
```bash
git add index.html
git commit -m "feat: link favicon.ico in index.html head"
```
