Write-Host "=== Neural-Nexus Image Generator ===" -ForegroundColor Cyan
# PGM 圖片格式寫入函數
function Write-PGM ($filename, $width, $height, $data) {
    $header = "P2`n$width $height`n255`n"
    $content = $header + ($data -join " ")
    Set-Content -Path $filename -Value $content -Encoding Ascii
}
$W = 64
$H = 64
$bg_data = @()
$fg_data = @()
$out_data = @()
# 模擬硬體混合函數
function Hardware-Blend ($bg, $fg, $mask) {
    $sum_rounded = ($bg * $mask) + ($fg * (255 - $mask)) + 128
    return ($sum_rounded + ($sum_rounded -shr 8)) -shr 8
}
Write-Host "Generating 64x64 Pixels..."
for ($y = 0; $y -lt $H; $y++) {
    for ($x = 0; $x -lt $W; $x++) {
        # 1. 產生背景 (BG): 垂直條紋 (每 8 像素黑白交替)
        $bg = if (($x / 8) % 2 -eq 0) { 50 } else { 200 }
        # 2. 產生前景 (FG): 中央有一個白色圓形
        $dx = $x - 32
        $dy = $y - 32
        $dist = [Math]::Sqrt($dx*$dx + $dy*$dy)
        $fg = if ($dist -lt 20) { 255 } else { 0 }
        # 3. 設定 Mask (透明度): 圓形區域設為 50% 透明 (128)，其他全透 (0)
        # 這樣我們應該會看到背景條紋透過圓形顯示出來
        $mask = if ($dist -lt 20) { 128 } else { 0 }
        # 4. 執行硬體混合模擬
        # 注意公式: bg * mask + fg * (255-mask)
        # 這裡我們讓前景當 "背景層"，背景當 "覆蓋層" 來模擬透明效果
        # Mask=128 (50% BG, 50% FG)
        $res = Hardware-Blend $bg $fg $mask
        $bg_data += $bg
        $fg_data += $fg
        $out_data += $res
    }
}
# 輸出圖片
Write-PGM ".\Neural-Nexus\sw\background.pgm" $W $H $bg_data
Write-PGM ".\Neural-Nexus\sw\foreground.pgm" $W $H $fg_data
Write-PGM ".\Neural-Nexus\sw\output.pgm"     $W $H $out_data
Write-Host "Images Generated at .\Neural-Nexus\sw\" -ForegroundColor Green
Write-Host "1. background.pgm (Stripes)"
Write-Host "2. foreground.pgm (Circle)"
Write-Host "3. output.pgm     (Blended Result)"
