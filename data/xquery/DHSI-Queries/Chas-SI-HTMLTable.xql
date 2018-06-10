declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $Chas as document-node() := doc('/db/mitford/literary/Charles1.xml');
declare variable $ChasPlay as element() := $Chas/*;
declare variable $si as document-node() := doc('http://digitalmitford.org/si.xml');
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><title>French Places in Charles the First</title>
        <style type="text/css">
        table, tr, th, td {{border:1px purple solid; border-collapse:collapse;}}
        td, th {{padding:.5em;}} 
        </style>
        
    </head>
    <body>
        <h1>French places in Mary Russell Mitford’s <i>Charles the First</i></h1>
    <table>
        <tr><th>Id</th><th>Full Name</th><th>Note</th>
            </tr>
{let $Chasplaces := $Chas//tei:placeName
let $siPlaces := $si//tei:place
let $ChasPlaceRefs := $Chasplaces/@ref/string()
let $siChasRefs := $si//tei:div/*/*[@xml:id][descendant::*/@*="#CharlesI_MRMplay"]
let $distChPRs := sort(distinct-values($ChasPlaceRefs))
for $i at $pos in $distChPRs
let $siCPrs := $si//tei:place[@xml:id = substring-after($i, '#')]
where $siCPrs[contains(string(.), 'France')]
let $name := $siCPrs/tei:placeName[1]
let $note := $siCPrs//tei:note
order by $siCPrs/@xml:id
(:  :return concat($name, ': ', $siCPrs//tei:note)  :)
return 
<tr>
<td>{$siCPrs/@xml:id/string()}</td>
 <td>{$name/string()}</td> 
 <td>{$note/string()}</td>
</tr>    
    
}   
 </table> 
 </body>
</html>




