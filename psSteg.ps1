$filename = "C:\users\tst\grizzly-bears-4.jpg";
$offset = 10;
$sectext = "Secret Text is in here! and here and here!";
$bytes = [System.IO.File]::readallbytes($filename);
$encodedsectext = [convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($sectext));
[array]$base64characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".ToCharArray();
 for($i=0; $i -lt $bytes.length; $i++){
        if(($bytes[$i]-eq 255)-and($bytes[$i+1] -eq 218)){
            $sos = $i +1;
            }
         }
 for($i=0; $i -lt $encodedsectext.length; $i++){
            [char]$enctext = $encodedsectext[$i];
            $bytes[$i+$sos+$offset] = $base64characters.IndexOf($enctext);
         }

if ($enctext -ne "="){ echo " not = "; $bytes[$i+1+$sos+$offset] = 64;}
#wow is stripping last character... why??
[system.io.file]::WriteAllBytes("bearout.jpg", $bytes);
