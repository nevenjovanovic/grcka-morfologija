(: get statistical data on the treebank collection: how many POS? :)

(: for codes return full grammatical terms :)
declare variable $posnames := map {
  "v" : "verb (v)",
  "n" : "noun (n)",
  "l" : "article (l)",
  "a" : "adjective (a)",
  "p" : "pronoun (p)",
  "d" : "adverb (d)",
  "r" : "adposition (r)",
  "c" : "conjunction (c)",
  "i" : "interjection (i)",
  "m" : "numeral (m)",
  "u" : "punctuation (u)",
  "x" : "irregular (x)"
  
};

declare function local:count-texts($db){
  let $s := collection($db)//*:treebank
  return ("Texts (documents): " || count($s) || "
  ")
};

declare function local:count-sentences($db){
  let $s := collection($db)//*:sentence
  return ("Sentences: " || count($s) || "
  ")
};

declare function local:count-words($db){
  let $c := collection($db)//*:word
  return ("Words: " || count($c) || "
  ")
};

declare function local:count-words-no-punc($db){
  let $c := collection($db)//*:word[not(starts-with(@lemma, "punc"))]
  return ("Words excluding punctuation marks: " || count($c) || "
  ")
};

declare function local:count-words-missing-annotation($db){
  let $c := collection($db)//*:word[@postag=""]
  return ("Words with missing POS annotations: " || count($c) || "
  ")
};

declare function local:count-postag($db){
  let $c := collection($db)//*:word[not(@postag=("UNDEFINED", "nil", ""))]
  return ("Words with defined POS tags: " || count($c) || "
  ")
};


declare function local:postag-words($db){
   ( "# POS grouped by word count (W), in descending order
   " ,
"POS | W" ,  
" ---- | ---- " ,
  let $result := element r {
for $s in collection($db)//*:word[not(@postag=("UNDEFINED", "nil", ""))]/@postag/string()
let $pos := substring($s, 1, 1)
group by $pos
order by count($s) descending
return element pos { element p { if (map:get($posnames,$pos)) then map:get($posnames,$pos) else $pos } , element c { count($s) } }
}
for $r in $result/pos
return ( data($r/p) || " | " || data($r/c) )
)
};

let $db := "grc-morf-pos"
return ( 
"# Statistics on Grčka morfologija 1 Greek treebank collection: parts of speech, " || fn:current-date()  || "

Script name: GrcTBStatsPOS-1.xq
", 
local:count-texts($db) , 
local:count-sentences($db) , 
local:count-words($db) , 
local:count-words-no-punc($db) , 
local:count-postag($db) , 
local:count-words-missing-annotation($db) ,
local:postag-words($db) )
