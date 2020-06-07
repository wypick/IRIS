Class SportClub.Api Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/accounting/save" Method="POST" Call="SaveAccounting"/>
  <Route Url="/accounting/get" Method="GET" Call="GetAccounting"/>
  <Route Url="/accounting/delete" Method="DELETE" Call="DeleteAccounting"/>

  <Route Url="/clients/save" Method="POST" Call="SaveClient"/>
  <Route Url="/clients/get" Method="GET" Call="GetClients"/>
 <Route Url="/clients/getforselect" Method="GET" Call="GetClientsforselect"/>
  <Route Url="/clients/delete" Method="DELETE" Call="DeleteClient"/>

  <Route Url="/subscription/save" Method="POST" Call="SaveSubscription"/>
  <Route Url="/subscription/get" Method="GET" Call="GetSubscription"/>
  <Route Url="/subscription/getforselect" Method="GET" Call="GetSubscriptionforselect"/>
  <Route Url="/subscription/delete" Method="DELETE" Call="DeleteSubscription"/>
  
  <Route Url="/gym/save" Method="POST" Call="SaveGym"/>
  <Route Url="/gym/get" Method="GET" Call="GetGym"/>
  <Route Url="/gym/delete" Method="DELETE" Call="DeleteGym"/>

  <Route Url="/coach/save" Method="POST" Call="SaveCoach"/>
  <Route Url="/coach/get" Method="GET" Call="GetCoaches"/>
  <Route Url="/coach/delete" Method="DELETE" Call="DeleteCoach"/>
</Routes>
}

//  <Route Url="/delete" Method="DELETE" Call="ClientDelete"/>

ClassMethod GetClients() As %Status
{
  set obj = ##class(SportClub.Clients).%New()
  do obj.getClients(.clientsArray)
  write clientsArray.%ToJSON()
  Return $$$OK
}

ClassMethod GetClientsforselect() As %Status
{
  set obj = ##class(SportClub.Clients).%New()
  do obj.getClientsforselect(.clientsArray)
  write clientsArray.%ToJSON()
  Return $$$OK
}

ClassMethod GetAccounting() As %Status
{
  set obj = ##class(SportClub.Accounting).%New()
  do obj.getAccounting(.accountingArray)
  write accountingArray.%ToJSON()
  Return $$$OK
}

ClassMethod SaveAccounting() As %Status
{
    set clientId = %request.Get("client")
    set subscriptionId = %request.Get("subscription")

    set saveResult = ##class(SportClub.Utils).SaveAccounting(clientId, subscriptionId)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage
    write result.%ToJSON()

    Return $$$OK
}

ClassMethod SaveClient() As %Status
{
    set obj = {}
    set obj.Name = %request.Get("name")
    set obj.Phone = %request.Get("phone")
    set saveResult = ##class(SportClub.Utils).SaveClients(obj)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage
    write result.%ToJSON()

    Return $$$OK
}

ClassMethod DeleteClient() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(SportClub.Clients).DeleteClient(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod DeleteAccounting() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(SportClub.Accounting).DeleteAccounting(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod GetSubscription() As %Status
{
  set obj = ##class(SportClub.Subscription).%New()
  do obj.getSubscription(.subscriptionArray)
  write subscriptionArray.%ToJSON()
  Return $$$OK
}

ClassMethod GetSubscriptionforselect() As %Status
{
  set obj = ##class(SportClub.Subscription).%New()
  do obj.getSubscriptionforselect(.subscriptionArray)
  write subscriptionArray.%ToJSON()
  Return $$$OK
}

ClassMethod SaveSubscription() As %Status
{
    set obj = {}
    set obj.Description = %request.Get("description")
    set obj.Price = %request.Get("price")
    set saveResult = ##class(SportClub.Utils).SaveSubscription(obj)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage
    write result.%ToJSON()

    Return $$$OK
}

ClassMethod DeleteSubscription() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(SportClub.Subscription).DeleteSubscription(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod SaveGym() As %Status
{
    set object = {}
    set object.Name = %request.Get("namegym")
    set saveResult = ##class(SportClub.Utils).SaveGym(object)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage
    write result.%ToJSON()

    Return $$$OK
}

ClassMethod GetGym() As %Status
{
  set obj = ##class(SportClub.Gym).%New()
  do obj.getGym(.gymArray)
  write gymArray.%ToJSON()
  Return $$$OK
}

ClassMethod DeleteGym() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(SportClub.Gym).DeleteGym(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod SaveCoach() As %Status
{
    set object = {}
    set object.Name = %request.Get("namecoach")
    set saveResult = ##class(SportClub.Utils).SaveCoach(object)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage
    write result.%ToJSON()

    Return $$$OK
}

ClassMethod GetCoaches() As %Status
{
  set obj = ##class(SportClub.Coach).%New()
  do obj.getCoach(.coachArray)
  write coachArray.%ToJSON()
  Return $$$OK
}

ClassMethod DeleteCoach() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(SportClub.Coach).DeleteCoach(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

}
