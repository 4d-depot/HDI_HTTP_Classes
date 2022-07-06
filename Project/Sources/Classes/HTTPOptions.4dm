//The HTTPOptions class is used as the parameter of the HTTPRequests we send.

//It contains the callbacks called when the HTTPRequests are completed.
//The onError callback is called if an error occurs, like a connection issue for example.
//The onResponse callback is called if the request is a success. 
//In that case, we still need to check the status code to be sure the result is a success.

//To avoid creating 2 different classes, the same HTTPOption is used both for the weather request and the icon request.
//As both types of request have different success results, the onResponse callback is modified between the requests.

//In case of success to both requests, the icon is saved on the disk and used for the city associated.
//In case of error to any request, a question mark icon is used instead to indicate that we don't know the city's weather.

Class constructor($city : Text; $traceIntocode : Boolean)
	This:C1470.city:=$city
	This:C1470.traceIntoCode:=$traceIntocode
	This:C1470.onResponse:=This:C1470.weatherResponse
	
Function weatherResponse($request : 4D:C1709.HTTPRequest)
	var $result : Object
	var $iconURL : Text
	
	If (This:C1470.traceIntoCode)
		TRACE:C157
	End if 
	
	If ($request.response.status=200)
		$result:=$request.response.body
		$iconURL:=Substring:C12($result.current.condition.icon; 3)
		This:C1470.onResponse:=This:C1470.iconResponse
		
		$request:=4D:C1709.HTTPRequest.new($iconURL; This:C1470)
	Else 
		This:C1470.onError($request)
	End if 
	
Function iconResponse($request : 4D:C1709.HTTPRequest; $event : 4D:C1709.HTTP)
	var $image : Blob
	var $file : 4D:C1709.File
	
	If (This:C1470.traceIntoCode)
		TRACE:C157
	End if 
	
	If ($request.response.status=200)
		
		$image:=$request.response.body
		
		$file:=File:C1566("/RESOURCES/images/"+This:C1470.city+".png")
		$file.create()
		$file.setContent($image)
		OBJECT SET VISIBLE:C603(*; This:C1470.city; True:C214)
	Else 
		This:C1470.onError($request)
	End if 
	
Function onError($request : 4D:C1709.HTTPRequest)
	
	ReplaceIconWithQuestionMark(This:C1470.city)