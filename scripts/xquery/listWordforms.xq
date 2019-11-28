(: list all different wordforms in the collection :)
(: normalize Unicode characters to NFC :)

let $db := "grc-morf-pos"
let $result :=
for $occ in collection($db)//*:word/@lemma/string()
let $form := normalize-unicode($occ)
group by $form
order by count($occ) descending , $form collation "?lang=el"
return ($form || " | " || count($occ) )
let $n := count($result)
return ( 
"# Statistics on Grčka morfologija 1 morphologically annotated collection: lemmata ordered by count of occurrences, " || fn:current-date()  || "

Script name: listWordforms.xq
", 
"Total wordforms (Unicode NFC normalized): " || $n || "

", 
"Wordform | Count" ,
" ---- | ---- ",
$result
)