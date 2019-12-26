(: CroALa Greek Morphology 1 :)
(: For a lemma, list lemmata occurrences, morphological annotations, counts, CTS locations :)

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace gm = "http://croala.ffzg.unizg.hr/grcmorf" at "../../repo/grcmorf.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Grcmorf: verba occurrentia';
declare variable $content := "For a lemma, display occurrences, morphological annotation, counts, locations with links to text.";
declare variable $keywords := "Ancient Greek language, Ancient Greek literature, CTS / CITE architecture, learning, Ancient Greek reader, URN, lemmatization, lemma, morphological annotation, occurrence";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("grcmorf-occur/{$lemma}")
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
  function page:grcmorflistciteoccurrrences($lemma)
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
<p>Lemmata in eclogis, { current-date() }. <a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a>.</p>
<p>Occurrences of the lemma { $lemma }, their frequencies and locations in the <a href="http://croala.ffzg.unizg.hr/eklogai/">Greek Morphology 1 Reader</a>. Links lead to locations in individual documents.</p>
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
	<div class="table-responsive">

  <!-- function here -->
{ 
gm:table( ( "Lemma, descriptio, forma" , "Quoties, locatio"),
gm:getocc("grc-pos-dict-idx", $lemma) 
)
}
     </div>
</blockquote>
     <p/>
     </div>
<hr/>
{ gm:footerserver() }
</body>
</html>
};

return
