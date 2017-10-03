$filename = "bearout.jpg";
$offset = 10;
$bytes = [System.IO.File]::readallbytes($filename);
[array]$base64characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".ToCharArray();
#$encodedsectext = [convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($sectext));
 $sos=0;
 $sosflag=$false;
 for($i=0; $i -lt $bytes.length; $i++){
        if(($bytes[$i]-eq 255)-and($bytes[$i+1] -eq 218)){
            $sos = $i;
            $sosflag = $true;
            echo $sos;
            }
        if(($sosflag)-and($bytes[$i] -ne 64)-and($i -gt $sos+$offset)-and($bytes[$i] -lt 64)){
            write-host $base64characters[$bytes[$i]] -NoNewLine;
        }
        if(($sosflag)-and($bytes[$i] -eq 64)){
            $sosflag = $false;
        }
     }
