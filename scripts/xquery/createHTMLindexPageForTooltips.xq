(: create index page for commented texts :)

declare function local:htmlframe($title, $result){
<html>
<head>
  <title>{$title}, cum analysi grammatica et lemmatibus</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link href="https://fonts.googleapis.com/css?family=EB+Garamond:400,400i,800,800i&amp;subset=greek,greek-ext,latin-ext" rel="stylesheet"/>
  	<link rel="stylesheet" type="text/css" href="tooltipster-master/dist/css/tooltipster.bundle.min.css" />
  	<link rel="stylesheet" type="text/css" href="tooltipster-master/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-light.min.css" />
  	<link rel="stylesheet" type="text/css" href="css/tt-custom.css" />
</head>
<body>
  <h1> { $title }, cum analysi grammatica et lemmatibus</h1>
	<p class="page_subtitle">Universitatis Zagrabiensis Facultas philosophica, a. MMXX.</p>
<!-- početak -->
<div id="text-grc">
{ $result }
</div>
</body>
</html>

};

let $db := "grc-morf-pos"
let $list := element ol {
for $f in db:open($db)/treebank
let $lin := ("http://croala.ffzg.unizg.hr/grcgram/" || replace(db:path($f), "\.xml", ".html"))
let $name := $f/*:bibl/*:name/string()
order by $name
return element li { element a { attribute href { $lin} , $name } }
}
return local:htmlframe("Eclogae Graecae", $list)