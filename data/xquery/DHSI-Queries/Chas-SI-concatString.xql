declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $Chas as document-node() := doc('/db/mitford/literary/Charles1.xml');
declare variable $ChasPlay as element() := $Chas/*;
declare variable $si as document-node() := doc('https://digitalmitford.org/si.xml');
let $Chasplaces := $Chas//tei:placeName
let $siPlaces := $si//tei:place
let $ChasPlaceRefs := $Chasplaces/@ref/string()
let $siChasRefs := $si//tei:div/*/*[@xml:id][descendant::*/@*="#CharlesI_MRMplay"]
let $distChPRs := sort(distinct-values($ChasPlaceRefs))
for $i at $pos in $distChPRs
let $siCPrs := $si//tei:place[@xml:id = substring-after($i, '#')]
where $siCPrs[contains(string(.), 'France')]
let $name := $siCPrs/tei:placeName[1]
order by $siCPrs/@xml:id
return concat($name, ': ', $siCPrs//tei:note)





