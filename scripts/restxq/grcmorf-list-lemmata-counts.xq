(: CroALa Greek Morphology 1 :)
(: List lemmata with total counts of occurrences, links to indices of individual types and locations :)

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace gm = "http://croala.ffzg.unizg.hr/grcmorf" at "../../repo/grcmorf.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Grcmorf: lemmata';
declare variable $content := "Display counts of lemmata with links to individual occurrences.";
declare variable $keywords := "Ancient Greek language, Ancient Greek literature, CTS / CITE architecture, learning, Ancient Greek reader, URN, lemmatization, lemma";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("grcmorf-lemmata")
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
  function page:grcmorflistcitelemmatasumma()
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
<p>A list of lemmata and their frequencies in the <a href="http://croala.ffzg.unizg.hr/eklogai/">Greek Morphology 1 Reader</a>. Links lead to lists of occurrences and frequencies in individual documents.</p>
<p>Functio nominatur: {rest:uri()}.</p>
<p>{ gm:leminfo("grc-pos-dict-idx") }</p>
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
gm:table( ( "Lemma" , "Occurrit"),
gm:lemlist("grc-pos-dict-idx") 
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


