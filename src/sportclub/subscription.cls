Class SportClub.Subscription Extends %Persistent
{

Property Description As %String;

Property Price As %Decimal;

Storage Default
{
<Data name="SubscriptionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Description</Value>
</Value>
<Value name="3">
<Value>Price</Value>
</Value>
</Data>
<DataLocation>^SportClub.SubscriptionD</DataLocation>
<DefaultData>SubscriptionDefaultData</DefaultData>
<IdLocation>^SportClub.SubscriptionD</IdLocation>
<IndexLocation>^SportClub.SubscriptionI</IndexLocation>
<StreamLocation>^SportClub.SubscriptionS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod DeleteSubscription(ID As %Integer) As %Status
{
    set result = ##class(SportClub.Subscription).%DeleteId(ID)
    Return result
}

Method getSubscription(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, description, price
	    INTO :id, :description, :price
	    FROM SportClub.Subscription
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "description": (description), "price": (price)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

Method getSubscriptionforselect(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, description, price
	    INTO :id, :description, :price
	    FROM SportClub.Subscription
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit


	set value = description_" "_price
	set obj = {"id": (id), "value": (value)}

    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
