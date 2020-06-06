Class SportClub.Clients Extends %Persistent
{

Property Name As %String;

Property Phone As %Decimal;

Storage Default
{
<Data name="ClientsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Phone</Value>
</Value>
</Data>
<DataLocation>^SportClub.ClientsD</DataLocation>
<DefaultData>ClientsDefaultData</DefaultData>
<IdLocation>^SportClub.ClientsD</IdLocation>
<IndexLocation>^SportClub.ClientsI</IndexLocation>
<StreamLocation>^SportClub.ClientsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod DeleteClient(ID As %Integer) As %Status
{
    set result = ##class(SportClub.Clients).%DeleteId(ID)
    Return result
}

Method getClients(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, name, phone
	    INTO :id, :name, :phone
	    FROM SportClub.Clients
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "name": (name), "phone": (phone)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
