// This button is used to clear the weather icons. It also deletes the icon from the RESOURCES/images folder.

var $cities : Collection
var $city : Text
var $file : Object

$cities:=New collection:C1472("Paris"; "Lille"; "Lyon"; "Strasbourg"; "Marseilles"; "Perpignan"; "Toulouse"; "Bordeaux"; "Brest"; "Nantes"; "Orleans"; "Clermont-Ferrand"; "Ajaccio")

If (This:C1470.traceIntoCode)
	TRACE:C157
End if 

For each ($city; $cities)
	
	OBJECT SET VISIBLE:C603(*; $city; False:C215)
	$file:=File:C1566("/RESOURCES/images/"+$city+".png")
	$file.delete()
	
End for each 