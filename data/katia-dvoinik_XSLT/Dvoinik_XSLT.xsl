<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        indent="yes"/>
    
    <xsl:template match="/">
        
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <title>Data Tables of Character Dialogue Interactions, Types, and Frequencies</title>
                <style type="text/css">
                    body {
                    text-align:center;
                    }
                    
                    table {
                    margin-left: 600px;
                    border-collapse: collapse;
                    }
                    
                    table.speak {
                    margin-left: 300px;
                    border-collapse: collapse;
                    }
                    
                    thead {
                    border-bottom: 4px solid black;
                    }
                    
                    th[scope="row"] {
                    border-right: 4px solid black;
                    }
                    
                    td, th {
                    border: 1px solid black;
                    text-align:center;
                    }
                    
                    
                    tr:nth-child(even){background-color: #f2f2f2;}
                    
                </style>
            </head>
            <body>
                <header>
                    <h1 class="header"><xsl:apply-templates select="TEI//publicationStmt/publisher"/></h1>
                    <h2 class="header"><xsl:apply-templates select="TEI//publicationStmt/pubPlace"/></h2>
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
                            <xsl:apply-templates select="//text/body"/>
                        </tbody>
                    </table>
                    
                    <hr/>
                    
                    <h2>To Whom the Most Talkative Characters Speak</h2>
                    <table class="speak">
                        <thead>
                            <tr>
                                <th>Speaker</th>
                                <th>Character Spoken To</th>
                                <!--<th># of Times Spoken to</th>-->
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates mode="talkmost" select="//text/body"/>
                        </tbody>
                    </table>
                    
                </section>
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="body">
        
        <xsl:variable name="body" as="element()" select="."/>
        
        <xsl:for-each select="descendant::said/@who ! tokenize(., '#')[2] ! normalize-space() => distinct-values()">
            
            <!-- This is how we are sorting the table from most direct dialogue descending! -->
            <xsl:sort select="$body//said[@direct = 'true' and @who ! tokenize(., '#')[2] ! normalize-space() = current()] => count()" order="descending"/>
            
            <tr>
            
            <th scope="row"><xsl:value-of select="current()"/></th>
            
            
            <td><xsl:value-of select="$body//said[@direct = 'true' and @who ! tokenize(., '#')[2] ! normalize-space() = current()] => count()"/></td>
            
            <td><xsl:value-of select="$body//said[@direct= 'false' and @who ! tokenize(., '#')[2] ! normalize-space() = current()] => count()"/></td>
            
            <td><xsl:value-of select="$body//said[@aloud= 'true' and @who ! tokenize(., '#')[2] ! normalize-space() = current()] => count()"/></td>
            
            <td><xsl:value-of select="$body//said[@aloud= 'false' and @who ! tokenize(., '#')[2] ! normalize-space() = current()] => count()"/></td>
        </tr></xsl:for-each>
        
    </xsl:template>
    
    <xsl:template mode="talkmost" match="body">
        
        <xsl:variable name="body" as="element()" select="."/>
        
        <xsl:variable name="topSpk" as="item()+">
            <xsl:variable name="speakers" select="descendant::said/@who ! tokenize(., '#')[2] ! normalize-space() => distinct-values()"/>
            
            <xsl:value-of select="for $i in $speakers return $i[count($body//said[@who ! tokenize(., '#')[2] ! normalize-space() = $i]) ge 50]"/>
            
              
            
        </xsl:variable>
        
        <xsl:for-each select="$topSpk ! tokenize(., ' ')">
            <tr>
            <td><xsl:value-of select="current()"/></td>
            
                <td><xsl:value-of select="$body//said[@who ! tokenize(., '#')[2] ! normalize-space() = current()]/@toWhom ! tokenize(., '#')[2] ! normalize-space() => distinct-values() =>string-join(', ')"/></td>
            
            <!--<td></td>-->
        </tr>
        </xsl:for-each>
        
        
    </xsl:template>
    
</xsl:stylesheet>