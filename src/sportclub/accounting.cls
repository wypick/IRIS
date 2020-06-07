Class SportClub.Accounting Extends %Persistent
{

Property client As SportClub.Clients;

Property subscription As SportClub.Subscription;

Storage Default
{
<Data name="AccountingDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>client</Value>
</Value>
<Value name="3">
<Value>subscription</Value>
</Value>
</Data>
<DataLocation>^SportClub.AccountingD</DataLocation>
<DefaultData>AccountingDefaultData</DefaultData>
<IdLocation>^SportClub.AccountingD</IdLocation>
<IndexLocation>^SportClub.AccountingI</IndexLocation>
<StreamLocation>^SportClub.AccountingS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod DeleteAccounting(ID As %Integer) As %Status
{
    set result = ##class(SportClub.Accounting).%DeleteId(ID)
    Return result
}

Method getAccounting(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT SportClub.Accounting.ID, SportClub.Clients.name, SportClub.Subscription.description
	    INTO :id, :client, :subscription
	    FROM SportClub.Accounting JOIN SportClub.Clients
    ON SportClub.Accounting.client = SportClub.Clients.ID
    JOIN SportClub.Subscription
    ON SportClub.Accounting.subscription = SportClub.Subscription.ID
 	)
     
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "client": (client), "subscription": (subscription)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
