Class SportClub.Coach Extends %Persistent
{

Property Name As %String;

Storage Default
{
<Data name="CoachDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^SportClub.CoachD</DataLocation>
<DefaultData>CoachDefaultData</DefaultData>
<IdLocation>^SportClub.CoachD</IdLocation>
<IndexLocation>^SportClub.CoachI</IndexLocation>
<StreamLocation>^SportClub.CoachS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod DeleteCoach(ID As %Integer) As %Status
{
    set result = ##class(SportClub.Coach).%DeleteId(ID)
    Return result
}

Method getCoach(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, name
	    INTO :id, :name
	    FROM SportClub.Coach
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set object = {"id": (id), "name": (name)}
    do data.%Push(object)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
