

function calculate_weight($value) {
    
#convert it to string
$silo=$value | Out-String
#convert it to an int from a string with base 16 (0-f  a=10 b=11 etc.)
$silo=[Convert]::ToInt32($silo.Substring(0,4),16)
 $density = 38.74;       #     // Bulk density of plastic lbs/cubic foot - Prior 36.21
 $areaOfBin = 64;        #    // SQFT Cross sectional area of bin
 $heightOfCone = 48;     #    // Height of square section in inches
 $sensorOffset = 6;      #    // Sensor DeadBand in inches
 $totalHeight = 149;      #   // Height of bin in inches
 $weightOfCone = 3077;    # I think this value is because it may be coned shape in the silo
$data=$silo;
$data/=25.4 #I don't know what 25.4 stands for
$data = ($totalHeight + $heightOfCone) - ($data - $sensorOffset) #// Set sensor offset
if ($data -lt $heightOfCone) {
    
    if (($data -gt $totalHeight + $heightOfCone) -or ($data -lt $sensorOffset)) {
        $data = 0;
        return $data;
    } else {
        $distanceFt = $data / 12                  #   //Convert to feet
        $sideLength = $distanceFt * 2                  #       //Side length for pyramid
        $volumeOfCone = (1 / 3) * ([Math]::Pow($sideLength, 2)) * $distanceFt# // 1/3 * a^2 * h
        $weight = $volumeOfCone * $density
        $data = [Math]::round($weight)
        return $data;
    }

} else {
    if (($data -gt $totalHeight + $heightOfCone) -or ($data -lt $sensorOffset)) {
        $data = 0

        return $data
    } else {
        $data -= $heightOfCone
        $distanceFt = $data / 12#//Convert to feet
        $weight = ($distanceFt * $areaOfBin * $density) + $weightOfCone
        $data = [Math]::round($weight)
        return $data
    }
}
}
#getdata funciton
function get_silo_data
{

#we are retrieving all of the silo data using invoke-restmethod then setting the url to the website with each port being each silo
try{
$silo1_response=Invoke-RestMethod -Uri "http://10.104.16.50/iolinkmaster/port[1]/iolinkdevice/pdin/getdata"
$silo2_response=Invoke-RestMethod -Uri "http://10.104.16.50/iolinkmaster/port[2]/iolinkdevice/pdin/getdata"
$silo3_response=Invoke-RestMethod -Uri "http://10.104.16.50/iolinkmaster/port[3]/iolinkdevice/pdin/getdata"
$silo4_response=Invoke-RestMethod -Uri "http://10.104.16.50/iolinkmaster/port[4]/iolinkdevice/pdin/getdata"
$silo5_response=Invoke-RestMethod -Uri "http://10.104.16.50/iolinkmaster/port[5]/iolinkdevice/pdin/getdata"
$silo6_response=Invoke-RestMethod -Uri "http://10.104.16.50/iolinkmaster/port[6]/iolinkdevice/pdin/getdata"}
catch{
return "Error: Couldn't retrieve silo data.`nPlease contact IT."
}

#setting the var silo1 to the value of the response var
$silo1=calculate_weight($silo1_response.data.value)
$silo2=calculate_weight($silo2_response.data.value)
$silo3=calculate_weight($silo3_response.data.value)
$silo4=calculate_weight($silo4_response.data.value)
$silo5=calculate_weight($silo5_response.data.value)
$silo6=calculate_weight($silo6_response.data.value)
#total is all 6 silo wieghts added together
$total=$silo1+$silo2+$silo3+$silo4+$silo5+$silo6
$body= "Silo 1: $($silo1) lbs`nSilo 2: $($silo2) lbs`nSilo 3: $($silo3) lbs`nSilo 4: $($silo4) lbs`nSilo 5: $($silo5) lbs`nSilo 6: $($silo6) lbs`nTotal: $($total) lbs"
return $body
}