function selectItemByValue(a,b){for(var c=0;c<a.options.length;c++)a.options[c].value==b&&(a.selectedIndex=c)}var name="John Doe",address1="Unknown Address",address2="",city="Unknown City",state="Unknown",zip="Unknown",number="Unkown",country="Unknow";document.getElementById("enterAddressFullName").value=name,document.getElementById("enterAddressAddressLine1").value=address1,document.getElementById("enterAddressAddressLine2").value=address2,document.getElementById("enterAddressCity").value=city,document.getElementById("enterAddressStateOrRegion").value=state,document.getElementById("enterAddressPostalCode").value=zip,document.getElementById("enterAddressPhoneNumber").value=number;var countryElem=document.getElementById("enterAddressCountryCode");selectItemByValue(countryElem,country);