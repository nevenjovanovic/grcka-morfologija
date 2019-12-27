(: for a URN of a token, retrieve sentence :)
(: tokenize a CTS URN :)
declare function local:anaurn($urn){
  tokenize($urn, ":")
};
(: return the document part of a CTS URN :)
declare function local:docurn($anaurn){
  string-join(
  (
  for $a in $anaurn[position() = 1 to 4]
  return $a ),
  ":"
) || ":"
};
(: tokenize the subreference of a CTS URN :)
declare function local:subdocseq($anaurn){
  for $a in tokenize($anaurn[5], "\.") return $a
};
(: from the tokenized subreference, get the subdoc string :)
declare function local:subdocstring($anaurn){
  replace( 
$anaurn[5] , "\.[0-9]+\.[0-9]+$", "")
};
(: format the sentence with two span types: word and punctuation :)
declare function local:format-sentence($wordn, $sentence){
  for $s in $sentence/word
let $w :=  $s/@form
let $wn := $s/@id
let $l := $s/@lemma
return if ($l="punc1") then element span {
  attribute class {"punc1"} , $w/string() } else 
  if ($wn=$wordn) then element span { 
  attribute class { "hit"} , $w/string() }
  else element span { 
  attribute class {"word"} , $w/string() }
};
let $urn := "urn:cts:greekLit:tlg0062.tlg068.ffzghr-pos:20.8.2.11"
let $db := "grc-morf-pos"
let $anaurn := local:anaurn($urn)
let $docurn := local:docurn($anaurn)
let $anaurnseq := local:subdocseq($anaurn)
let $subdocstring := local:subdocstring($anaurn)
let $sentence := db:open($db)/treebank/sentence[@document_id=$docurn and @subdoc=$subdocstring and @id=$anaurnseq[last() - 1]]
let $word := $sentence/word[@id=$anaurnseq[last()]]
return element div { 
attribute class { "sententia" } , 
element h1 { $urn || "#" || $word/@form/string() },
local:format-sentence($anaurnseq[last()], $sentence) }