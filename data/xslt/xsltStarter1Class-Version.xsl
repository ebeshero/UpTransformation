<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>

    <!--ebb: We will write templates rules here. -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:apply-templates select="descendant::meta/title"/>
                </title>
            </head>
            <body>
                <h1>
                    <xsl:apply-templates select="descendant::meta/title"/>
                </h1>
              
                   
                   <xsl:apply-templates select="descendant::meta/author"/>
                        
                    
                
              <!--ebb: Some silliness over the break to illustrate testing for conditional cases.  <xsl:choose>
                    <xsl:when test="descendant::meta">
                        <xsl:comment>ARRRRRGH!</xsl:comment>
                    </xsl:when>
                    <xsl:when test="descendant::cauliflower">
                        <xsl:comment>SCREEEAAAM!</xsl:comment>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>Hello!</p>
                    </xsl:otherwise>
                
                </xsl:choose>-->
                <xsl:apply-templates select="descendant::poem"/>
                
                <xsl:apply-templates select="descendant::publication"/>
                <xsl:apply-templates select="descendant::source"/>
                
                
            </body>
        </html>
    </xsl:template>
    
<xsl:template match="meta/author">
        <h2><xsl:text>by </xsl:text><xsl:apply-templates/></h2>
    </xsl:template>
    

    
  <xsl:template match="publication">
      <i><xsl:apply-templates select="title"/></i><xsl:text>, </xsl:text><xsl:apply-templates select="pubPlace"/><xsl:text>, </xsl:text><xsl:value-of select="format-date(date/@when, '[D1o] [MNn], [Y]', 'en', (), ())"/><xsl:text>. </xsl:text>
      <!--ebb: For the picture string on format-date() see https://www.w3.org/TR/xpath-functions-31/#date-time-examples -->
        
    </xsl:template>
    
    <xsl:template match="source">
        <p><xsl:value-of select="concat(normalize-space(.), ': ')"/> <a href="{ref/@target}">
            <xsl:value-of select="substring-after(ref/@target, 'http://')"/></a></p>
    </xsl:template>
   
    <xsl:template match="line">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
</xsl:stylesheet>
