<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    
    <xsl:template match="/">
        
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>
                    <xsl:apply-templates
                        select="descendant::skos:ConceptScheme/skos:prefLabel[@xml:lang='en']"/>
                </title>
            </head>
            <body>
                
                <h1><xsl:apply-templates
                    select="descendant::skos:ConceptScheme/skos:prefLabel[@xml:lang='en']"/></h1>
                
                <xsl:apply-templates
        select="descendant::skos:Concept[descendant::skos:prefLabel[@xml:lang='en']]">
                    <xsl:sort select="descendant::skos:prefLabel[@xml:lang='en'][1]"/>
                </xsl:apply-templates>
                                
            </body>
        </html>
    </xsl:template>
    <xsl:template match="skos:Concept">
        
        <h3><xsl:value-of select="skos:prefLabel[@xml:lang='en']/replace(., ' -- ', '--')"/>
        </h3>
        <h4 style="margin-left: 10px">French Headings</h4>
        <ul><xsl:apply-templates select="skos:related/skos:Concept" mode="fr"/></ul>
        <h4 style="margin-left: 10px">Non-authorized Headings</h4>
        <ul><xsl:apply-templates select="skos:altLabel" mode="sublist"/></ul>
        <h4 style="margin-left: 10px">Scope Notes</h4>
        <xsl:apply-templates select="skos:scopeNote[@xml:lang='en']"/>
    </xsl:template>
    
    <xsl:template match="skos:related/skos:Concept" mode="fr">      
        <li><xsl:value-of select="skos:prefLabel[@xml:lang='fr']/replace(., ' -- ', '--')"/></li>
    </xsl:template>
    
    <xsl:template match="skos:altLabel" mode="sublist">
        <li><xsl:value-of select="./replace(., ' -- ', '--')"/></li>
    </xsl:template>
    
    <xsl:template match="skos:scopeNote[@xml:lang='en']">
        <p style="margin-left: 10px"><xsl:value-of select="."/></p>
    </xsl:template>
</xsl:stylesheet>
