(: create HTML files with pages for each document in the grcpos DB :)
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
  "e": "μεσότης_καὶ_πάθος",
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

declare function local:jscript(){
  "$(document).ready(function() {
            $('.annotation').tooltipster({
    theme: ['tooltipster-light', 'tooltipster-light-customized'],
    arrow: 1,
    interactive: 1,
    multiple: true,
    side: 'bottom'
        });
        // initialize a second tooltip
		$('.annotation2').tooltipster({
		theme: ['tooltipster-light', 'tooltipster-light-customized'],
        arrow: 1,
        interactive: 1,
	    multiple: true,
	    side: 'right'
});
$('.annotation3').tooltipster({
		theme: ['tooltipster-light', 'tooltipster-light-customized'],
        arrow: 0,
        interactive: 1,
	    multiple: true,
	    side: 'top'
});
});"
};

declare function local:htmlframe($title, $result){
<html>
<head>
  <title>{$title}, cum analysi grammatica et lemmatibus</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link href="https://fonts.googleapis.com/css?family=EB+Garamond:400,400i,800,800i&amp;subset=greek,greek-ext,latin-ext" rel="stylesheet"/>
  	<link rel="stylesheet" type="text/css" href="tooltipster-master/dist/css/tooltipster.bundle.min.css" />
  	<link rel="stylesheet" type="text/css" href="tooltipster-master/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-light.min.css" />
  	<link rel="stylesheet" type="text/css" href="css/tt-custom.css" />
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.0.min.js">&amp;</script>
  <script type="text/javascript" src="tooltipster-master/dist/js/tooltipster.bundle.min.js">&amp;</script>
<script> { local:jscript() } </script>
</head>
<body>
  <h1> { $title }, cum analysi grammatica et lemmatibus</h1>
	<p class="page_subtitle">Odaberite riječ da biste vidjeli lemu i gramatički opis.</p>
<!-- početak -->
{ $result }
</body>
</html>

};

declare function local:formatmorph($sequence){
  replace(
           replace(
           string-join(
           tokenize(
             string-join($sequence, " "), " +"
), ", "), ", $", ""), "_", " ")
};

declare function local:getmorphology($doc){
for $s in $doc/*:sentence
let $cts3 := $s/@document_id/string() || $s/@subdoc/string() || "." || $s/@id/string()
  for $w in $s/*:word
  let $cts4 := $w/@id/string() 
  let $form := $w/@form/string()
  let $lemma := $w/@lemma/string()
  let $postag := $w/@postag/string()
  let $textid := replace((substring-after($cts3, "ffzghr-pos:") || "-" || $cts4), "\.", "-")
  let $texturn := $cts3 || "." || $cts4
return ( element span {
  attribute id { $textid || "c" },
  element p{ 
  element span {
            attribute class {"fumorph_surfaceForm"},
            $form
          },
          element span {
            attribute class {"fumorph_lemma"},
            $lemma
          } } },
  element span {
  attribute id { $textid || "b" },
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
         } },
element span {
  attribute id { $textid },
         element span {
           attribute class {"fumorph_info2"},
           element a { 
           attribute href { "http://croala.ffzg.unizg.hr/basex/ctsurn/" || $texturn },
           $texturn }
         }
       }
     )
};

declare function local:getcropos($postag,$posmap,$n){
  let $s := string-to-codepoints($postag)[$n]
  return map:get($posmap , codepoints-to-string($s))
};

declare function local:makectsdataline($doc,$tag){
for $s in $doc/*:sentence
let $cts2 := $s/@document_id/string() || $s/@subdoc/string() || "." || $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := $w/@*[name()=$tag]/string()
return $cts2 || "." || $cts3 || "#" || $value
};

declare function local:makeurn($doc){
  local:makectsdataline($doc,"form")
};

let $exemplarlabel2 := "morphological properties"
let $exemplarlabel3 := "lemmatized"
let $online2 := "online"
let $lang := "grc"

let $db := "grc-morf-pos"
for $doc in db:open($db)//*:treebank
let $name := $doc/*:bibl/*:name/string()
let $urn0 := $doc/*:bibl/*:urn/string()
let $citsch := replace($doc/*:bibl/*:citscheme/string(), ",", ", ")
let $grpname := $doc/*:bibl/*:grpname/string()
let $license := $doc/*:bibl/*:license/string()
let $worktitle := $doc/*:bibl/*:worktitle/string()
let $verlabel := $doc/*:bibl/*:verlabel/string()
let $exemplarlabel := $doc/*:bibl/*:exemplarlabel/string()
let $online := $doc/*:bibl/*:online/string()
let $lang := $doc/*:bibl/*:lang/string()

let $result := ( element div {
  attribute class {"fumorph_morphologyRecords"},
  local:getmorphology($doc)
},
element div {
  attribute id { "text-grc"},
  element div {
    attribute class { "ohco2_versionCorpus"},
element div {
      attribute class {"ohco2_catalogEntry"},
      attribute data-ctsurn { $urn0 },
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
        $urn0
      }
    },    
    element div {
        
        for $u in local:makeurn($doc) 
        let $urn1 := substring-before($u, "#")
        let $token1 := substring-after($u, "#")
        return element span {
          attribute class { "annotation3"},
          attribute data-tooltip-content { "#" || replace(
            replace($urn1, ".*ffzghr-pos:",""), "[\.:]", "-") || "c" } ,
        element span {
          attribute class { "annotation2"},
          attribute data-tooltip-content { "#" || replace(
            replace($urn1, ".*ffzghr-pos:",""), "[\.:]", "-") || "b" } ,
        element span {
          attribute class {"annotation"},
          attribute data-tooltip-content { "#" || replace(
            replace($urn1, ".*ffzghr-pos:",""), "[\.:]", "-") } ,
          element span {
            attribute class {"ohco2_citableNodeText"},
            attribute data-ctsurn { $urn1 },
            if (matches($token1, "[.,;·]")) then ( attribute data-punct { "punct1"}, $token1 )
            else $token1
          } } }
        }
      }
    }
  }
)
return file:write("/home/neven/Repos/grcmorf/html/" || replace(db:path($doc), "\.xml", ".html"), local:htmlframe($name, $result), map { "method": "html", "html-version": "5.0" })