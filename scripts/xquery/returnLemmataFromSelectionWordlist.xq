(: from a sequence of texts in the reader :)
(: return lemmata grouped, ordered by descending frequency :)
let $db := "grc-morf-pos"
let $sel := ("tlg0007.tlg044.ffzghr-pos:6.1.xml", "tlg0007.tlg067.ffzghr-pos:4.xml", "tlg0060.tlg001.ffzghr-pos:8.5-8.8.xml")
for $s in $sel
for $lem in db:open($db, $s)//*:word/@lemma[not(.="punc1")]
let $nlem := normalize-unicode($lem)
group by $nlem
where count($lem) > 1
order by count($lem) descending , $nlem  collation "?lang=el"
return ( $nlem , count($lem) )