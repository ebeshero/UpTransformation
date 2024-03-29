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
                <!--ebb: Here I'm linking an external CSS file and an external JavaScript file. These will show
                up in the output HTML, and be ready for styling. 
                The CSS and JS files are stored with this XSLT and its output. -->
                <link rel="stylesheet" type="text/css" href="BT-style.css"/>
                <script type="text/javascript" src="BT-highlight.js">/**/</script>
            </head>   
            <body>
                <h1>Reading view of three parallel texts in translation</h1>
                
              
                  
                
                   
                <!--ebb: Now, set up the reading view. -->
              <section id="readingView"> 
                  <!--ebb: How about we set this up as a series of tables to align the sections with the same xml:ids ?  -->
                  
                <xsl:variable name="ab-ids" as="item()+" select="$xml-coll//ab/@xml:id ! normalize-space() => distinct-values()"/>
                 
                  <xsl:for-each select="$ab-ids">
                     <table> 
               <!-- mb: Here is where we tell the XSLT to ONLY output the title statement titles above the FIRST section of text,
                         WHEN the position in the for loop is 1.-->
                         <xsl:choose>
                         <xsl:when test="position() eq 1">
                         <tr>
                             <th><xsl:apply-templates select="$Asher//titleStmt/title"/></th>
                             <th><xsl:apply-templates select="$Haddad//titleStmt/title"/></th>
                             <th><xsl:apply-templates select="$Adler//titleStmt/title"/></th>
                         </tr>
                         <tr>
                              <td class="rtl"><xsl:apply-templates select="$Asher//ab[@xml:id = current()]"/></td>
                              <td class="rtl"><xsl:apply-templates select="$Haddad//ab[@xml:id = current()]"/></td>
                              <td><xsl:apply-templates select="$Adler//ab[@xml:id = current()]"/></td> 
                        </tr>
                         </xsl:when>
                             <!-- mb: The following code says  OTHERWISE, when the position of sections isn't 1 in the for loop,
                                 output this condensed heading instead, and continue pushing out the rest of the sections.-->
                             <xsl:otherwise>
                             <tr>
                                 <th>Asher edition</th> 
                                 <th>Haddad edition</th>
                                 <th>Adler edition</th>
                             </tr>
                             <tr>
                                 <td class="rtl"><xsl:apply-templates select="$Asher//ab[@xml:id = current()]"/></td>
                                 <td class="rtl"><xsl:apply-templates select="$Haddad//ab[@xml:id = current()]"/></td>
                                 <td><xsl:apply-templates select="$Adler//ab[@xml:id = current()]"/></td> 
                             </tr>
                             </xsl:otherwise>
                         </xsl:choose>
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