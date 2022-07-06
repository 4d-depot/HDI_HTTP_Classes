//%attributes = {"invisible":true}
var Infos : Collection
var objTabs : Object

Infos:=ds:C1482.INFO.all().orderBy("PageNumber").toCollection()
objTabs:=New object:C1471("values"; Infos.extract("TabTitle"); "index"; 0)