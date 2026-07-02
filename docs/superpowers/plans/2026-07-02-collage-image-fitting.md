# Square Story Collage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Generate a new 1:1 square story collage image, split it into 4 square chapter images using a PowerShell script, and verify that the split images fit the 1:1 polaroid frame layout perfectly.

**Architecture:** 
1. Use `generate_image` to generate a 1:1 square image based on the original collage.
2. Write a PowerShell script using .NET `System.Drawing` to load the collage, crop it into four 1:1 equal quadrants, and save them over the existing chapter images in `assets/`.
3. Verify the generated images are square and fit the page.

**Tech Stack:** `generate_image` tool, PowerShell, .NET `System.Drawing`

## Global Constraints
- Target collage aspect ratio: 1:1 (square, e.g. 1024x1024).
- Quadrant split outputs must be 1:1 square.
- Avoid installing external software (like Node/Python/Pillow) because they are missing from the system; use native PowerShell/.NET.

---

### Task 1: Generate Square Collage Image

**Files:**
- Modify: `assets/story_collage.png` (Overwrite/Replace)

**Interfaces:**
- Consumes: original `f:\secret_project\spacial_love_bd\assets\story_collage.png`
- Produces: new square `f:\secret_project\spacial_love_bd\assets\story_collage.png`

- [ ] **Step 1: Generate square collage**
  Call the `generate_image` tool with the prompt:
  "A beautiful cute hand-drawn style 2x2 grid collage image, in a 1:1 square aspect ratio (e.g. 1024x1024), containing four panels matching the style, colors, and characters of the input image. Keep Panel 1 (Top Left) as a couple sharing a pink umbrella in the rain, Panel 2 (Top Right) as a cozy couple caring during sickness, Panel 3 (Bottom Left) as a romantic starry night sky engagement, and Panel 4 (Bottom Right) as a couple celebrating a 26th birthday. Ensure that each of the four panels is itself a perfect square (1:1 aspect ratio) so they split evenly."
  Pass the path to `f:\secret_project\spacial_love_bd\assets\story_collage.png` in `ImagePaths`. Set the `ImageName` to `story_collage`.
  Save the generated image to `f:\secret_project\spacial_love_bd\assets\story_collage.png`.

- [ ] **Step 2: Verify collage is square**
  Run this PowerShell command to print the dimensions of the new collage:
  `[Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null; $img = [System.Drawing.Image]::FromFile("f:\secret_project\spacial_love_bd\assets\story_collage.png"); write-host "size: $($img.Width)x$($img.Height)"; $isSquare = ($img.Width -eq $img.Height); write-host "Is Square: $isSquare"; $img.Dispose(); if (-not $isSquare) { throw "Collage is not square!" }`
  Expected Output: size: 1024x1024 (or another 1:1 resolution), Is Square: True.

---

### Task 2: Create PowerShell Image Splitting Script

**Files:**
- Create: `tools/split_story_image.ps1`

**Interfaces:**
- Consumes: `f:\secret_project\spacial_love_bd\assets\story_collage.png`
- Produces: 
  - `f:\secret_project\spacial_love_bd\assets\story_chapter_01.png`
  - `f:\secret_project\spacial_love_bd\assets\story_chapter_02.png`
  - `f:\secret_project\spacial_love_bd\assets\story_chapter_03.png`
  - `f:\secret_project\spacial_love_bd\assets\story_chapter_04.png`

- [ ] **Step 1: Write the split script**
  Create the file `tools/split_story_image.ps1` with the following code to crop the collage into four equal quadrants and save them:
  ```powershell
  # tools/split_story_image.ps1
  [Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
  $collagePath = "f:\secret_project\spacial_love_bd\assets\story_collage.png"
  $outDir = "f:\secret_project\spacial_love_bd\assets"
  
  if (-not (Test-Path $collagePath)) {
      throw "Input collage file not found at $collagePath"
  }
  
  $src = [System.Drawing.Image]::FromFile($collagePath)
  $w = [int]($src.Width / 2)
  $h = [int]($src.Height / 2)
  
  $quadrants = @(
      @{ Name = "story_chapter_01.png"; X = 0; Y = 0 },
      @{ Name = "story_chapter_02.png"; X = $w; Y = 0 },
      @{ Name = "story_chapter_03.png"; X = 0; Y = $h },
      @{ Name = "story_chapter_04.png"; X = $w; Y = $h }
  )
  
  foreach ($q in $quadrants) {
      $bmp = New-Object System.Drawing.Bitmap($w, $h)
      $graph = [System.Drawing.Graphics]::FromImage($bmp)
      
      # Set high quality settings
      $graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
      $graph.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
      
      $srcRect = New-Object System.Drawing.Rectangle($q.X, $q.Y, $w, $h)
      $destRect = New-Object System.Drawing.Rectangle(0, 0, $w, $h)
      
      $graph.DrawImage($src, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
      
      $outPath = Join-Path $outDir $q.Name
      $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
      
      $graph.Dispose()
      $bmp.Dispose()
      
      Write-Host "Generated: $outPath"
  }
  
  $src.Dispose()
  Write-Host "Successfully split the collage into 4 chapter images!"
  ```

- [ ] **Step 2: Run the script to split the images**
  Run: `powershell -File f:\secret_project\spacial_love_bd\tools\split_story_image.ps1`
  Expected Output: Success message and 4 output paths generated.

---

### Task 3: Verify the Output Chapter Images

- [ ] **Step 1: Check sizes of the chapter images**
  Run this PowerShell command to load the four output files and verify they are all square (Width = Height):
  ```powershell
  [Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
  $files = @("story_chapter_01.png", "story_chapter_02.png", "story_chapter_03.png", "story_chapter_04.png")
  foreach ($f in $files) {
      $path = "f:\secret_project\spacial_love_bd\assets\$f"
      $img = [System.Drawing.Image]::FromFile($path)
      $isSquare = ($img.Width -eq $img.Height)
      Write-Host "$f size: $($img.Width)x$($img.Height) (Is Square: $isSquare)"
      $img.Dispose()
      if (-not $isSquare) { throw "$f is not square!" }
  }
  ```
  Expected Output: All 4 images printed as square.
