Class web.index Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
  do ..header()
  do ##class(web.index).body()
  do ..footer()
    Quit $$$OK
}

ClassMethod header() As %Status
{
  &HTML<
    <html>
      <head>
        <script type="text/javascript" src="webix/webix.min.js" ></script>
        <link rel="stylesheet" type="text/css" href="webix/webix.min.css">
        <link rel="stylesheet" href="https://cdn.materialdesignicons.com/2.7.94/css/materialdesignicons.css?v=7.2.0" type="text/css" charset="utf-8">
      </head>
  >

  Quit $$$OK
}

/// mostly JS on webix framework
ClassMethod body() As %Status
{
  &JS<
<script type="text/javascript">

var submitResult = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Successfully saved", expire:2000};
      $$('tab2_form_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire: 2000};
      webix.message(message);
  };

var menu_data = [
	{id: "tab1", icon: "mdi mdi-table", value:"Accounting", data: [
  	{id: "tab1_list", icon: "mdi mdi-table", value:"Accounting list"},
	  {id: "tab1_form", icon: "mdi mdi-pencil", value:"Accounting form"},
     ]},

	{id: "tab2", icon: "mdi mdi-table", value:"Client", data: [
  	{id: "tab2_list", icon: "mdi mdi-table", value:"Client list"},
	  {id: "tab2_form", icon: "mdi mdi-pencil", value:"Client form"},
     ]},

  {id: "tab3", icon: "mdi mdi-table", value:"Subscription", data: [
  	{id: "tab3_list", icon: "mdi mdi-table", value:"Subscription list"},
	  {id: "tab3_form", icon: "mdi mdi-pencil", value:"Subscription form"},
     ]},

  {id: "tab4", icon: "mdi mdi-table", value:"Gym", data: [
  	{id: "tab4_list", icon: "mdi mdi-table", value:"Gym list"},
	  {id: "tab4_form", icon: "mdi mdi-pencil", value:"Gym form"},
     ]},

  {id: "tab5", icon: "mdi mdi-table", value:"Coach", data: [
  	{id: "tab5_list", icon: "mdi mdi-table", value:"Coach list"},
	  {id: "tab5_form", icon: "mdi mdi-pencil", value:"Coach form"},
     ]},
];

var addClientToAccounting = (rawData) => {
    let data = JSON.parse(rawData);
    let message;
    if (data.result) {
      message = { type:"success", text: "Client is added to accounting", expire:2000};
      $$('tab1_form_content').clear();
    }
    else
      message = { type:"error", text: data.message, expire: 2000};
      webix.message(message);
  };

var accounting_form_template = {
  id:"tab1_form_content",
  view:"form",
  width: "400",
  height: "600",
  elements:[
    {view:"select", name: "client", label:"Client", value:1, options:"/sportclubapi/clients/getforselect", labelAlign:"right"},
    {view:"select", name: "subscription", label:"Subscription", value:1, options:"/sportclubapi/subscription/getforselect", labelAlign:"right" },
    { view:"button",  value:"Submit", id:"btn1", click:function(){
      var values = this.getFormView().getValues();
      webix.ajax().post("/sportclubapi/accounting/save", values, addClientToAccounting);
    }}
  ]
};

var accounting_list_template = {
  id:"tab1_list_content",
  view:"list",
  template:"<div style='padding-left:18px'> Client:#client#, Subscription:#subscription# </div> <button class='webix_remove_upload' click='onDelete()'>Delete</button>",
  type:{
    height:60
  },
  select:true,
  url:"/sportclubapi/accounting/get",
  onClick:{
        "webix_remove_upload":function(ev, id){
            webix.ajax().del("/sportclubapi/accounting/delete?id="+id, { id : id }).then((data) => {
              this.remove(id);
            });
           // blocks the default click behavior
        }
    }
  };


var onDelete = () => {
  alert("delete")
};

var client_list_template = {
  id:"tab2_list_content",
  view:"list",
  template:"<div style='padding-left:18px'> ID:#id#, Name:#name#, Phone:#phone# </div> <button class='webix_remove_upload' click='onDelete()'>Delete</button>",
  type:{
    height:60
  },
  select:true,
  url:"/sportclubapi/clients/get",
  onClick:{
        "webix_remove_upload":function(ev, id){
            webix.ajax().del("/sportclubapi/clients/delete?id="+id, { id : id }).then((data) => {
              this.remove(id);
            });
           // blocks the default click behavior
        }
    }
  };

var client_form_template = {
 id:"tab2_form_content",
 view:"form",
 width: "400",
 height: "400",
 elements:[
   {view: "text", name: "name", label: "Name"},
   {view: "text", name: "phone", label: "Phone", type: 'number'},
   { view:"button",  value:"Submit", id:"btn2", click:function(){
     var values = this.getFormView().getValues();
     webix.ajax().post("/sportclubapi/clients/save", values, submitResult);
   }}
 ]};

//Subscription

var subscription_list_template = {
  id:"tab3_list_content",
  view:"list",
  template:"<div style='padding-left:18px'> ID:#id#, Description:#description#, Price:#price#</div> <button class='webix_remove_upload' click='onDelete()'>Delete</button>",
  type:{
    height:60
  },
  select:true,
  url:"/sportclubapi/subscription/get",
  onClick:{
        "webix_remove_upload":function(ev, id){
            webix.ajax().del("/sportclubapi/subscription/delete?id="+id, { id : id }).then((data) => {
              this.remove(id);
            });
           // blocks the default click behavior
        }
    }
  };

 var subscription_form_template = {
 id:"tab3_form_content",
 view:"form",
 width: "400",
 height: "400",
 elements:[
   {view: "text", name: "description", label: "Description"},
   {view: "text", name: "price", label: "Price", type: 'number'},
   { view:"button",  value:"Submit", id:"btn3", click:function(){
     var values = this.getFormView().getValues();
     webix.ajax().post("/sportclubapi/subscription/save", values, submitResult);
   }}
 ]};


//GYM

 var gym_list_template = {
  id:"tab4_list_content",
  view:"list",
  template:"<div style='padding-left:18px'> Gym Name:#name# </div> <button class='webix_remove_upload' click='onDelete()'>Delete</button>",
  type:{
    height:60
  },
  select:true,
  url:"/sportclubapi/gym/get",
  onClick:{
        "webix_remove_upload":function(ev, id){
            webix.ajax().del("/sportclubapi/gym/delete?id="+id, { id : id }).then((data) => {
              this.remove(id);
            });
           // blocks the default click behavior
        }
    }
  };


 var gym_form_template = {
 id:"tab4_form_content",
 view:"form",
 width: "400",
 height: "400",
 elements:[
   {view: "text", name: "namegym", label: "Gym Name"},
   { view:"button",  value:"Submit", id:"btn4", click:function(){
     var values = this.getFormView().getValues();
     webix.ajax().post("/sportclubapi/gym/save", values, submitResult);
   }}
 ]};


//COACH

var coach_list_template = {
  id:"tab5_list_content",
  view:"list",
  template:"<div style='padding-left:18px'> Name:#name# </div> <button class='webix_remove_upload' click='onDelete()'>Delete</button>",
  type:{
    height:60
  },
  select:true,
  url:"/sportclubapi/coach/get",
  onClick:{
        "webix_remove_upload":function(ev, id){
            webix.ajax().del("/sportclubapi/coach/delete?id="+id, { id : id }).then((data) => {
              this.remove(id);
            });
           // blocks the default click behavior
        }
    }
  };

var coach_form_template = {
 id:"tab5_form_content",
 view:"form",
 height: "400",
 width: "400",
 elements:[
   {view: "text", name: "namecoach", label: "Name"},
   { view:"button",  value:"Submit", id:"btn5", click:function(){
     var values = this.getFormView().getValues();
     webix.ajax().post("/sportclubapi/coach/save", values, submitResult);
   }}
 ]};


var ui_template = {
  height: '100%',
  rows: [
    { view: "toolbar", padding:3, 
      elements: [
        { view: "button", type: "icon", icon: "mdi mdi-menu",
          width: 37, align: "left", css: "app_button", click: function(){
            $$("$sidebar1").toggle();
          }
        },
        { view: "label", label: "IRIS app"},
      ]
    },
    { 
      cols:[
      {
        view: "sidebar",
        data: menu_data,
        on:{
          onAfterSelect: function(id){
            //let value = this.getItem(id).value;
            //webix.message(`Selected ${value}`);
            //$$("t1_content").setHTML(`Selected ${value}`);
            //let displayViewId = `${id}_content`;
            $$(`${id}_content`).show();
            //if (displayViewId === 'tab1_content') $$(displayViewId).refresh();
          }
        }
      },
      { id:"t1_content",
          cells:[
          accounting_list_template,
          accounting_form_template,
            client_list_template,
            client_form_template,
            subscription_list_template,
            subscription_form_template,
            gym_list_template,
            gym_form_template,
            coach_list_template,
            coach_form_template,
        ]   
      }
    ]}
  ]};

webix.ready(function(){
  webix.ui(ui_template);
});
</script>
  >
  Quit $$$OK
}

ClassMethod footer() As %Status
{
  &HTML<
    </body></html>
  >
  Quit $$$OK
}

}
