// This button performs an asynchronous parallel loading of the icons.

// We first send requests to get the weather for all the cities.
// When we receive the responses, we then send requests to get the weather icons for all the cities.
// We then display the weather icons we received on the map.
// In case of error we display a question mark instead of the weather icon.

var $cities; $weatherRequests; $iconRequests : Collection
var $baseURL; $URL; $iconURL; $city : Text
var $result; $file : Object
var $request; $iconRequest : 4D:C1709.HTTPRequest
var $image : Blob

$baseURL:="https://api.weatherapi.com/v1/current.json?key=0069f55b02b6464586b121250222206&aqi=no&q="
$cities:=New collection:C1472("Paris"; "Lille"; "Lyon"; "Strasbourg"; "Marseilles"; "Perpignan"; "Toulouse"; "Bordeaux"; "Brest"; "Nantes"; "Orleans"; "Clermont-Ferrand"; "Ajaccio")
$weatherRequests:=New collection:C1472()
$iconRequests:=New collection:C1472()

If (OBJECT Get value:C1743("traceIntoCode")=1)
	TRACE:C157
End if 

For each ($city; $cities)
	
	$URL:=$baseURL+$city
	$request:=4D:C1709.HTTPRequest.new($url)
	$weatherRequests.push($request)
	
End for each 

For each ($request; $weatherRequests)
	
	While (Not:C34($request.terminated))
		// Code I can execute while waiting for the request.
		// If I don't have code to execute, I can replace the while by $request.wait()
	End while 
	
	If (($request.response#Null:C1517) && ($request.response.status=200))
		$result:=$request.response.body
		$iconURL:=Substring:C12($result.current.condition.icon; 3)
		
		$iconRequest:=4D:C1709.HTTPRequest.new($iconURL)
		$iconRequest.city:=$request.city
		$iconRequests.push($iconRequest)
		
	Else 
		$iconRequests.push(Null:C1517)
	End if 
	
End for each 

For ($index; 0; $iconRequests.length-1)
	
	$request:=$iconRequests[$index]
	
	If ($request#Null:C1517)
		While (Not:C34($request.terminated))
			// Code I execute while waiting for the request.
			// If I don't have code to execute, I can replace the while by $request.wait()
		End while 
		
		If (($request.response#Null:C1517) && ($request.response.status=200))
			$file:=File:C1566("/RESOURCES/images/"+$cities[$index]+".png")
			$file.delete()
			$image:=$request.response.body
			
			$file.create()
			$file.setContent($image)
			OBJECT SET VISIBLE:C603(*; $cities[$index]; True:C214)
		Else 
			ReplaceIconWithQuestionMark($cities[$index])
		End if 
	Else 
		ReplaceIconWithQuestionMark($cities[$index])
	End if 
	
End for 