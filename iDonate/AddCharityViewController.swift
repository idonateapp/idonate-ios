//
//  AddCharityViewController.swift
//  iDonate
//
//  Created by Ronak Shah on 10/27/16.
//  Copyright © 2016 Ronak Shah. All rights reserved.
//

import UIKit

class AddCharityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var charityName: UITextField!
    @IBOutlet weak var address1: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var number: UITextField!
    
    var row: Int = 0
    var countries: [Country] = [Country(name: "Afghanistan ", id: "AF"),Country(name: "Aland Islands ", id: "AX"),Country(name: "Albania ", id: "AL"),Country(name: "Algeria ", id: "DZ"),Country(name: "American Samoa ", id: "AS"),Country(name: "Andorra ", id: "AD"),Country(name: "Angola ", id: "AO"),Country(name: "Anguilla ", id: "AI"),Country(name: "Antarctica ", id: "AQ"),Country(name: "Antigua and Barbuda ", id: "AG"),Country(name: "Argentina ", id: "AR"),Country(name: "Armenia ", id: "AM"),Country(name: "Aruba ", id: "AW"),Country(name: "Australia ", id: "AU"),Country(name: "Austria ", id: "AT"),Country(name: "Azerbaijan ", id: "AZ"),Country(name: "Bahamas, The ", id: "BS"),Country(name: "Bahrain ", id: "BH"),Country(name: "Bangladesh ", id: "BD"),Country(name: "Barbados ", id: "BB"),Country(name: "Belarus ", id: "BY"),Country(name: "Belgium ", id: "BE"),Country(name: "Belize ", id: "BZ"),Country(name: "Benin ", id: "BJ"),Country(name: "Bermuda ", id: "BM"),Country(name: "Bhutan ", id: "BT"),Country(name: "Bolivia ", id: "BO"),Country(name: "Bonaire, Saint Eustatius and Saba ", id: "BQ"),Country(name: "Bosnia and Herzegovina ", id: "BA"),Country(name: "Botswana ", id: "BW"),Country(name: "Bouvet Island ", id: "BV"),Country(name: "Brazil ", id: "BR"),Country(name: "British Indian Ocean Territory ", id: "IO"),Country(name: "Brunei Darussalam ", id: "BN"),Country(name: "Bulgaria ", id: "BG"),Country(name: "Burkina Faso ", id: "BF"),Country(name: "Burundi ", id: "BI"),Country(name: "Cambodia ", id: "KH"),Country(name: "Cameroon ", id: "CM"),Country(name: "Canada ", id: "CA"),Country(name: "Cape Verde ", id: "CV"),Country(name: "Cayman Islands ", id: "KY"),Country(name: "Central African Republic ", id: "CF"),Country(name: "Chad ", id: "TD"),Country(name: "Chile ", id: "CL"),Country(name: "China Mainland ", id: "CN"),Country(name: "Christmas Island ", id: "CX"),Country(name: "Cocos (Keeling) Islands ", id: "CC"),Country(name: "Colombia ", id: "CO"),Country(name: "Comoros ", id: "KM"),Country(name: "Congo ", id: "CG"),Country(name: "Congo, The Democratic Republic of the ", id: "CD"),Country(name: "Cook Islands ", id: "CK"),Country(name: "Costa Rica ", id: "CR"),Country(name: "Cote D'ivoire ", id: "CI"),Country(name: "Croatia ", id: "HR"),Country(name: "Curaçao ", id: "CW"),Country(name: "Cyprus ", id: "CY"),Country(name: "Czech Republic ", id: "CZ"),Country(name: "Denmark ", id: "DK"),Country(name: "Djibouti ", id: "DJ"),Country(name: "Dominica ", id: "DM"),Country(name: "Dominican Republic ", id: "DO"),Country(name: "Ecuador ", id: "EC"),Country(name: "Egypt ", id: "EG"),Country(name: "El Salvador ", id: "SV"),Country(name: "Equatorial Guinea ", id: "GQ"),Country(name: "Eritrea ", id: "ER"),Country(name: "Estonia ", id: "EE"),Country(name: "Ethiopia ", id: "ET"),Country(name: "Falkland Islands (Malvinas) ", id: "FK"),Country(name: "Faroe Islands ", id: "FO"),Country(name: "Fiji ", id: "FJ"),Country(name: "Finland ", id: "FI"),Country(name: "France ", id: "FR"),Country(name: "French Guiana ", id: "GF"),Country(name: "French Polynesia ", id: "PF"),Country(name: "French Southern Territories ", id: "TF"),Country(name: "Gabon ", id: "GA"),Country(name: "Gambia, The ", id: "GM"),Country(name: "Georgia ", id: "GE"),Country(name: "Germany ", id: "DE"),Country(name: "Ghana ", id: "GH"),Country(name: "Gibraltar ", id: "GI"),Country(name: "Greece ", id: "GR"),Country(name: "Greenland ", id: "GL"),Country(name: "Grenada ", id: "GD"),Country(name: "Guadeloupe ", id: "GP"),Country(name: "Guam ", id: "GU"),Country(name: "Guatemala ", id: "GT"),Country(name: "Guernsey ", id: "GG"),Country(name: "Guinea ", id: "GN"),Country(name: "Guinea", id: "GW"),Country(name: "Guyana ", id: "GY"),Country(name: "Haiti ", id: "HT"),Country(name: "Heard Island and the McDonald Islands ", id: "HM"),Country(name: "Holy See ", id: "VA"),Country(name: "Honduras ", id: "HN"),Country(name: "Hong Kong ", id: "HK"),Country(name: "Hungary ", id: "HU"),Country(name: "Iceland ", id: "IS"),Country(name: "India ", id: "IN"),Country(name: "Indonesia ", id: "ID"),Country(name: "Iraq ", id: "IQ"),Country(name: "Ireland ", id: "IE"),Country(name: "Isle of Man ", id: "IM"),Country(name: "Israel ", id: "IL"),Country(name: "Italy ", id: "IT"),Country(name: "Jamaica ", id: "JM"),Country(name: "Japan ", id: "JP"),Country(name: "Jersey ", id: "JE"),Country(name: "Jordan ", id: "JO"),Country(name: "Kazakhstan ", id: "KZ"),Country(name: "Kenya ", id: "KE"),Country(name: "Kiribati ", id: "KI"),Country(name: "Korea, Republic of ", id: "KR"),Country(name: "Kosovo ", id: "XK"),Country(name: "Kuwait ", id: "KW"),Country(name: "Kyrgyzstan ", id: "KG"),Country(name: "Lao People's Democratic Republic ", id: "LA"),Country(name: "Latvia ", id: "LV"),Country(name: "Lebanon ", id: "LB"),Country(name: "Lesotho ", id: "LS"),Country(name: "Liberia ", id: "LR"),Country(name: "Libya ", id: "LY"),Country(name: "Liechtenstein ", id: "LI"),Country(name: "Lithuania ", id: "LT"),Country(name: "Luxembourg ", id: "LU"),Country(name: "Macao ", id: "MO"),Country(name: "Macedonia, The Former Yugoslav Republic of ", id: "MK"),Country(name: "Madagascar ", id: "MG"),Country(name: "Malawi ", id: "MW"),Country(name: "Malaysia ", id: "MY"),Country(name: "Maldives ", id: "MV"),Country(name: "Mali ", id: "ML"),Country(name: "Malta ", id: "MT"),Country(name: "Marshall Islands ", id: "MH"),Country(name: "Martinique ", id: "MQ"),Country(name: "Mauritania ", id: "MR"),Country(name: "Mauritius ", id: "MU"),Country(name: "Mayotte ", id: "YT"),Country(name: "Mexico ", id: "MX"),Country(name: "Micronesia, Federated States of ", id: "FM"),Country(name: "Moldova, Republic of ", id: "MD"),Country(name: "Monaco ", id: "MC"),Country(name: "Mongolia ", id: "MN"),Country(name: "Montenegro ", id: "ME"),Country(name: "Montserrat ", id: "MS"),Country(name: "Morocco ", id: "MA"),Country(name: "Mozambique ", id: "MZ"),Country(name: "Myanmar ", id: "MM"),Country(name: "Namibia ", id: "NA"),Country(name: "Nauru ", id: "NR"),Country(name: "Nepal ", id: "NP"),Country(name: "Netherlands ", id: "NL"),Country(name: "Netherlands Antilles ", id: "AN"),Country(name: "New Caledonia ", id: "NC"),Country(name: "New Zealand ", id: "NZ"),Country(name: "Nicaragua ", id: "NI"),Country(name: "Niger ", id: "NE"),Country(name: "Nigeria ", id: "NG"),Country(name: "Niue ", id: "NU"),Country(name: "Norfolk Island ", id: "NF"),Country(name: "Northern Mariana Islands ", id: "MP"),Country(name: "Norway ", id: "NO"),Country(name: "Oman ", id: "OM"),Country(name: "Pakistan ", id: "PK"),Country(name: "Palau ", id: "PW"),Country(name: "Palestinian Territories ", id: "PS"),Country(name: "Panama ", id: "PA"),Country(name: "Papua New Guinea ", id: "PG"),Country(name: "Paraguay ", id: "PY"),Country(name: "Peru ", id: "PE"),Country(name: "Philippines ", id: "PH"),Country(name: "Pitcairn ", id: "PN"),Country(name: "Poland ", id: "PL"),Country(name: "Portugal ", id: "PT"),Country(name: "Puerto Rico ", id: "PR"),Country(name: "Qatar ", id: "QA"),Country(name: "Reunion ", id: "RE"),Country(name: "Romania ", id: "RO"),Country(name: "Russian Federation ", id: "RU"),Country(name: "Rwanda ", id: "RW"),Country(name: "Saint Barthelemy ", id: "BL"),Country(name: "Saint Helena, Ascension and Tristan da Cunha ", id: "SH"),Country(name: "Saint Kitts and Nevis ", id: "KN"),Country(name: "Saint Lucia ", id: "LC"),Country(name: "Saint Martin ", id: "MF"),Country(name: "Saint Pierre and Miquelon ", id: "PM"),Country(name: "Saint Vincent and the Grenadines ", id: "VC"),Country(name: "Samoa ", id: "WS"),Country(name: "San Marino ", id: "SM"),Country(name: "Sao Tome and Principe ", id: "ST"),Country(name: "Saudi Arabia ", id: "SA"),Country(name: "Senegal ", id: "SN"),Country(name: "Serbia ", id: "RS"),Country(name: "Seychelles ", id: "SC"),Country(name: "Sierra Leone ", id: "SL"),Country(name: "Singapore ", id: "SG"),Country(name: "Sint Maarten ", id: "SX"),Country(name: "Slovakia ", id: "SK"),Country(name: "Slovenia ", id: "SI"),Country(name: "Solomon Islands ", id: "SB"),Country(name: "Somalia ", id: "SO"),Country(name: "South Africa ", id: "ZA"),Country(name: "South Georgia and the South Sandwich Islands ", id: "GS"),Country(name: "Spain ", id: "ES"),Country(name: "Sri Lanka ", id: "LK"),Country(name: "Suriname ", id: "SR"),Country(name: "Svalbard and Jan Mayen ", id: "SJ"),Country(name: "Swaziland ", id: "SZ"),Country(name: "Sweden ", id: "SE"),Country(name: "Switzerland ", id: "CH"),Country(name: "Taiwan ", id: "TW"),Country(name: "Tajikistan ", id: "TJ"),Country(name: "Tanzania, United Republic of ", id: "TZ"),Country(name: "Thailand ", id: "TH"),Country(name: "Timor", id: "TL"),Country(name: "Togo ", id: "TG"),Country(name: "Tokelau ", id: "TK"),Country(name: "Tonga ", id: "TO"),Country(name: "Trinidad and Tobago ", id: "TT"),Country(name: "Tunisia ", id: "TN"),Country(name: "Turkey ", id: "TR"),Country(name: "Turkmenistan ", id: "TM"),Country(name: "Turks and Caicos Islands ", id: "TC"),Country(name: "Tuvalu ", id: "TV"),Country(name: "Uganda ", id: "UG"),Country(name: "Ukraine ", id: "UA"),Country(name: "United Arab Emirates ", id: "AE"),Country(name: "United Kingdom ", id: "GB"),Country(name: " SELECTED United States ", id: "US"),Country(name: "United States Minor Outlying Islands ", id: "UM"),Country(name: "Uruguay ", id: "UY"),Country(name: "Uzbekistan ", id: "UZ"),Country(name: "Vanuatu ", id: "VU"),Country(name: "Venezuela ", id: "VE"),Country(name: "Vietnam ", id: "VN"),Country(name: "Virgin Islands, British ", id: "VG"),Country(name: "Virgin Islands, U.S. ", id: "VI"),Country(name: "Wallis and Futuna ", id: "WF"),Country(name: "Western Sahara ", id: "EH"),Country(name: "Yemen ", id: "YE"),Country(name: "Zambia ", id: "ZM"),Country(name: "Zimbabwe", id: "ZW")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //removing keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddCharityViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCharity() {
        //check if all fields are filled
        
        
        let a = Address(name: charityName.text!, a1: address1.text!, a2: address2.text!, state: state.text!, city: city.text!, country: countries[row].id, zip: zip.text!, number: number.text!)
        let charity = Charity(address: a)
        let charityArray = DataManager.getArray(key: "charities")
        charityArray.add(charity)
        DataManager.saveArray(array: charityArray, key: "charities")
        
        let vc: CharitySelectionViewController = self.storyboard!.instantiateViewController(withIdentifier: "charityVC") as! CharitySelectionViewController
        self.show(vc as UIViewController, sender: vc)

    }
    // MARK: PickerView Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let name = countries[row].name
        
        let attrDict = [NSFontAttributeName: UIFont(name: "Avenir Next", size: 16.0), NSForegroundColorAttributeName: UIColor.red] as [String : Any]

        let str = NSAttributedString(string: name, attributes: attrDict)
        
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
