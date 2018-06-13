<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns:djb="http://www.obdurodon.org" xmlns:exist="http://exist.sourceforge.net/NS/exist"
    version="3.0">
    <!-- 
        djb:exist-collection($input as xs:string) as document-node()*
        
        $input points to a collection in eXist-db, with no trailing slash, e.g.,
            http://newtfire.org:8338/exist/rest/db/dickinson/f6
        does not recurse
        meant to be imported
        
        see exist-collection-text.xsl in this same directory
    -->
    <xsl:function name="djb:exist-collection" as="document-node()*">
        <xsl:param name="input" as="xs:string" required="yes"/>
        <xsl:variable name="result" as="document-node(element(exist:result))" select="doc($input)"/>
        <xsl:variable name="filenames" select="$result/descendant::exist:resource/@name/string()"/>
        <xsl:variable name="documents" as="document-node()*">
            <xsl:for-each select="$filenames[position() gt 1]">
                <xsl:sequence select="doc(concat($input, '/', .))"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="$documents"/>
    </xsl:function>
</xsl:stylesheet>
