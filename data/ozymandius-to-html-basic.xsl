<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xs math" version="3.0">
  <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
    indent="yes"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="//meta/title"/>
        </title>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="title">
    <h1>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>
  <xsl:template match="author">
    <h2>
      <xsl:apply-templates/>
    </h2>
  </xsl:template>
  <xsl:template match="publication">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="source">
    <p>
      <a href="{ref/@target}">
        <xsl:apply-templates/>
      </a>
    </p>
  </xsl:template>
  <xsl:template match="title[@type eq 'journal']">
    <cite>
      <xsl:apply-templates/>
    </cite>
  </xsl:template>
  <xsl:template match="pubPlace">
    <xsl:text> (</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>)</xsl:text>
  </xsl:template>
  <xsl:template match="poem">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="line">
    <xsl:apply-templates/>
    <xsl:if test="following-sibling::line">
      <br/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
