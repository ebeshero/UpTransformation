<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"   
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
   
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:variable name="xml-coll" as="document-node()+" select="collection('xml-collection/')"/>
    <xsl:variable name="Asher" as="document-node()" select="doc('xml-collection/BTAsher20210429.xml')"/>
    <xsl:variable name="Haddad" as="document-node()" select="doc('xml-collection/BTHaddad20210425.xml')"/>
    <xsl:variable name="Adler" as="document-node()" select="doc('xml-collection/BTAdler20210419.xml')"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>BT Reading view</title>
<!--                <link rel="stylesheet" type="text/css" href="BT-style.css"/>-->
                <script type="text/javascript" src="BT-highlight.js">/**/</script>
                <style>
                    span.seg {
                    outline: maroon solid 1px;
                    }
                    span.seg.highlight {background-color: #ffd270;}
                </style>
               
            </head>   
            <body>
                <h1>Reading view of three parallel texts in translation</h1>
                
                <!--ebb: Output each document's main title -->
                <xsl:apply-templates select="$Asher//titleStmt/title"/>
                <xsl:apply-templates select="$Haddad//titleStmt/title"/>
                <xsl:apply-templates select="$Adler//titleStmt/title"/>
                
                
                <!--ebb: Now, set up the reading view. -->
              <section id="readingView"> 
                  <!--ebb: How about we set this up as a series of tables to align the sections with the same xml:ids ?  -->
                  
                <xsl:variable name="ab-ids" as="item()+" select="$xml-coll//ab/@xml:id => distinct-values()"/>
                  <xsl:for-each select="$ab-ids">
                     <table>
                        <tr>
                           <th>Asher edition</th> 
                           <th>Haddad edition</th>
                           <th>Adler edition</th>
                        </tr>
                         <tr>
                           <td><xsl:apply-templates select="$Asher//ab[@xml:id = current()]"/></td>
                           <td><xsl:apply-templates select="$Haddad//ab[@xml:id = current()]"/></td>
                           <td><xsl:apply-templates select="$Adler//ab[@xml:id = current()]"/></td>
                             
                         </tr>
                     </table> 
 
                  </xsl:for-each>
               
              </section>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="titleStmt/title">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    
<!--ebb: not sure whether we want this? 
 
        <xsl:template match="lb">
    <br/>
</xsl:template>
-->
<xsl:template match="seg">
        <span class="seg" id="{current() ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')}-{@xml:id}" title="{@xml:id}"><xsl:apply-templates/></span>
</xsl:template>

    
</xsl:stylesheet>