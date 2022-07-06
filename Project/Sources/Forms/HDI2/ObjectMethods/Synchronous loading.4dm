// This button performs a synchronous loading of the icons.
// For each city:
// We first send a request to get the weather.
// When we receive the response, we then send a request to get the weather icon that we will display on the map.
// In case of error we display a question mark instead.

var $cities : Collection
var $baseURL; $URL; $iconURL; $city : Text
var $result; $file : Object
var $request : 4D:C1709.HTTPRequest
var $image : Blob

$baseURL:="https://api.weatherapi.com/v1/current.json?key=0069f55b02b6464586b121250222206&aqi=no&q="
$cities:=New collection:C1472("Paris"; "Lille"; "Lyon"; "Strasbourg"; "Marseilles"; "Perpignan"; "Toulouse"; "Bordeaux"; "Brest"; "Nantes"; "Orleans"; "Clermont-Ferrand"; "Ajaccio")

If (OBJECT Get value:C1743("traceIntoCode")=1)
	TRACE:C157
End if 

For each ($city; $cities)
	
	$file:=File:C1566("/RESOURCES/images/"+$city+".png")
	$file.delete()
	
	$URL:=$baseURL+$city
	$request:=4D:C1709.HTTPRequest.new($url).wait()
	
	If (($request.response#Null:C1517) && ($request.response.status=200))
		$result:=$request.response.body
		$iconURL:=Substring:C12($result.current.condition.icon; 3)
		
		$request:=4D:C1709.HTTPRequest.new($iconURL).wait()
		
		If (($request.response#Null:C1517) && ($request.response.status=200))
			$image:=$request.response.body
			
			$file.create()
			$file.setContent($image)
			OBJECT SET VISIBLE:C603(*; $city; True:C214)
		Else 
			ReplaceIconWithQuestionMark($city)
		End if 
	Else 
		ReplaceIconWithQuestionMark($city)
	End if 
	
End for each 