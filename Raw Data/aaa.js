
function convertXMLtoJSON(path){
    // read
    const fs = require('node:fs');
    try {
        const xmldata = fs.readFileSync(path+".tbx", 'utf8');
        console.log(xmldata);

        //convert
        var parseString = require('xml2js').parseString;
        parseString(xmldata, function (err, jsondata) {
            concepts = jsondata.tbx.text[0].body[0].conceptEntry
            console.log(concepts);
            fs.writeFileSync(path+".json", JSON.stringify(concepts), { flag: 'w+' }, err => {});
        });
    } catch (err) {
        console.error(err);
    }
 }

 convertXMLtoJSON("J-1 – питання персоналу");
 convertXMLtoJSON("J-2 – розвідка");
 convertXMLtoJSON("J-3 – оперативна діяльність");
 convertXMLtoJSON("J-4 – логістика");
 convertXMLtoJSON("J-5 – оборонне планування");
 convertXMLtoJSON("J-6 – зв’язок та інформаційні системи");
 convertXMLtoJSON("J-7 – підготовка військ");
 convertXMLtoJSON("J-8 – ресурси і фінанси");
 convertXMLtoJSON("J-9 – цивільно-військове співробітництво");



