#read file in (critical)
$bytes = [System.IO.File]::readallbytes("c:\program files\common files\microsoft shared\stationery\Bears.jpg");

#establish "secret" text (poc)
$sectext = "this is the message to be added to the image and should decode properly.";
$sectextbytes = [System.Text.Encoding]::Unicode.GetBytes($sectext);
$encodedsectext = [convert]::ToBase64String($sectextbytes);
[array]$base64characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".ToCharArray();


#convert file to hex for viewing (optional)
[string[]] $hex = @();
foreach($byte in $bytes){
$hex = $hex + [Convert]::ToString($byte, 16);
}

#replace 23rd to nth byte of secret message (poc)
#somehow the string to character array isn't comparing the characters as char but as strings?
if (($encodedsectext.length) -lt ($bytes.length - 50)){
    for($i=0; $i -lt $encodedsectext.length-1; $i++){
        $bytes[$i+23] = [array]::IndexOf($base64characters,$encodedsectext[$i]);
        echo " 1: " $bytes[$i+23] " 2: " ([array]::IndexOf($base64characters,$encodedsectext[$i]));
            }
}else{
    echo "too big!" ($bytes.Length-50) "    " $encodedsectext.Length;
} 


#write bear output jpg
[system.io.file]::WriteAllBytes("bearout.jpg", $bytes)
