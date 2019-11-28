(: how many different wordforms in the collection? :)
(: normalize Unicode characters to NFC :)

let $db := "grc-tb-g"
let $result :=
for $occ in collection($db)//*:word/@form/string()
let $form := normalize-unicode($occ)
group by $form
order by count($occ) descending , $form collation "?lang=el"
return ($form || " | " || count($occ) )
let $n := count($result)
return ( 
"# Statistics on Vanessa Gorman's Greek treebank collection: wordforms ordered by count of occurrences, " || fn:current-date()  || "

Script name: FindWordforms1.xq
", 
"Total wordforms (Unicode NFC normalized): " || $n || "

Show only first 200 entries
", 
"Wordform | Count" ,
" ---- | ---- ",
$result[position()<200]
)