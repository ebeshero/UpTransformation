<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="xhtml" indent="yes" html-version="5" include-content-type="no"
        omit-xml-declaration="yes"/>
    <!--2018-06-12 ebb: Starter file for a a TEI to HTML transformation.
    
    -->

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:text>Emily Dickinson’s </xsl:text>
                    <xsl:apply-templates select="teiCorpus/teiHeader//titleStmt/title"/>
                </title>
            </head>
            <body>
                <h1> <xsl:text>Emily Dickinson’s </xsl:text>
                    <xsl:apply-templates select="teiCorpus/teiHeader//titleStmt/title"/></h1>
                
                <!-- ==================================================== -->
                <!-- 2023-06-07 ebb with djb:                             -->
                <!--  We are writing the Table of Contents here.          -->
                <!-- ==================================================== -->
             
             <h2>Table of Contents</h2>
             <ul>   
                <xsl:apply-templates select="descendant::TEI" mode="toc"/>
             </ul>
                
                
                <xsl:apply-templates select="descendant::TEI" />                
            </body>
        </html>
    </xsl:template>

<xsl:template match="TEI" mode="toc">
    <li><a href="#ed-{teiHeader//idno}"><xsl:apply-templates select="descendant::body//title" mode="toc"/></a></li>
 </xsl:template>  
    
    <xsl:template match="title" mode="toc">
       <xsl:apply-templates/>
        
    </xsl:template>
    
    
  <xsl:template match="TEI">
    <div id="ed-{teiHeader//idno}">
        <xsl:apply-templates select="descendant::body"/>

    </div>
 
</xsl:template>
    
    <xsl:template match="body//title">
        <h2><xsl:apply-templates/></h2>
        
    </xsl:template>
    
    <xsl:template match="lg">
        <p class="{name()}">
            <xsl:apply-templates/> 
        </p>
    </xsl:template>
    
    <xsl:template match="l">
        <span class="lineNum"><xsl:value-of select="count(preceding::l[preceding::idno[1] eq current()/preceding::idno[1]]) + 1"/></span><xsl:text>   </xsl:text><span class="{name()}"><xsl:apply-templates/></span><br/>
    </xsl:template>
    
    <xsl:template match="app">
       <span class="{name()}"><xsl:value-of select="string-join(rdg, ' | ')"/></span>
        
    </xsl:template>

</xsl:stylesheet>
