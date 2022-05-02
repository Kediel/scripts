# Check for if the file exists in defined path.
#Test-Path -Path "C:\Users\...\Box\SSC CNI Drive\MMSC\etc_hosts_analysis.xlsx" -PathType Leaf



$filename = Get-childItem "C:\Users\...\Box\SSC CNI Drive\MMSC\etc_hosts_analysis.xlsx"
$sheetName = "etc_hosts updates only"

$objExcel = New-Object -ComObject Excel.Application
$WorkBook = $objExcel.Workbooks.Open($filename)
$sheet = $WorkBook.Worksheets.Item($sheetName)
 $objExcel.visible = $false
 $objExcel.DisplayAlerts = $false

$rowMax = $sheet.usedRange.Rows.Count
$success = 0
$failed = 0

try{
    
    for ($i=2; $i -le $rowMax; $i++){
    
        $hosts = $objExcel.Columns.Item(1).Rows.Item($i).Text
        Write-Host "Pinging(Host #$i): $hosts" # Prints output
         
        if ( Test-Connection $hosts -Count 2 -Delay 1 -Quiet ) {
                
                Write-Host "$hosts - Success"
                $success++
                
            } else {
                
                Write-Host "$hosts - Failed"
                $failed++
            }
     }
} catch {

    Write-Warning "Ping Failed: $hosts"
    <#Write-Warning "Error message: $_"

     if ( $errorlog ) {

                $errormsg = $_.ToString()
                $exception = $_.Exception
                $stacktrace = $_.ScriptStackTrace
                $failingline = $_.InvocationInfo.Line
                $positionmsg = $_.InvocationInfo.PositionMessage
                $pscommandpath = $_.InvocationInfo.PSCommandPath
                $failinglinenumber = $_.InvocationInfo.ScriptLineNumber
                $scriptname = $_.InvocationInfo.ScriptName

                Write-Verbose "Start writing to Error log."
                Write-ErrorLog -hostname $computer -env $env -logicalname $logicalname -errormsg $errormsg -exception $exception -scriptname $scriptname -failinglinenumber $failinglinenumber -failingline $failingline -pscommandpath $pscommandpath -positionmsg $pscommandpath -stacktrace $stacktrace
                Write-Verbose "Finish writing to Error log."
            } #>
}

Write-Host "In total there were $success successful and $failed failed pings."

$objExcel.quit()
