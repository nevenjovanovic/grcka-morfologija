declare function local:getmorphology($doc,$cts1,$cts2){
for $s in $doc/*:sentence
let $cts3 := $s/@id/string()
  for $w in $s/*:word
  let $cts4 := $w/@id/string() 
  let $form := $w/@form/string()
  let $lemma := $w/@lemma/string()
  let $postag := $w/@postag/string()
  let $texturn := $cts1 || $cts2 || "." || $cts3 || "." || $cts4
return element div {
    attribute class {"fumorph_alignedMorphology"},
    attribute data-textUrn { $texturn },
    element div {
      attribute class {"fumorph_morphWithLex"},
      element div {
        attribute class {"fumorph_citableMorphology"},
        attribute data-morph-urn { replace($texturn, "token:", "morph:")},
        element div {
          attribute class {"fumorph_form"},
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
            "TBA"
          },
         element span {
           attribute class {"fumorph_info"},
           $postag
         }
        }
      },
    element div {
      attribute class {"fumorph_defs"},
      element div {
        attribute class {"fumorph_shortDef"},
        attribute data-lexicon-urn {"urn:cite2:hmt:lsj.chicago_md:n85306"},
        element span {
          attribute class {"fumorph_shortDef_lemma"},
          "TBA"
        },
        element span {
          attribute class {"fumorph_shortDef_definition"},
          "TBA"
        }
      }
    }
  }
}
};

declare function local:makectsdataline($doc,$cts1,$tag){
for $s in $doc/*:sentence
let $cts2 := $s/@id/string()
  for $w in $s/*:word
  let $cts3 := $w/@id/string() 
  let $value := $w/@*[name()=$tag]/string()
return $cts1 || "." || $cts2 || "." || $cts3 || "#" || $value
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

let $name := "Somnium sive vita Luciani 9 cum commento"
let $urn0 := "urn:cite2:cex:unizghr.ffzghrpos:lucianisomnium"
let $license := "Creative Commons Attribution 4.0 International (CC BY 4.0)  <https://creativecommons.org/licenses/by/4.0/>"
let $citsch := "paragraph,sentence,token"
let $grpname := "Lucianus Samosatensis"
let $worktitle := "Somnium sive vita Luciani 9"
let $verlabel := "Ex editione Caroli Jacobitz (1896) in collectione OGL"
let $exemplarlabel := "tokenized"
let $exemplarlabel2 := "morphological properties"
let $exemplarlabel3 := "lemmatized"
let $online := "true"
let $online2 := "online"
let $lang := "grc"

let $urn := "tlg0062.tlg029"
let $db := "grc-morf-pos"
for $doc in collection($db)//*:treebank
where matches(db:path($doc),$urn)
let $cts1 := "urn:cts:greekLit:" || replace(db:path($doc),":9.xml",".token:")
let $cts1a := "urn:cts:greekLit:" || replace(db:path($doc),":9.xml",".postag:")
let $cts1b := "urn:cts:greekLit:" || replace(db:path($doc),":9.xml",".lemma:")
let $cts2 := "9"
let $cts1t := $cts1 || $cts2
let $cts1p := $cts1a || $cts2
return ( element div {
  attribute class {"fumorph_morphologyRecords"},
  local:getmorphology($doc,$cts1,$cts2)
},
element div {
  attribute id { "text "},
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
      attribute class {"ohco2_passageGroup ohco2_stanza"},
      element div {
        attribute class {"ohco2_passageGroup  ohco2_tokenized"},
        element span {
          attribute class {"ohco2_passageComponent ohco2_displayPassage"},
          attribute data-ctsurn { $cts1t },
          $cts2
        },
        for $u in local:makeurn($doc, $cts1 || $cts2) 
        let $urn1 := substring-before($u, "#")
        let $token1 := substring-after($u, "#")
        return element span {
          attribute class {"annotation"},
          attribute data-tooltip-content { "#" || $urn1 } ,
          element span {
            attribute class {"ohco2_citableNodeText"},
            attribute data-ctsurn { $urn1 },
            $token1
          }
        }
      }
    }
  }
}
)