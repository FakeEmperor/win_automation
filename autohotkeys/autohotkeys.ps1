Get-ChildItem $(Get-Location) -Filter *.ahk | 
Foreach-Object {
    Write-Host -ForegroundColor Green "Running " $_.FullName
    & $_.FullName
}