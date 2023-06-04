# The function will return the value of the key from the object

function GetKeyValue {
    param (
        # The object in which the value of key needs to be searched
        [System.Collections.DictionaryEntry]
        $InputObject,
        
        # Key which will be used for search
        [string]
        $InputKey
    )
    $keys = $Key -split '/'
    $VauleforSearch = $InputObject

    foreach ($key in $keys) {
        $VauleforSearch = $VauleforSearch.$Key
    }

    return $VauleforSearch
}


$InputObject1 = {"a":{"b":{"c":"d"}}}
$InputKey1 = "a/b/c" 

$OutputValue1 = GetKeyValue -InputObject $InputObject1 -InputKey $InputKey1

Write-Host $OutputValue1
