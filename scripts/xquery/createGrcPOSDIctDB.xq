let $parent := replace(file:parent(static-base-uri()), '/scripts/xquery/', '') 
let $path := $parent || "/grcposdict/grcposdict.xml" 
return db:create("grc-pos-dict", $path, (), map { 'attrindex': true(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })