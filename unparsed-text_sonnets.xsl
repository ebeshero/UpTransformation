<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    <!-- 
        Title: unparsed-text_sonnets.xsl
        Author: djb (2017-04-09)
        Repo: https://github.com/xstuff
        Synopsis:
            Illustrates using XSLT to process plain text
            Up-translates plain-text file of Shakespearean sonnets to HTML
        Note:
            No input XML; run from the command line as:
            saxon -xsl:unparsed-text_sonnets.xsl -it:init -o:sonnets.xhtml
        License: GNU Affero General Public License v3.0
    -->
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <!-- Read plain text document into $input -->
    <xsl:variable name="input" as="xs:string"
        select="unparsed-text('http://dh.obdurodon.org/shakespeare-sonnets.txt')"/>
    <!-- 
        split into individual sonnets on blank line;
        last item is empty because document ends in two newline characters
    -->
    <xsl:variable name="sonnets" as="xs:string+" select="tokenize($input, '\n\n', 's')"/>
    <!-- specify initial template with "it" parameter to saxon on command line -->
    <xsl:template name="init">
        <html>
            <head>
                <title>Sonnets</title>
            </head>
            <body>
                <h1>Sonnets</h1>
                <xsl:for-each select="$sonnets">
                    <!-- break each sonnet into lines, the first of which is the number -->
                    <xsl:variable name="lines" as="xs:string*" select="tokenize(., '\n')"/>
                    <!-- the test filters out the last one, which is blank (see above) -->
                    <xsl:if test="count($lines) gt 0">
                        <h2>
                            <!-- the first "line" is the roman numeral -->
                            <xsl:sequence select="$lines[1]"/>
                        </h2>
                        <p>
                            <!-- process all real lines of poetry -->
                            <xsl:for-each select="$lines[position() gt 1]">
                                <xsl:sequence select="."/>
                                <!-- don't add <br/> after last line -->
                                <xsl:if test="position() ne last()">
                                    <br/>
                                </xsl:if>
                            </xsl:for-each>
                        </p>
                    </xsl:if>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
