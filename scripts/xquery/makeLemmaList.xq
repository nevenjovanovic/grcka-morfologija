(: return list of lemmata and counts of occurrences :)
declare function local:lemlist($db){
for $l in db:open($db)/wordindex/lemma
let $l1 := $l/@lemma/string()
let $oc := $l/@n/string()
return element tr {
  element td { $l1 },
  element td { $oc }
}  
};
let $db := "grc-pos-dict-idx"
return local:lemlist($db)