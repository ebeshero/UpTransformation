<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no" />

<xsl:template match="/">
    <html>
        <head>
            <title>Emily Dickinson’s Fascicle 16</title>
       <style>
          <!-- got some CSS styling? --> 
       </style>     
        </head>
        <body>
       <xsl:apply-templates/>      
        </body>
    </html>

</xsl:template>
    
<xsl:template match="teiCorpus//titleStmt">
    <h1><xsl:apply-templates select="title"/></h1>
    <p class="author">By <xsl:apply-templates select="author"/> </p> 
    <ul><xsl:apply-templates select="editor"/></ul>
</xsl:template> 
    
<xsl:template match="teiCorpus/teiHeader//editor">
     <li><xsl:apply-templates/></li>
</xsl:template>    
    
    
<xsl:template match="TEI">
    <section class="poem" id="poem-{descendant::idno}">
        <h2><xsl:apply-templates select="text//title"/></h2>      
        <xsl:apply-templates select="descendant::lg"/>   
    </section>
    
</xsl:template>   
    
    
    <xsl:template match="lg">
        <div class="lg">       
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    
    <xsl:template match="l">
     <span class="number"><xsl:value-of select="count(preceding::l[ancestor::TEI = current()/ancestor::TEI]) + 1"/></span>   <xsl:apply-templates/>
        <xsl:if test="following-sibling::l"><br/></xsl:if>
    </xsl:template>
    
    <xsl:template match="app">
        <span class="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="rdg">
        <span class="{@wit}">           
            <xsl:apply-templates/> 
        </span> 
    </xsl:template>

</xsl:stylesheet>