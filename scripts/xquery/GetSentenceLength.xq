(: for each file in the collection, get sentence count and calculate average sentence length :)
(: number of words in the sentence divided by the number of sentences :)

(: round the number to two decimal places :)
declare function local:rnd($a, $b){
  round($a div $b * 100) div 100
};
let $db := "grc-morf-pos"
for $t in collection($db)/*:treebank
let $sc := count($t/*:sentence)
let $wc := count($t//*:word)
let $sentlen := local:rnd($wc, $sc)
order by $sentlen
return (db:path($t), $sc , $sentlen)