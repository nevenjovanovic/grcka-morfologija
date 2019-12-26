let $db := "grc-pos-dict"
let $result := element wordindex {
for $l in db:open($db)//lemma
let $set := 
for $w in $l/paradigm/word
let $pos := $w/@postag
group by $pos
return element morph { attribute postag { $pos } , 
attribute n { count($w) } , 
for $d in distinct-values($w/@form)
 return element forma { $d },
 element fontes {
for $fons in $w
let $did := $fons/@document_id/string() || $fons/@subdoc/string() || "." || $fons/@s_id/string() || "." || $fons/@id/string()
return element fons { $did }
} }
return element lemma {
  $l/@lemma , 
  attribute n { sum($set/@n) } ,
  $set
}
}
return $result