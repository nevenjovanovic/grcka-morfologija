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

declare function local:makectsdataline($doc,$exemplar,$tag){
for $s in $doc/*:sentence
let $cts2 := replace($s/@document_id/string(), ":$", ("." || $exemplar)) || ":" || $s/@subdoc/string() || "." || $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := $w/@*[name()=$tag]/string()
return $cts2 || "." || $cts3 || "#" || $value
};

declare function local:makectspair($doc){
for $s in $doc/*:sentence
let $cts2 := replace($s/@document_id/string(),":$", ".token:") || $s/@subdoc/string() || "." || $s/@id/string()
let $cts2a := replace($s/@document_id/string(),":$", ".postag:") || $s/@subdoc/string() || "." || $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := "urn:cite2:cite:grcmorfverbs.2019a:hasProperty"
return string-join(($cts2, $cts3),".") || "#" || $value || "#" || string-join(($cts2a, $cts3),".")
};

declare function local:makectspairlemma($doc){
for $s in $doc/*:sentence
let $cts2 := replace($s/@document_id/string(),":$", ".token:") || $s/@subdoc/string() || "." || $s/@id/string()
let $cts2a := replace($s/@document_id/string(),":$", ".lemma:") || $s/@subdoc/string() || "." || $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := "urn:cite2:cite:grcmorfverbs.2019a:hasLemma"
return string-join(($cts2, $cts3),".") || "#" || $value || "#" || string-join(($cts2a, $cts3),".")
};

declare function local:makeurn($doc, $exemplar){
  let $header := "#!ctsdata"
  let $data := local:makectsdataline($doc,$exemplar,"form")
return ($header, $data)
};



declare function local:makeurnpostag($doc, $exemplar){
  let $header := "#!ctsdata"
  let $data := local:makectsdataline($doc,$exemplar,"postag")
return ($header, $data)
};

declare function local:makeurnlemma($doc, $exemplar){
  let $header := "#!ctsdata"
  let $data := local:makectsdataline($doc,$exemplar,"lemma")
return ($header, $data)
};

declare function local:makerelations(){
  "
#!relations
"
};
declare function local:cex($urn){
let $exemplarlabel2 := "morphological properties"
let $exemplarlabel3 := "lemmatized"
let $online := "true"
let $lang := "grc"

let $db := "grc-morf-pos"
for $doc in db:open($db,$urn)//*:treebank
let $name := $doc/*:bibl/*:name/string()
let $urn0 := $doc/*:bibl/*:urn/string()
let $citsch := $doc/*:bibl/*:citscheme/string()
let $grpname := $doc/*:bibl/*:grpname/string()
let $license := $doc/*:bibl/*:license/string()
let $worktitle := $doc/*:bibl/*:worktitle/string()
let $verlabel := $doc/*:bibl/*:verlabel/string()
let $exemplarlabel := $doc/*:bibl/*:exemplarlabel/string()
let $cts1 := "urn:cts:greekLit:" || replace(db:path($doc),":[a0-9\.\-]+\.xml",".token:")
let $cts1a := "urn:cts:greekLit:" || replace(db:path($doc),":[a0-9\.\-]+\.xml",".postag:")
let $cts1b := "urn:cts:greekLit:" || replace(db:path($doc),":[a0-9\.\-]+\.xml",".lemma:")
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
local:makeurn($doc, "token"),
local:makeurnpostag($doc, "postag"),
local:makeurnlemma($doc, "lemma"),
local:makeciteblocks(),
local:makerelations(),
local:makectspair($doc),
local:makectspairlemma($doc)
)
};
let $db := "grc-morf-pos"
for $f in db:open($db)/*:treebank[*:bibl]
let $urn := db:path($f)
let $cexname := "/home/neven/Repos/grcmorf/grcposcex2/" || replace($urn, "\.xml", ".cex")
return file:write($cexname , local:cex($urn), map { "item-separator": "&#xa;"})
