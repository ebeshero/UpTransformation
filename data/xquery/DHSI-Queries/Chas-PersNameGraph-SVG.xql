declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $Chas as document-node() := doc('/db/mitford/literary/Charles1.xml');
declare variable $ChasPlay as element() := $Chas/*;
declare variable $si as document-node() := doc('http://digitalmitford.org/si.xml');
declare variable $yStretchFactor := 10;
declare variable $xStretchFactor := 75;
<svg xmlns="http://www.w3.org/2000/svg" width="{14 * $xStretchFactor}" height="{50 * $yStretchFactor}" viewBox="0,0,1300,700">
<g transform="translate(100, 500)">
    <!--ebb: We've set transform="translate()" on the svg element above so you can plot the graph from 0,0. That makes it a lot easier to plot the SVG shapes, but it means that values above the X axis have to climb UP the screen from zero to negative numbers. The line below is the X axis, and we're setting it to start at 0,0 -->
        <line x1="0" y1="0" x2="{$xStretchFactor * 13}" y2="0" stroke="maroon" stroke-width="2"/>
        <!--The line below is the Y axis, and it, too, starts at 0,0 -->
        <line x1="0" y1="0" x2="0" y2="-300" stroke="maroon" stroke-width="2"/>
        <text x="200" y="-300" style="font-size:25;">Who is talked about the most in Mitford’s Charles the First?</text>

{
    let $Chaspersons := $Chas//tei:body//tei:persName
let $TotPersonsCount := count($Chaspersons)
let $siPersons := $si//tei:person
let $ChasPersonRefs := $Chaspersons/@ref/string()
let $distChPRs := sort(distinct-values($ChasPersonRefs))
let $countList :=
for $i in $distChPRs
let $countInPlay := count($Chaspersons[@ref = $i])
let $percent := $countInPlay div $TotPersonsCount * 100
where $percent > 2
order by $percent descending
return $i
for $i at $pos in $countList
let $siCPrs := $si//tei:person[@xml:id = substring-after($i, '#')]
let $name := ($siCPrs/tei:persName)[1]/string()
let $countInPlay := count($Chaspersons[@ref = $i])
let $percent := $countInPlay div $TotPersonsCount * 100
let $percentFormatted := format-number($percent, '#.#')
let $XPos := ($pos * $xStretchFactor - ($xStretchFactor div 2))
let $YPos := -($percent * $yStretchFactor)
let $height := $percent * $yStretchFactor
let $width := 50
let $TextXPos := $XPos + $width div 2
return
    <g id="{substring-after($i, '#')}">
      <rect x="{$XPos}" y="{$YPos}" width="{$width}" height="{$height}" fill="hsl(358, {$percent * 15}%, 30%)"/> 
      <text x="{$TextXPos}" y="{$YPos div 2}" fill="white" style="text-anchor: middle; font-size:smaller;">{$percentFormatted}%</text>
    <text x="{$TextXPos}" y="15" color="black" style="text-anchor: start" transform="rotate(45 {$TextXPos} 15)">{$name}</text>
             
   </g>
}
</g>
</svg>

