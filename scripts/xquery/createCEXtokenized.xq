(: create CEX from xml :)
declare function local:makecexversion(){
  "#!cexversion
  
3.0"
};

declare function local:makecitelibrary($name,$urn,$license){
  "#!citelibrary
  ",
  string-join(
  ("name", $name), "#"),
string-join(("urn", $urn ), "#"), 
string-join(("license", $license),"#")
};

declare function local:makectscatalog($urn){
 let $header :=
  "#!ctscatalog

urn#citationScheme#groupName#workTitle#versionLabel#exemplarLabel#online#lang
"
  return ($header, $urn)
};

declare function local:urnstring(
  $urn,
  $citsch,
  $grpname,
  $worktitle,
  $verlabel,
  $exemplarlabel,
  $online,
  $lang
){
  string-join(
  ($urn,
  $citsch,
  $grpname,
  $worktitle,
  $verlabel,
  $exemplarlabel,
  $online,
  $lang),"#")
};

declare function local:makeciteblocks(){
  "
#!citecollections

URN#Description#Labelling property#Ordering property#License
urn:cite2:cite:grcmorfverbs.2019a:#Linguistic annotations of Ancient Greek words#urn:cite2:cite:grcmorfverbs.2019a.label:##CC BY 4.0

#!citeproperties
Property#Label#Type#Authority list
urn:cite2:cite:grcmorfverbs.2019a.urn:#Linguistic Annotations#Cite2Urn#
urn:cite2:cite:grcmorfverbs.2019a.label:#Linguistic Annotation#String#

#!citedata
urn#label
urn:cite2:cite:grcmorfverbs.2019a:hasProperty#Has morphological annotation
urn:cite2:cite:grcmorfverbs.2019a:isPropertyOf#Is morphological property of a linguistic unit
urn:cite2:cite:grcmorfverbs.2019a:hasLemma#Is a form of the lexical unit
urn:cite2:cite:grcmorfverbs.2019a:isLemmaOf#Is lexical unit of a form

"
};

declare function local:makectsdataline($doc,$cts1,$tag){
for $s in $doc/*:sentence
let $cts2 := $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := $w/@*[name()=$tag]/string()
return $cts1 || "." || $cts2 || "." || $cts3 || "#" || $value
};

declare function local:makectspair($doc,$cts1,$cts1a){
for $s in $doc/*:sentence
let $cts2 := $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := "urn:cite2:cite:grcmorfverbs.2019a:hasProperty"
return string-join(($cts1, $cts2, $cts3),".") || "#" || $value || "#" || string-join(($cts1a, $cts2, $cts3),".")
};

declare function local:makectspairlemma($doc,$cts1,$cts1a){
for $s in $doc/*:sentence
let $cts2 := $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := "urn:cite2:cite:grcmorfverbs.2019a:hasLemma"
return string-join(($cts1, $cts2, $cts3),".") || "#" || $value || "#" || string-join(($cts1a, $cts2, $cts3),".")
};

declare function local:makeurn($doc, $cts1){
  let $header := "#!ctsdata"
  let $data := local:makectsdataline($doc,$cts1,"form")
return ($header, $data)
};



declare function local:makeurnpostag($doc, $cts1){
  let $header := "#!ctsdata"
  let $data := local:makectsdataline($doc,$cts1,"postag")
return ($header, $data)
};

declare function local:makeurnlemma($doc, $cts1){
  let $header := "#!ctsdata"
  let $data := local:makectsdataline($doc,$cts1,"lemma")
return ($header, $data)
};

declare function local:makerelations(){
  "
#!relations
"
};

let $name := "Fragmentum 14 cum commento"
let $urn0 := "urn:cite2:cex:unizghr.ffzghrpos:antiphonfragmentum"
let $license := "Creative Commons Attribution 4.0 International (CC BY 4.0)  <https://creativecommons.org/licenses/by/4.0/>"
let $citsch := "paragraphus,sententia,membrum"
let $grpname := "Isocrates"
let $worktitle := "Fragmentum 14"
let $verlabel := "Ex editione Friderici Blass (1892) in collectione OGL"
let $exemplarlabel := "tokenized"
let $exemplarlabel2 := "morphological properties"
let $exemplarlabel3 := "lemmatized"
let $online := "true"
let $lang := "grc"

let $urn := "tlg1147.tlg001"
let $db := "grc-morf-pos"
for $doc in collection($db)//*:treebank
where matches(db:path($doc),$urn)
let $cts1 := "urn:cts:greekLit:" || replace(db:path($doc),":14.xml",".token:")
let $cts1a := "urn:cts:greekLit:" || replace(db:path($doc),":14.xml",".postag:")
let $cts1b := "urn:cts:greekLit:" || replace(db:path($doc),":14.xml",".lemma:")
let $cts2 := "14"
let $cts1t := $cts1 || $cts2
let $cts1p := $cts1a || $cts2
let $cts1l := $cts1b || $cts2
let $urnword := local:urnstring(
  $cts1,
  $citsch,
  $grpname,
  $worktitle,
  $verlabel,
  $exemplarlabel,
  $online,
  $lang)
let $urnpostag := local:urnstring(
  $cts1a,
  $citsch,
  $grpname,
  $worktitle,
  $verlabel,
  $exemplarlabel2,
  $online,
  $lang)
let $urnlemma := local:urnstring(
  $cts1b,
  $citsch,
  $grpname,
  $worktitle,
  $verlabel,
  $exemplarlabel3,
  $online,
  $lang)
return (
  local:makecexversion() , 
local:makecitelibrary($name,$urn0,$license),
local:makectscatalog(
  ( $urnword , $urnpostag , $urnlemma )
),
local:makeurn($doc, $cts1 || $cts2),
local:makeurnpostag($doc, $cts1a || $cts2),
local:makeurnlemma($doc, $cts1b || $cts2),
local:makeciteblocks(),
local:makerelations(),
local:makectspair($doc, $cts1t, $cts1p),
local:makectspairlemma($doc,$cts1t,$cts1l)
)
