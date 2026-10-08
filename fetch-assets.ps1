# Download F1 official media images into the local assets folder.
# Usage: powershell -ExecutionPolicy Bypass -File .\fetch-assets.ps1

$ErrorActionPreference = 'Continue'
$dir = Join-Path $PSScriptRoot 'assets'
New-Item -ItemType Directory -Force -Path $dir | Out-Null

$CDN = 'https://media.formula1.com/image/upload/'
$RD  = 'content/dam/fom-website/2018-redesign-assets/Racehub%20header%20images%2016x9/'
$V   = 'v1740000001/'

# --- key images -------------------------------------------------------------
$static = @(
  @{n='hero';     u="${CDN}t_16by9South/c_lfill,w_2000/${V}trackside-images/2026/F1_Grand_Prix_of_Canada/2278028975.webp"},
  @{n='podium';   u="${CDN}t_16by9North/c_lfill,w_1600/${V}trackside-images/2026/F1_Grand_Prix_of_Canada/2278034196.webp"},
  @{n='malaysia'; u="${CDN}t_16by9North/c_lfill,w_2000/${V}fom-website/2026/Bahrain%20(Malaysia)/GettyImages-2298517006.webp"},
  @{n='ham';      u="${CDN}c_fill,w_720/${V}common/f1/2026/ferrari/lewham01/2026ferrarilewham01right.webp"},
  @{n='ver';      u="${CDN}c_fill,w_720/${V}common/f1/2026/redbullracing/maxver01/2026redbullracingmaxver01right.webp"},
  @{n='hamcar';   u="${CDN}c_lfill,w_1600/${V}common/f1/2026/ferrari/2026ferraricarright.webp"},
  @{n='vercar';   u="${CDN}c_lfill,w_1600/${V}common/f1/2026/redbullracing/2026redbullracingcarright.webp"}
)

# --- 23 circuit shots -------------------------------------------------------
# each entry: @{ n='rNN'; path='<relative to $V>'; pre='<optional transform prefix>' }
$circuits = @(
  @{n='r01'; path="${RD}Australia.webp"},
  @{n='r02'; path="${RD}China.webp"},
  @{n='r03'; path="${RD}Japan.webp"},
  @{n='r04'; path="${RD}Miami.webp"},
  @{n='r05'; path="${RD}Canada.webp"},
  @{n='r06'; path="${RD}Monaco.webp"},
  @{n='r07'; path="${RD}Spain.webp"},
  @{n='r08'; path="${RD}Austria.webp"},
  @{n='r09'; path="${RD}Great%20Britain.webp"},
  @{n='r10'; path="${RD}Belgium.webp"},
  @{n='r11'; path="${RD}Hungary.webp"},
  @{n='r12'; path="${RD}Netherlands.webp"},
  @{n='r13'; path="${RD}Italy.webp"},
  @{n='r14'; path='fom-website/2023/Spain/IFEMA_MADRID_PRENSA_005.webp'; pre='t_16by9Centre/'},
  @{n='r15'; path="${RD}Azerbaijan.webp"},
  @{n='r16'; path='fom-website/2018-redesign-assets/Racehub%20header%20images%2016x9/Malaysia.webp'},
  @{n='r17'; path="${RD}Singapore.webp"},
  @{n='r18'; path="${RD}USA.webp"},
  @{n='r19'; path="${RD}Mexico.webp"},
  @{n='r20'; path="${RD}Brazil.webp"},
  @{n='r21'; path="${RD}Las%20Vegas.webp"},
  @{n='r22'; path="${RD}Qatar.webp"},
  @{n='r23'; path="${RD}Abu%20Dhabi.webp"}
)

$jobs = @()
foreach ($s in $static) { $jobs += @{ out = "$($s.n).webp"; url = $s.u } }
foreach ($c in $circuits) {
  $pre = if ($c.pre) { $c.pre } else { '' }
  $jobs += @{ out = "$($c.n).webp";   url = "${CDN}${pre}c_lfill,w_1600/${V}$($c.path)" }
  $jobs += @{ out = "$($c.n)_t.webp"; url = "${CDN}${pre}c_lfill,w_480/${V}$($c.path)" }
}

# --- download ---------------------------------------------------------------
$ok = 0
$fail = @()
foreach ($j in $jobs) {
  $out = Join-Path $dir $j.out
  if (Test-Path $out) { Remove-Item $out -Force }
  & curl.exe -sS -L --max-time 60 --retry 2 -A "Mozilla/5.0" -o $out $j.url 2>$null
  if ((Test-Path $out) -and (Get-Item $out).Length -gt 1024) {
    $ok++
  } else {
    $fail += $j.out
    if (Test-Path $out) { Remove-Item $out -Force }
  }
}

$sum = (Get-ChildItem $dir -File | Measure-Object -Property Length -Sum).Sum
Write-Output ("OK       : {0} / {1}" -f $ok, $jobs.Count)
Write-Output ("Size     : {0:N2} MB" -f ($sum / 1MB))
if ($fail.Count -gt 0) { Write-Output ("FAILED   : " + ($fail -join ', ')) }
else { Write-Output "FAILED   : none" }

# The two driver portraits arrive as 720x2069 full-length shots with the head at
# the top. crop-portraits.py trims them to a 3:4 head-and-shoulders frame.
$py = 'python'
Write-Output ""
Write-Output "Next: run 'python .\crop-portraits.py' to trim the two driver portraits."