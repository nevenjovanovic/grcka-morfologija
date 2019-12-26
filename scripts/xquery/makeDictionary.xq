declare function local:lemmata($db){
  distinct-values(
for $l in db:open($db)//*:word[not(@lemma="punc1")]/@lemma/string()
return $l
)
};
let $db := "grc-morf-pos"
let $wordlist := element wordlist {
for $le in local:lemmata($db)
return element lemma {
  attribute lemma { $le },
  element paradigm {
for $o in db:open($db)//*:word
where $o/@lemma=$le
order by $o/@postag
return 
  element word {
    $o/../@document_id ,
  $o/../@subdoc ,
  attribute s_id { $o/../@id/string() } ,
    $o/@id ,
    $o/@postag,
    $o/@form
  }
}
}
}
let $dict := element dictionary {
for $w in $wordlist/lemma
order by $w/@lemma collation "?lang=el"
return $w
}
return $dict
