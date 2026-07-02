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

$shave = 12
$outW = $w - (2 * $shave)
$outH = $h - (2 * $shave)

$quadrants = @(
    @{ Name = "story_chapter_01.png"; X = 0; Y = 0 },
    @{ Name = "story_chapter_02.png"; X = $w; Y = 0 },
    @{ Name = "story_chapter_03.png"; X = 0; Y = $h },
    @{ Name = "story_chapter_04.png"; X = $w; Y = $h }
)

foreach ($q in $quadrants) {
    $bmp = New-Object System.Drawing.Bitmap($outW, $outH)
    $graph = [System.Drawing.Graphics]::FromImage($bmp)
    
    # Set high quality settings
    $graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graph.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    
    $srcRect = New-Object System.Drawing.Rectangle(($q.X + $shave), ($q.Y + $shave), $outW, $outH)
    $destRect = New-Object System.Drawing.Rectangle(0, 0, $outW, $outH)
    
    $graph.DrawImage($src, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
    
    $outPath = Join-Path $outDir $q.Name
    $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    
    $graph.Dispose()
    $bmp.Dispose()
    
    Write-Host "Generated: $outPath ($outW x $outH)"
}

$src.Dispose()
Write-Host "Successfully split the collage into 4 chapter images with a $shave-pixel border shave!"
