(: for each file in the collection, get word count and calculate average word length :)
(: number of characters in a word divided by the number of words :)

(: round the number to two decimal places :)
declare function local:rnd($a, $b){
  round($a div $b * 100) div 100
};
let $db := "grc-morf-pos"
for $t in collection($db)/*:treebank
let $words := $t//*:word/@form/string()
let $charcount := round(avg(for $w in $words return count(string-to-codepoints(normalize-unicode($w)))) * 100) div 100
let $wc := count($words)
order by $charcount ascending
return (db:path($t), $wc , $charcount )