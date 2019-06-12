declare namespace ead="urn:isbn:1-931666-22-9";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";
let $eads as document-node()+ := collection("UU_SPC_AV_EADs")
let $subjects := $eads//ead:subject
for $i in distinct-values($subjects)
let $sources := distinct-values($subjects[. eq $i]/@source)
where count($sources) gt 1
order by $i
return concat(normalize-space(concat($i, ' appears in ', count($sources), ' sources: ', string-join($sources, ', '))), "&#x0a;")