Class SportClub.Gym Extends %Persistent
{

Property Name As %String;

Storage Default
{
<Data name="GymDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^SportClub.GymD</DataLocation>
<DefaultData>GymDefaultData</DefaultData>
<IdLocation>^SportClub.GymD</IdLocation>
<IndexLocation>^SportClub.GymI</IndexLocation>
<StreamLocation>^SportClub.GymS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod DeleteGym(ID As %Integer) As %Status
{
    set result = ##class(SportClub.Gym).%DeleteId(ID)
    Return result
}

Method getGym(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, name
	    INTO :id, :name
	    FROM SportClub.Gym
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
