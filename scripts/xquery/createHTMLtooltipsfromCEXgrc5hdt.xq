(: Greek grammatical terms:)
declare variable $pos1grc := map {
  "n": "ὄνομα",
  "a": "ἐπίθετον",
  "d": "ἐπίρρημα",
  "c": "σύνδεσμος",
  "r": "πρόθεσις",
  "p": "ἀντωνυμία",
  "e": "ἐπιφώνημα",
  "i": "ἐπιφώνημα",
  "v": "ῥῆμα",
  "m": "ἀριθμός",
  "u": "διαστιγμή",
  "l": "ἄρθρον",
  "g": "μόριον",
  "x": "παράλογον",
  "-": ""
};

declare variable $pos2grc := map {
  "1": "πρῶτον_πρόσωπον",
  "2": "δεύτερον_πρόσωπον",
  "3": "τρίτον_πρόσωπον",
  "-": ""
};

declare variable $pos3grc := map {
  "s": "ἑνικός",
  "p": "πληθυντικός",
  "d": "δυϊκός",
  "-": ""
};

declare variable $pos4grc := map {
  "p": "ἐνεστώς",
  "i": "παρατατικός",
  "r": "παρακείμενος",
  "l": "ὑπερσυντέλικος",
  "t": "ὑπερσυντέλικος_β",
  "f": "μέλλων",
  "a": "ἀόριστος",
  "-": ""
};

declare variable $pos5grc := map {
  "i": "ὁριστική",
  "s": "ὑποτακτική",
  "n": "ἀπαρέμφατος",
  "m": "προστακτική",
  "p": "μετοχή",
  "o": "εὐκτική",
  "-": ""
};

declare variable $pos6grc := map {
  "a": "ἐνέργεια",
  "p": "πάθος",
  "m": "μεσότης",
  "e": "μεσότης καὶ πάθος",
  "d": "ἀποθετικόν",
  "-": ""
};

declare variable $pos7grc := map {
  "m": "ἄρρεν",
  "f": "θηλύ",
  "n": "οὐδέτερον",
  "-": ""
};

declare variable $pos8grc := map {
  "n": "εὐθεῖα",
  "g": "γενική",
  "d": "δοτική",
  "a": "αἰτιατική",
  "v": "κλητική",
  "l": "τοπική",
  "-": ""
};

declare variable $pos9grc := map {
  "p": "ἀπολελυμένως",
  "c": "συγκριτικόν",
  "s": "ὑπερθετικόν",
  "-": ""
};

(: Croatian grammatical terms :)
declare variable $pos1 := map {
  "n": "imenica",
  "a": "pridjev",
  "d": "prilog",
  "c": "veznik",
  "r": "prijedlog",
  "p": "zamjenica",
  "e": "uzvik",
  "i": "uzvik",
  "v": "glagol",
  "m": "broj",
  "u": "interpunkcija",
  "l": "član",
  "g": "čestica",
  "x": "nepravilno",
  "-": ""
};

declare variable $pos2 := map {
  "1": "1._l.",
  "2": "2._l.",
  "3": "3._l.",
  "-": ""
};

declare variable $pos3 := map {
  "s": "singular",
  "p": "plural",
  "d": "dual",
  "-": ""
};

declare variable $pos4 := map {
  "p": "prezent",
  "i": "imperfekt",
  "r": "perfekt",
  "l": "pluskvamperfekt",
  "t": "futur_drugi",
  "f": "futur",
  "a": "aorist",
  "-": ""
};

declare variable $pos5 := map {
  "i": "indikativ",
  "s": "konjunktiv",
  "n": "infinitiv",
  "m": "imperativ",
  "p": "particip",
  "o": "optativ",
  "-": ""
};

declare variable $pos6 := map {
  "a": "aktiv",
  "p": "pasiv",
  "m": "medij",
  "e": "mediopasiv",
  "d": "deponentan",
  "-": ""
};

declare variable $pos7 := map {
  "m": "m._r.",
  "f": "ž._r.",
  "n": "sr._r.",
  "-": ""
};

declare variable $pos8 := map {
  "n": "nominativ",
  "g": "genitiv",
  "d": "dativ",
  "a": "akuzativ",
  "v": "vokativ",
  "l": "lokativ",
  "-": ""
};

declare variable $pos9 := map {
  "p": "pozitiv",
  "c": "komparativ",
  "s": "superlativ",
  "-": ""
};

declare function local:formatmorph($sequence){
  replace(
           replace(
           string-join(
           tokenize(
             string-join($sequence, " "), " +"
), ", "), ", $", ""), "_", " ")
};

