Write-Host "=== Neural-Nexus Instruction Simulator (Software Model) ===" -ForegroundColor Cyan
# 模擬硬體的混合算法 (Golden Model)
function Hardware-Blend ($bg, $fg, $mask) {
    # 這是硬體的運算公式: (x + (x>>8)) >> 8
    $inv_mask = 255 - $mask
    $term_a = $bg * $mask
    $term_b = $fg * $inv_mask
    $sum = $term_a + $term_b
    # 四捨五入與誤差補償
    $sum_rounded = $sum + 128
    # 注意: PowerShell 的位移運算需要括號
    $sum_adjusted = $sum_rounded + ($sum_rounded -shr 8)
    $result = ($sum_adjusted -shr 8)
    return $result
}
# 設定測試數據 (模擬 32-bit 暫存器)
# Background: 100 (0x64), Foreground: 200 (0xC8)
# Mask: 128, 128, 0, 255
$rs1_vals = @(100, 100, 100, 100)
$rs2_vals = @(200, 200, 200, 200)
$mask_vals = @(255, 0, 128, 128) # 注意順序: Byte0, Byte1, Byte2, Byte3
Write-Host "`n[CPU] Executing NN.BLEND..." -ForegroundColor Yellow
# 模擬 SIMD 平行運算
for ($i = 0; $i -lt 4; $i++) {
    $bg = $rs1_vals[$i]
    $fg = $rs2_vals[$i]
    $m  = $mask_vals[$i]
    # 呼叫模擬函數
    $res = Hardware-Blend $bg $fg $m
    Write-Host "    -> Lane $i : BG=$bg, FG=$fg, Mask=$m => Result=$res"
}
Write-Host "`n[Check] Validating Results..."
# 預期結果: 100, 200, 150, 150
if ((Hardware-Blend 100 200 128) -eq 150) {
    Write-Host "[PASS] Algorithm Logic is Correct!" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Algorithm Logic Mismatch!" -ForegroundColor Red
}
