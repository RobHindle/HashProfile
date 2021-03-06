﻿# Hash Profile from Manifest
<#
Confirmation that a file has not been tampered with is easiest done with an independantly provided hash value.
To ensure that it is a Non-Collision match, the use of 3 different has functions provides mitigation of this.

Disclaimer:  
        Hash Profiling only confirms that a file has not been tampered with.  It does not provide
        confirmation that a tool or script works as you intend only that it will work as delivered.       

Author:  Rob Hindle  2021-01-25

Internal/Souce Usage: 
        1) Make a Manifest text file with the list of files you desire to provide confirmation for.
        2) Either move this file into the HashManifest.txt location
        or
        enter the necessary path manifest file name when prompted
        3) Run the script
        4) Use the contents of the text file "HashProfile<Date-Time>.txt for your reference.
            This should be in the GIT ReadMe.txt file as well as an independant URL reference point.

External Usage:  
        1)Move the desired GIT file files to an isolation area and perform independant Hash functions 
        of the same types on the files.
        2) Confirm the three Hash Value match for each file.
            3.1) If they DO Match - You have some comfort of a correct transfer.
            3.2) If they DO NOT Match - Destroy one or more of the files out of your isolation area.

Notes:  1) This HashProfile information should be in the Readme.txt file of the GIT Project with a reference
        to an independant URL where these Hash values can be confirmed.
        2) Submission of these confirmation Hash values or internally generated ones should be provided for 
        the Whitelisting and Configuration addition of these tools to your environment.
        3) Some match between date of Hash Vlue production and the File dates is another check. 

#>
<# HasH value Profiler
.Synopsis
    Provides three File Hash values on file for independant verification that it was not tampered with.
.Description
    Uses MD5, SHA256 and SHA512 has forms on each file of a prepared manifest and pushes this to a working file.
.Parameter
    A Hash Manifest text file is used to list the specific files 
.Example
    .\HashManifest.txt is prepared
    HashProfile.ps1 is run
    HashProfile<date-Time>.txt is produced.
#>
$HashAlg = @("MD5","SHA256","SHA512")
$tdy = Get-date -Format "yyyyMMdd-HHmm"
$HashProfile = "$PSScriptRoot\HashProfile$tdy.txt"

$FileManifest = read-host -Prompt "Enter in the manifest path"
if ($FileManifest.length -eq 0) { $FileManifest = "$PSScriptRoot\HashManifest.txt" }
$GC = Get-Content -Path $FileManifest

foreach ($file in $GC){
   $FileName = $file.Substring($($file.LastIndexOf("\")+1))
   "$FileName produced $tdy"
   "$FileName produced $tdy" >> $HashProfile
   "FileName  HashType  HashValue"
   "FileName  HashType  HashValue" >> $HashProfile
   Foreach ($alg in $HashAlg) {
      $GFH = get-filehash -Path $file -Algorithm $alg
      "$FileName $($GFH.Algorithm) $($GFH.Hash)"
      "$FileName $($GFH.Algorithm) $($GFH.Hash)" >> $HashProfile
   }
}
