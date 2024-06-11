xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare variable $Chas as document-node() := doc('http://exist.newtfire.org/exist/rest/db/mitford/literary/Charles1.xml');
declare variable $si as document-node() := doc('http://exist.newtfire.org/exist/rest/db/mitford/si.xml');

<html>
  <head>
      <title>My page of French Places in Charles I</title>
       <style type="text/css">
        table, tr, th, td {{border:1px purple solid; border-collapse:collapse;}}
        td, th {{padding:.5em;}}</style>
  </head>
  <body>
      <h1>Table of French Places in MRM's Charles I</h1>
      
      <table>
          <tr>  
                <th>Position Number</th>
                <th>Id</th>
                <th>Full Name</th>
                <th>Note</th>
          </tr>
{
let $places := $si//tei:place
let $Chasplaces := $Chas//tei:placeName/@ref ! string()
let $distChPRs := $Chasplaces => distinct-values() => sort()
let $sequence := 
    for $dist in $distChPRs 
    let $siMatch := $places[@xml:id = substring-after($dist, '#')]
    (: We called this $siCPRs in the syllabus. :)
    (:   :order by $siMatch/@xml:id :)
    where $siMatch[contains(., 'France')]
    return $siMatch

for $s at $pos in $sequence
return 
    <tr> 
       <td>{$pos}</td>
       <td>{$s/@xml:id ! string()}</td>
       <td>{$s/tei:placeName[1] ! string()}</td>
       <td>{$s/tei:note ! string()}</td>
    </tr>
    
}
  </table>
</body>
</html>