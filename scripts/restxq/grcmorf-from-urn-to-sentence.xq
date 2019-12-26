(: CroALa Greek Morphology 1 :)
(: For a URN of word, return its sentence :)
(: Format later with CSS :)

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace gm = "http://croala.ffzg.unizg.hr/grcmorf" at "../../repo/grcmorf.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Grcmorf: verbum in sententia';
declare variable $content := "For a URN of a word, display the sentence in the grcmorf collection.";
declare variable $keywords := "Ancient Greek language, Ancient Greek literature, CTS / CITE architecture, learning, Ancient Greek reader, URN, lemmatization, lemma, morphological annotation, occurrence";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("ctsurn/{$urn}")
  %output:method(
  "xhtml"
)
  %output:omit-xml-declaration(
  "no"
)
  %output:doctype-public(
  "-//W3C//DTD XHTML 1.0 Transitional//EN"
)
  %output:doctype-system(
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
)
  function page:grcmorfurntosentence($urn)
{
  (: HTML template starts here :)

<html>
{ gm:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="fa fa-th fa-fw" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="row">
<div class="col">
<p>URN et eius vocabulum in eclogis, { current-date() }. <a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a>.</p>
<p>Token with the URN { $urn } and its sentence in the <a href="http://croala.ffzg.unizg.hr/eklogai/">Greek Morphology 1 Reader</a>.</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col">
{gm:infodb("grc-pos-dict-idx")}
</div>
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
  <!-- function here -->
{ 
let $db := "grc-morf-pos"
let $anaurn := gm:anaurn($urn)
let $docurn := gm:docurn($anaurn)
let $anaurnseq := gm:subdocseq($anaurn)
let $subdocstring := gm:subdocstring($anaurn)
let $sentence := db:open($db)/treebank/sentence[@document_id=$docurn and @subdoc=$subdocstring and @id=$anaurnseq[last() - 1]]
return gm:format-sentence($sentence)
}
</blockquote>
     <p/>
     </div>
<hr/>
{ gm:footerserver() }
</body>
</html>
};

return
