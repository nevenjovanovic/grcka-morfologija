let $parent := replace(file:parent(static-base-uri()), '/scripts/xquery/', '') 
let $path := $parent || "/grcpos/" 
return db:create("grc-morf-pos", $path, (), map { 'attrindex': true(), 'intparse' : true(), 'autooptimize' : true(), 'updindex' : true() })