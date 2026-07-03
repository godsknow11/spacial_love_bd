# Design: Favicon Generation from Story Collage

This design document outlines the approach for generating a high-quality multi-resolution `favicon.ico` from an existing image, `assets/story_collage.png`, and linking it to the website's header.

## Requirements & Scope
- Input file: [story_collage.png](file:///f:/secret_project/spacial_love_bd/assets/story_collage.png) (1024x1024 px)
- Output file: `favicon.ico` in the root directory containing 16x16, 32x32, 48x48, and 64x64 pixel sizes.
- Target page: [index.html](file:///f:/secret_project/spacial_love_bd/index.html) to link the icon.
- Technical constraint: Since Python/Node.js are not on the system PATH, we will use a native PowerShell script loading .NET `System.Drawing` to perform the image scaling and ICO encoding.

## Proposed Changes

### Runtimes & Scripts

#### [NEW] [generate_favicon.ps1](file:///f:/secret_project/spacial_love_bd/tools/generate_favicon.ps1)
A PowerShell script that will:
1. Load `System.Drawing` assembly.
2. Read the source PNG image `assets/story_collage.png`.
3. Resize the image into 16x16, 32x32, 48x48, and 64x64 dimensions using high-quality bicubic interpolation.
4. Pack these images into a single `favicon.ico` file in the root directory.

### Frontend

#### [MODIFY] [index.html](file:///f:/secret_project/spacial_love_bd/index.html)
Add the icon reference in the `<head>` of the page:
```html
<link rel="icon" type="image/x-icon" href="favicon.ico">
```

## Verification Plan

### Manual Verification
- Run the PowerShell script [generate_favicon.ps1](file:///f:/secret_project/spacial_love_bd/tools/generate_favicon.ps1) and verify that `favicon.ico` is generated in the root.
- Verify `index.html` renders properly and references the new favicon.
- Open `index.html` in the browser or inspect metadata to verify.
