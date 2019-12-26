(: return list of lemmata and counts of occurrences :)
declare function local:lemcount($db){
let $lem := db:open($db)/wordindex/lemma
let $occount := sum(for $l in $lem
let $oc := $l/@n
return sum($oc))
return "Lemmata: " || count($lem)  || ". Verba occurrentia: " || $occount  || ".
"
};
let $db := "grc-pos-dict-idx"
return local:lemcount($db)