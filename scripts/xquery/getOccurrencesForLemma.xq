(: for a lemma, return list of occurrences with locations and counts :)
(: format as rows of a table :)
declare function local:getocc($db, $lemma){
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
  element td { $m/fontes/fons }
} ) )
};
let $le := "θάνατος"
let $db := "grc-pos-dict-idx"
return local:getocc($db, $le)