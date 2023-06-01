declare namespace tei="http://www.tei-c.org/ns/1.0";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare variable $dvoinik := doc("Dvoinik.xml");



<html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <title>Data Tables of Character Dialogue Interactions, Types, and Frequencies</title>
                <style type="text/css">
                  body {{
                  text-align:center;
                  }}
                  
                  table {{
                  margin-left: 600px;
                  border-collapse: collapse;
                  }}
                  
                  thead {{
                  border-bottom: 4px solid black;
                  }}
                  
                  th[scope="row"] {{
                  border-right: 4px solid black;
                  }}
                  
                  td, th {{
                  border: 1px solid black;
                  text-align:center;
                  }}
                  
                  
                  tr:nth-child(even){{background-color: #f2f2f2;}}
                  
                  
                </style>
            </head>
            <body>
                <header>
                    <h1 class="header">Digital Dostoevsky</h1>
                    <h2 class="header">Toronto, Ontario</h2>
                </header>
                <hr/>
                <section class="body">
                    <h1>Data Tables of Character Dialogue Interactions, Types, and Frequencies in Dvoinik</h1>
                    <h2>Table of Character Dialogue Frequencies, Direct and Indirect / Said Aloud and Silent</h2>
                    <table>
                        <thead>
                            <tr>
                                <td></td>
                                <th>Direct</th>
                                <th>Indirect</th>
                                <th>Said Aloud</th>
                                <th>Not Said Aloud</th>
                                
                            </tr>
                        </thead>
                        
                        <tbody>
                            
                                {
                                let $saids := $dvoinik//tei:said
                                let $whos := $saids/@who ! tokenize(., '#')[2] ! normalize-space() => distinct-values()
                                    for $w in $whos
                                    
                                    
                                    (:let $name := ($dvoinik//tei:name[@ref ! tokenize(., '#')[2] ! normalize-space() = $w])[1] ! replace(., '[.,!?]', '') ! normalize-space():)
                                    let $direct := $saids[@direct = 'true' and @who ! tokenize(., '#')[2] ! normalize-space() = $w] => count()
                                    let $indirect := $saids[@direct = 'false' and @who ! tokenize(., '#')[2] ! normalize-space() = $w] => count()
                                    let $aloud := $saids[@aloud = 'true' and @who ! tokenize(., '#')[2] ! normalize-space() = $w] => count()
                                    let $silent := $saids[@aloud = 'false' and @who ! tokenize(., '#')[2] ! normalize-space() = $w] => count()
                                    order by $direct descending
                                    return 
                                    <tr>
                                <th scope="row">{$w}</th>
                                
                                
                                <td>{$direct}</td>
                                
                                <td>{$indirect}</td>
                                
                                <td>{$aloud}</td>
                                
                                <td>{$silent}</td>
                                
                                </tr>
                                
                                }
                                
                                
                                
                          
                            
                        </tbody>
                    </table>
                    
                    
                </section>
            </body>
        </html>