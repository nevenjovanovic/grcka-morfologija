(: create one CEX from multiple xml documents :)
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
  $urn
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

let $header :=
  "#!ctscatalog

urn#citationScheme#groupName#workTitle#versionLabel#exemplarLabel#online#lang
"

let $exemplarlabel2 := "morphological properties"
let $exemplarlabel3 := "lemmatized"
let $online := "true"
let $lang := "grc"
let $license0 := "Creative Commons Attribution 4.0 International (CC BY 4.0)  https://creativecommons.org/licenses/by/4.0/"
let $name0 := "ffzghr-grc-morph"
let $urn0 := "urn:cite2:cex:unizghr.ffzghrpos:ffzghrgrcmorph"

let $db := "grc-morf-pos"
let $datalist :=
for $doc in db:open($db)//*:treebank[bibl]
let $name := $doc/*:bibl/*:name/string()
let $urn0 := $doc/*:bibl/*:urn/string()
let $citsch := $doc/*:bibl/*:citscheme/string()
let $grpname := $doc/*:bibl/*:grpname/string()
let $license := $doc/*:bibl/*:license/string()
let $worktitle := $doc/*:bibl/*:worktitle/string()
let $verlabel := $doc/*:bibl/*:verlabel/string()
let $exemplarlabel := $doc/*:bibl/*:exemplarlabel/string()
let $cts1 := replace($doc/*:sentence[1]/@document_id/string(), ":$", ".token:")
let $cts1a := replace($doc/*:sentence[1]/@document_id/string(), ":$", ".postag:")
let $cts1b := replace($doc/*:sentence[1]/@document_id/string(), ":$", ".lemma:")
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
order by $cts1
return element res {
  for $l in local:makectscatalog(
  ( $urnword , $urnpostag , $urnlemma )
) return element catalog { $l } ,
for $t in local:makectsdataline($doc,"token","form") return element cts { $t} ,
for $p in local:makectsdataline($doc,"postag","postag") return element cts { $p } ,
for $lem in local:makectsdataline($doc,"lemma","lemma") return element cts { $lem },
for $cit in local:makectspair($doc) return element cite { $cit },
for $citlem in local:makectspairlemma($doc) return element cite { $citlem }
}
return (
    local:makecexversion() , 
    local:makecitelibrary($name0,$urn0,$license0),
    $header , 
    distinct-values(
    for $d in $datalist/catalog
    return $d/string()
  ),
  "#!ctsdata",
  for $d in $datalist/cts
  return $d/string(),
  local:makeciteblocks(),
local:makerelations(),
for $c in $datalist/cite
return $c/string()
  )
