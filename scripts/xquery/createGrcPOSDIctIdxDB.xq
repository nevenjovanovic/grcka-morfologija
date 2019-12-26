let $parent := replace(file:parent(static-base-uri()), '/scripts/xquery/', '') 
let $path := $parent || "/grcposdict/grcposdictidx.xml" 
return db:create("grc-pos-dict-idx", $path, (), map { 'attrindex': true(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })