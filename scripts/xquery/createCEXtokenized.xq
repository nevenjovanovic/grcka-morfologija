(: create CEX from xml :)
let $urn := "tlg0062.tlg029"
let $db := "grc-morf-pos"
for $doc in collection($db)//*:treebank
where matches(db:path($doc),$urn)
let $cts1 := replace(db:path($doc),":9.xml",".token:9")
for $s in $doc/*:sentence
  let $cts2 := $s/@id/string()
    for $w in $s/*:word
    let $cts3 := $w/@id/string() 
    let $token := $w/@form/string()
return $cts1 || "." || $cts2 || "." || $cts3 || "#" || $token
