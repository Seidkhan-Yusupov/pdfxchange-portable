# PDF-XChange Editor 11.1.1.0 x64 portable, No OCR.
# No installation, shell integration, startup entries, or admin access.
$ErrorActionPreference = 'Stop'

$DownloadUrl = 'https://downloads.pdf-xchange.com/11.1.1.0/PXCEditor11_Portable_x64_NoOCR.zip'
$ExpectedSha256 = '9F79A6687BB2CBFDF2DE9565EB8CAD8FA2BDBCF85853A909F14ABF556DAF5D51'

if (-not [Environment]::Is64BitOperatingSystem) {
    throw 'This package requires 64-bit Windows.'
}

$SessionPath = Join-Path ([System.IO.Path]::GetTempPath()) ('pdfxchange-session-' + [guid]::NewGuid().ToString('N'))
$ArchivePath = Join-Path $SessionPath 'PDFXChange-no-ocr.zip'
$AppPath = Join-Path $SessionPath 'app'

New-Item -ItemType Directory -Path $SessionPath -Force | Out-Null
try {
    Write-Host 'Downloading official PDF-XChange Editor portable (x64, no OCR)...'
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $ArchivePath -UseBasicParsing

    $ActualSha256 = (Get-FileHash -LiteralPath $ArchivePath -Algorithm SHA256).Hash
    if ($ActualSha256 -ne $ExpectedSha256) {
        throw "Unexpected download checksum: $ActualSha256. Launch cancelled."
    }

    Expand-Archive -LiteralPath $ArchivePath -DestinationPath $AppPath
    $Executables = @(Get-ChildItem -LiteralPath $AppPath -Recurse -File -Filter 'PXCEditor.exe')
    if ($Executables.Count -ne 1) {
        throw "Expected one PDFXEdit.exe in the portable package; found $($Executables.Count)."
    }

    Write-Host 'Opening PDF-XChange Editor...'
    Write-Host 'It should use built-in English (US) on first launch.'
    Write-Host 'If needed: File > Preferences > Languages > English (US), Built-In.'
    Write-Host 'SAVE your documents outside the temporary application folder.'
    Write-Host 'Keep this PowerShell window open, close PDF-XChange to clean up.'

    # -Wait waits for the editor and its child processes to finish.
    Start-Process -FilePath $Executables[0].FullName -WorkingDirectory $Executables[0].DirectoryName -Wait
}
finally {
    try {
        Remove-Item -LiteralPath $SessionPath -Recurse -Force -ErrorAction Stop
        Write-Host 'Portable application files removed.'
    }
    catch {
        Write-Warning "Automatic cleanup could not finish. Remove this session folder later: $SessionPath"
        Write-Warning $_.Exception.Message
    }
}
