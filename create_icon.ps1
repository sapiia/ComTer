# Create a simple computer monitor icon
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

$size = 512
$image = New-Object System.Drawing.Bitmap($size, $size)
$graphics = [System.Drawing.Graphics]::FromImage($image)

$graphics.Clear([System.Drawing.Color]::White)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

# Create brushes and pens
$blueBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(52, 152, 219))
$whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$grayBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(149, 165, 166))
$blackPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(44, 62, 80), 4)

# Draw monitor frame
$rect = New-Object System.Drawing.RectangleF(60, 80, 392, 280)
$graphics.FillRectangle($blueBrush, $rect)
$graphics.DrawRectangle($blackPen, $rect.X, $rect.Y, $rect.Width, $rect.Height)

# Draw screen
$screenRect = New-Object System.Drawing.RectangleF(75, 100, 362, 240)
$graphics.FillRectangle($whiteBrush, $screenRect)

# Draw stand
$standRect = New-Object System.Drawing.RectangleF(220, 370, 72, 80)
$graphics.FillRectangle($grayBrush, $standRect)
$graphics.DrawRectangle($blackPen, $standRect.X, $standRect.Y, $standRect.Width, $standRect.Height)

# Draw base
$baseRect = New-Object System.Drawing.RectangleF(180, 450, 152, 30)
$graphics.FillRectangle($grayBrush, $baseRect)
$graphics.DrawRectangle($blackPen, $baseRect.X, $baseRect.Y, $baseRect.Width, $baseRect.Height)

$image.Save("c:\Users\TUF\Desktop\untitled-\assets\icon.png")
$graphics.Dispose()
$image.Dispose()

Write-Host "Computer icon created successfully at c:\Users\TUF\Desktop\untitled-\assets\icon.png"
