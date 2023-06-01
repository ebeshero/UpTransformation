<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    
    <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <title>
                    <xsl:apply-templates select="descendant::teiHeader[1]/title"/>
                </title>
                <style type="text/css">
                    body {
                    padding: 2em;
                    }
                    
                    p,
                    div {
                    padding: .5em;
                    }
                    h1 { 
                    text-align:center;
                    }
                    h2 {
                    padding: .6em;
                    }
                    h4 {
                    text-align:right;
                    }
                    
                    p.date {
                    text-indent:.4em;
                    }
                    span.ref {
                    
                    color: maroon;
                    
                    }
                    span.biblRef {
                    color:darkcyan;
                    }
                    span.subref {
                    color:green;
                    }
                    
                    div.note {
                    margin-top:4em;
                    }
                    span.note {
                    font-weight:bold;
                    color:maroon;
                    }
                    
                    lb {
                    display: block;
                    margin: .5em;
                    }
                
                </style>
            </head>
            <body>
                <h1>
                    <xsl:apply-templates select="descendant::teiHeader[1]//title"/>
                </h1>
                
                <h2><xsl:apply-templates select="descendant::teiHeader[1]//persName[@xml:id = 'SS']"/></h2>
                <h4><xsl:apply-templates select="descendant::teiHeader//sourceDesc/p"/></h4>
                
                <xsl:apply-templates select="descendant::body"/>
                
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="body">
        <p class="date"><xsl:apply-templates select="descendant::dateline/date/@rend/data()"/></p>
        <div>
            <xsl:apply-templates select="descendant::p"/>
        </div>
        
    </xsl:template>
    
    <xsl:template match="hi[@rend = 'underline']">
        
        <u><xsl:apply-templates/></u>
        
    </xsl:template>
    
    <xsl:template match="emph[@rend='italic']">
        
        <i><xsl:apply-templates/></i>
        
    </xsl:template>
    
    <xsl:template match="pb">
        
        <lb n="{@n}"/>
        
    </xsl:template>
    
    <xsl:template match="ref[@type='bibl']">
        
        <span class="biblRef"><xsl:apply-templates/></span>
        
    </xsl:template>
    
    <xsl:template match="ref[@type= 'parallel']">
        
        <span class="ref"><xsl:apply-templates/></span>
        
    </xsl:template>
    
    <xsl:template match="ref[@type='subordinate']">
        
        <span class="subref"><xsl:apply-templates/></span>
        
    </xsl:template>
    
    <xsl:template match="note">
        <lb/>
        <div class="note"><span class="note">Note: </span> <xsl:apply-templates/></div>
        
    </xsl:template>
    
</xsl:stylesheet>