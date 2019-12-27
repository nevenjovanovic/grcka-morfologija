(: XQuery module for GrcMorf 1 :)
module namespace gm = 'http://croala.ffzg.unizg.hr/grcmorf';

(: helper function for header, with meta :)
declare function gm:htmlheadserver($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, CroALa, Grčka morfologija 1" />
<link rel="icon" href="/basex/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/grcmorf.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/font-awesome-4.7.0/css/font-awesome.min.css"/>
</head>

};

(: helper function for table :)
declare function gm:table ($headings, $body){
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    if ($headings="") then ()
    else
    element thead {
      element tr {
        for $h in $headings return element th { $h }
      }
    },
    element tbody {
      $body
    }
  }
};

(: helper function - footer :)
declare function gm:footerserver () {
let $f := <footer class="footer">
<div class="container">
<h1 class="text-center"><span class="fa fa-leaf fa-fw" aria-hidden="true"></span> <a href="http://croala.ffzg.unizg.hr">CroALa</a>: Grčka morfologija 1</h1>
<div class="row"> 
<div  class="col">
<h3 class="text-center"><a href="http://www.ffzg.unizg.hr"><img src="/basex/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</h3> 
<p class="text-center"><i class="fa fa-github fa-lg"></i>
            <span class="network-name">Github</span>: <a href="https://github.com/nevenjovanovic/grcka-morfologija">grcka-morfologija</a></p>
</div>
</div>
</div>
</footer>
return $f
};

(: helper function -- db info :)
declare function gm:infodb($dbname) {
  (: return info on croalabib db, with Latin field names :)
let $week := map {
  "name": "nomen",
  "documents": "documenta",
  "timestamp": "de dato"
}
return element table { 
attribute class { "pull-right"},
let $i := db:info($dbname)/databaseproperties
  for $n in ('name','documents','timestamp')
  return 
   element tr {
    element td { map:get($week, $n) } ,
    element td { $i/*[name()=$n] }
  }
}
};

(: return list of lemmata and counts of occurrences :)
declare function gm:lemlist($db){
for $l in db:open($db)/wordindex/lemma
let $l1 := $l/@lemma/string()
let $oc := $l/@n/string()
return element tr {
  element td { $l1 },
  element td { 
    element a { 
  attribute href { "/grcmorf-occur/" || $l1 } , 
  $oc }
 }
}  
};

(: return total count of lemmata and of occurrences :)
declare function gm:leminfo($db){
let $lem := db:open($db)/wordindex/lemma
let $occount := sum(for $l in $lem
let $oc := $l/@n
return sum($oc))
return "Lemmata: " || count($lem)  || ". Verba occurrentia: " || $occount  || ".
"
};

(: for a lemma, return list of occurrences with locations and counts :)
(: format as rows of a table :)
declare function gm:getocc($db, $lemma){
let $lem := db:open($db)/wordindex/lemma[@lemma=$lemma]
return ( element tr { 
element td { $lem/@lemma/string() } , element td { $lem/@n/string() }
},
for $m in $lem/morph return (
element tr {
  element td { $m/@postag/string() },
  element td { $m/@n/string() }
},
element tr {
  element td { $m/forma },
  element td { 
  for $f in $m/fontes/fons
  return
  element a {
    attribute href { "/ctsurn/" || $f/string() } , $f } }
} ) )
};

(: work with CTS URNs for tokenized sentences :)
(: tokenize a CTS URN :)
declare function gm:anaurn($urn){
  tokenize($urn, ":")
};
(: return the document part of a CTS URN :)
declare function gm:docurn($anaurn){
  string-join(
  (
  for $a in $anaurn[position() = 1 to 4]
  return $a ),
  ":"
) || ":"
};
(: tokenize the subreference of a CTS URN :)
declare function gm:subdocseq($anaurn){
  for $a in tokenize($anaurn[5], "\.") return $a
};
(: from the tokenized subreference, get the subdoc string :)
declare function gm:subdocstring($anaurn){
  replace( 
$anaurn[5] , "\.[0-9]+\.[0-9]+$", "")
};
(: format the sentence with two span types: word and punctuation :)
declare function gm:format-sentence($wordn,$sentence){
  for $s in $sentence/word
let $w :=  $s/@form
let $wn := $s/@id
let $l := $s/@lemma
return if ($l="punc1") then element span {
  attribute class {"punc1"} , $w/string() } else 
  if ($wn=$wordn) then element span { 
  attribute class { "hit"} , $w/string() } else
  element span { 
  attribute class {"word"} , $w/string() }
};