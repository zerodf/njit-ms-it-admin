# Alexander P. Levchuk, M.S.
# Written for IS 681 Group 5
# Please use only on isloated networks

$sCurrHostRange = "" # Enter your subnet Ex "196.168.1."

for ($i, $i -le 255, $i++) {
	$sCurrHost = $sCurrHostRange + $i.ToString()
	write-host "Pinging: " $sCurrHost
	if (Test-Connection $sCurrHost -quiet) {
	write-host "Success: " $sCurrHost
	}   
}
