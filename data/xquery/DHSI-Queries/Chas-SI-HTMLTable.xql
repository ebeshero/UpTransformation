declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $si as document-node() := doc("https://digitalmitford.org/si.xml");
declare variable $Chas as document-node() :=
doc("https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/Charles1.xml");
declare variable $places as element(tei:place)* := $si/descendant::tei:place;
declare variable $Chasplaces as element(tei:placeName)* := $Chas/descendant::tei:placeName;
declare variable $Chas_placerefs as attribute(ref)* := $Chasplaces//@ref;
declare variable $distinct-Chas_placerefs := distinct-values($Chas_placerefs);
                
<html
    xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Places in Mary Mitford’s play “Charles I”</title>
        <style type="text/css">
            table, tr, th, td {{border:1px purple solid; border-collapse:collapse;}}
            td, th {{padding:.5em;}}
        </style>
    </head>
    <body>
        <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Note</th>
            <th>Original position</th>
            <th>Output position</th>
        </tr>
            {
                for $i at $pos in $distinct-Chas_placerefs
                let $si_match := $si//tei:place[@xml:id eq substring-after($i, '#')]
                where contains($si_match, "France")
                order by $pos descending
                count $counter
                return
                    <tr>
                        <td>{$si_match/@xml:id/string()}</td>
                        <td>{$si_match/tei:placeName[1]/string()}</td>
                        <td>{$si_match/tei:note[1]/string()}</td>
                        <td>{$pos}</td>
                        <td>{$counter}</td>
                    </tr>
            }
        </table>
    </body>
</html>
