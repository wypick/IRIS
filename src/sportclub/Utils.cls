Class SportClub.Utils
{

ClassMethod SaveAccounting(clientId As %Integer, subscriptionId As %Integer) As %Status
{
    set obj = ##class(SportClub.Accounting).%New()
    
    do obj.clientSetObjectId(clientId)
    do obj.subscriptionSetObjectId(subscriptionId)

    set result = obj.%Save()
    Return result
}

ClassMethod SaveClients(ClientsObj As SportClub.Clients) As %Status
{
    set obj = ##class(SportClub.Clients).%New()
    set obj.Name = ClientsObj.Name
    set obj.Phone = ClientsObj.Phone
    set result = obj.%Save()
    Return result
}

ClassMethod SaveSubscription(SubscriptionObj As SportClub.Subscription) As %Status
{
    set obj = ##class(SportClub.Subscription).%New()
    set obj.Description = SubscriptionObj.Description
    set obj.Price = SubscriptionObj.Price
    set result = obj.%Save()
    Return result
}

ClassMethod SaveCoach(CoachObj As SportClub.Coach) As %Status
{
    set object = ##class(SportClub.Coach).%New()
    set object.Name = CoachObj.Name
    set result = object.%Save()
    Return result
}

ClassMethod SaveGym(GymObj As SportClub.Gym) As %Status
{
    set object = ##class(SportClub.Gym).%New()
    set object.Name = GymObj.Name
    set result = object.%Save()
    Return result
}

}
