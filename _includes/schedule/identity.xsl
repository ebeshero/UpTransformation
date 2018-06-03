<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xml" indent="no" doctype-system="about:legacy-compat"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="html:img">
        <html:span class="image">[image]</html:span>
    </xsl:template>
</xsl:stylesheet>
