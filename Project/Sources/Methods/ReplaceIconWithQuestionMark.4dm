//%attributes = {}
#DECLARE($city : Text)

var $questionMarkFile : 4D:C1709.File
$questionMarkFile:=File:C1566("/RESOURCES/images/QuestionMark.png")
$questionMarkFile.copyTo(Folder:C1567("/RESOURCES/images/"); $city+".png"; fk overwrite:K87:5)

OBJECT SET VISIBLE:C603(*; $city; True:C214)