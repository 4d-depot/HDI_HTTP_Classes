// This button performs an asynchronous loading of the icons by usinbg callbacks.

// We send requests to get the weather of each city.
// The HTTPOptions objects contain the callbacks to handle the requests.

var $cities : Collection
var $baseURL; $URL; $city : Text
var $options : Object
var $request : 4D:C1709.HTTPRequest
var $traceIntoCode : Boolean

$baseURL:="https://api.weatherapi.com/v1/current.json?key=0069f55b02b6464586b121250222206&aqi=no&q="
$cities:=New collection:C1472("Paris"; "Lille"; "Lyon"; "Strasbourg"; "Marseilles"; "Perpignan"; "Toulouse"; "Bordeaux"; "Brest"; "Nantes"; "Orleans"; "Clermont-Ferrand"; "Ajaccio")

$traceIntoCode:=(OBJECT Get value:C1743("traceIntoCode")=1)
If ($traceIntoCode)
	TRACE:C157
End if 

For each ($city; $cities)
	
	$options:=cs:C1710.HTTPOptions.new($city; $traceIntoCode)
	$URL:=$baseURL+$city
	$request:=4D:C1709.HTTPRequest.new($url; $options)
	
End for each 