declare function local:getmorphology($doc,$cts1){
for $s in $doc/*:sentence
let $cts3 := $s/@subdoc/string() || "." || $s/@id/string()
  for $w in $s/*:word
  let $cts4 := $w/@id/string() 
  let $form := $w/@form/string()
  let $lemma := $w/@lemma/string()
  let $postag := $w/@postag/string()
  let $textid := replace(($cts3 || "-" || $cts4), "\.", "-")
  let $texturn := $cts1 || $cts3 || "." || $cts4
return element span {
  attribute id { $textid },
element span {
            attribute class {"fumorph_surfaceForm"},
            $form
          },
          element span {
            attribute class {"fumorph_lemma"},
            $lemma
          },
         element span {
           attribute class {"fumorph_formType"},
           $postag
         },
         element span {
           attribute class {"fumorph_info"},
           local:formatmorph(
             (local:getcropos($postag,$pos1grc,1),
           local:getcropos($postag,$pos2grc,2),
         local:getcropos($postag,$pos3grc,3),
       local:getcropos($postag,$pos4grc,4),
     local:getcropos($postag,$pos5grc,5),
   local:getcropos($postag,$pos6grc,6),
 local:getcropos($postag,$pos7grc,7),
local:getcropos($postag,$pos8grc,8))
)
         },
         element span {
           attribute class {"fumorph_info2"},
           $texturn
         }
       }
};

declare function local:getcropos($postag,$posmap,$n){
  let $s := string-to-codepoints($postag)[$n]
  return map:get($posmap , codepoints-to-string($s))
};

declare function local:makectsdataline($doc,$cts1,$tag){
for $s in $doc/*:sentence
let $cts2 := $s/@subdoc/string() || "." || $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := $w/@*[name()=$tag]/string()
return $cts1 || $cts2 || "." || $cts3 || "#" || $value
};

declare function local:makeurn($doc, $cts1){
  local:makectsdataline($doc,$cts1,"form")
};



declare function local:makeurnpostag($doc, $cts1){
  let $header := "#!ctsdata"
  let $data := local:makectsdataline($doc,$cts1,"postag")
return ($header, $data)
};

declare function local:makeurnlemma($doc, $cts1){
  let $header := "#!ctsdata"
  let $data := local:makectsdataline($doc,$cts1,"lemma")
return ($header, $data)
};

let $name := "Historiae 2, 77, 12 cum commento"
let $urn0 := "urn:cite2:cex:unizghr.ffzghrpos:herodotushistoriae"
let $license := "Creative Commons Attribution 4.0 International (CC BY 4.0)  <https://creativecommons.org/licenses/by/4.0/>"
let $citsch := "liber,caput,paragraphus,sententia,membrum"
let $grpname := "Herodotus"
let $worktitle := "Historiae"
let $verlabel := "Ex editione Augustus Chapman Merriam (1885) in collectione OGL"
let $exemplarlabel := "tokenized"
let $exemplarlabel2 := "morphological properties"
let $exemplarlabel3 := "lemmatized"
let $online := "true"
let $online2 := "online"
let $lang := "grc"

let $urn := "tlg0016.tlg001.ffzghr-pos:2.77.12.xml"

let $db := "grc-morf-pos"
for $doc in db:open($db,$urn)//*:treebank
let $cts1 := "urn:cts:greekLit:" || replace(db:path($doc),":2.77.12.xml",".token:")
let $cts1a := "urn:cts:greekLit:" || replace(db:path($doc),":2.77.12.xml",".postag:")
let $cts1b := "urn:cts:greekLit:" || replace(db:path($doc),":2.77.12.xml",".lemma:")
let $cts1t := $cts1
let $cts1p := $cts1a
return ( element div {
  attribute class {"fumorph_morphologyRecords"},
  local:getmorphology($doc,$cts1)
},
element div {
  attribute id { "text-grc"},
  element div {
    attribute class { "ohco2_versionCorpus"},
element div {
      attribute class {"ohco2_catalogEntry"},
      attribute data-ctsurn { $cts1 },
      element span {
        attribute class { "ohco2_catalogEntry_lang"},
        $lang
      },
      element span {
        attribute class {"ohco2_catalogEntry_groupName"},
        $grpname
      },      
      element span {
        attribute class {"ohco2_catalogEntry_workTitle"},
        $worktitle
      },
      element span {
        attribute class {"ohco2_catalogEntry_versionLabel"},
        $verlabel
      },
      element span {
        attribute class {"ohco2_catalogEntry_online"},
        $online2
      },
      element span {
        attribute class {"ohco2_catalogEntry_citationScheme"},
        $citsch
      },
      element span {
        attribute class {"cite_urn ctsUrn"},
        $cts1
      }
    },    
    element div {
        element span {
          attribute class {"ohco2_passageComponent ohco2_displayPassage"},
          attribute data-ctsurn { $cts1t },
          $cts1
        },
        for $u in local:makeurn($doc, $cts1) 
        let $urn1 := substring-before($u, "#")
        let $token1 := substring-after($u, "#")
        return element span {
          attribute class {"annotation"},
          attribute data-tooltip-content { "#" || replace(
            replace($urn1, ".*token:",""), "[\.:]", "-") } ,
          element span {
            attribute class {"ohco2_citableNodeText"},
            attribute data-ctsurn { $urn1 },
            $token1
          }
        }
      }
    }
  }
)