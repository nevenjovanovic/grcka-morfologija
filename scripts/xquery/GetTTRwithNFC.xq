(: for each file in the collection, calculate TTR :)
(: A type-token ratio (TTR) is the total number of UNIQUE words (types) divided by the total number of words (tokens) in a given segment of language. :)

(: normalize unicode to composed :)
declare function local:nfc($sequence){
  for $s in $sequence
  return normalize-unicode($s)
};

(: round the number to two decimal places :)
declare function local:rnd($a, $b){
  round($a div $b * 100) div 100
};
let $db := "grc-morf-pos"
for $t in collection($db)/*:treebank
let $words := local:nfc($t//*:word/@form/string())
let $lemmata := local:nfc($t//*:word/@lemma/string())
let $wc := count($words)
let $types := distinct-values($words)
let $tc := count($types)
let $lemtypes := distinct-values($lemmata)
let $ltc := count($lemtypes)
let $ttr := local:rnd($tc, $wc)
let $ltr := local:rnd($ltc, $wc)
order by $ttr ascending , $wc descending
return ( db:path($t), $wc, $tc , $ltc , $ttr , $ltr )
