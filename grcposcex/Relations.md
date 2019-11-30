# Possible relations in morphologically annotated and lemmatized, tokenized texts

Following the [CEX 3.0.1 specification](https://github.com/cite-architecture/citedx/blob/master/docs/CEX-spec-3.0.1.md), validated by the [CEX validator](https://github.com/cite-architecture/citedx#validating-and-contributing-your-own-libraries).

A model: [DUCAT alignment in CEX](https://github.com/Eumaeus/fuCiteDX/blob/master/alignments/Catullus1-aligned.cex) by Christopher Blackwell.

Inspired partly by the [GOLD Ontology](http://linguistics-ontology.org/version).

1. hasProperty (a word has the following morphological description): `urn:cite2:cite:grcmorfverbs.2019a:hasProperty`
2. hasLemma (a word has the following lemma in the dictionary): `urn:cite2:cite:grcmorfverbs.2019a:hasLemma`
3. isLemmaOf (a lemma has the following wordform in the text): `urn:cite2:cite:grcmorfverbs.2019a:isLemmaOf`
4. isPropertyOf (a morphological description belongs to the following wordform in the text): `urn:cite2:cite:grcmorfverbs.2019a:isPropertyOf`

# The citecollections block

```

#!citecollections
URN#Description#Labelling property#Ordering property#License
urn:cite2:cite:grcmorfverbs.2019a:#Linguistic annotations of Ancient Greek words#urn:cite2:cite:grcmorfverbs.2019a.annotation:##CC BY 4.0

```
# The citeproperties block

Source: [https://github.com/Eumaeus/fuCiteDX/blob/master/alignments/Catullus1-aligned.cex]

```
#!citeproperties
Property#Label#Type#Authority list
urn:cite2:cite:grcmorfverbs.2019a.urn:#Linguistic Annotation#Cite2Urn#
urn:cite2:cite:grcmorfverbs.2019a.label:#Linguistic Annotation#String#

```

# The citedata block

First attempt:

```
#!citedata
urn#label#description#editor#date
urn:cite2:cite:grcmorfverbs.2019a:hasProperty#Has morphological annotation#Adds a manual morphological description of a Greek linguistic unit using ALDT codes#Klara Radovniković#2019-11-07 21:49:59 UTC
urn:cite2:cite:grcmorfverbs.2019a:isPropertyOf#Is morphological property#Manual morphological description (using ALDT codes) belongs to a Greek linguistic unit#Klara Radovniković#2019-11-07 21:49:59 UTC
urn:cite2:cite:grcmorfverbs.2019a:hasLemma#Is a form of a lexical unit#A Greek linguistic unit belongs to the following lemma (unit of the vocabulary)#Klara Radovniković#2019-11-07 21:49:59 UTC
urn:cite2:cite:grcmorfverbs.2019a:isLemmaOf#Is lexical unit of a form#A Greek lemma (unit of the vocabulary) dominates a linguistic unit (form)#Klara Radovniković#2019-11-07 21:49:59 UTC

```

A version that works and is implemented:

```
#!citedata
urn#label
urn:cite2:cite:grcmorfverbs.2019a:hasProperty#Has morphological annotation
urn:cite2:cite:grcmorfverbs.2019a:isPropertyOf#Is morphological property of a linguistic unit
urn:cite2:cite:grcmorfverbs.2019a:hasLemma#Is a form of the lexical unit
urn:cite2:cite:grcmorfverbs.2019a:isLemmaOf#Is lexical unit of a form
```

#!relations

```

// 1. Relation of token to its morphological annotation:
urn:cts:greekLit:tlg0062.tlg029.ffzghr-pos.token:9.1.3#urn:cite2:cite:grcmorfverbs.2019a:hasProperty#urn:cite2:unizghrpos:tlg0062.tlg029.ffzghr-pos.postag:9.1.3
// 2. Relation of token to its lemma:
urn:cts:greekLit:tlg0062.tlg029.ffzghr-pos.token:9.1.3#urn:cite2:cite:grcmorfverbs.2019a:hasLemma#urn:cite2:unizghrpos:tlg0062.tlg029.ffzghr-pos.lemma:9.1.3

```
