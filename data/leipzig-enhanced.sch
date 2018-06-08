<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2">
    <ns prefix="djb" uri="http://www.obdurodon.org"/>
    <xsl:function name="djb:hyphenation" as="xs:boolean+">
        <xsl:param name="orthWords" as="xs:string+"/>
        <xsl:param name="transWords" as="xs:string+"/>
        <xsl:param name="ilgWords" as="xs:string+"/>
        <xsl:for-each select="1 to count($orthWords)">
            <xsl:variable name="orthHyphens" as="xs:integer"
                select="djb:countHyphens($orthWords[current()])"/>
            <xsl:variable name="transHyphens" as="xs:integer"
                select="djb:countHyphens($transWords[current()])"/>
            <xsl:variable name="ilgHyphens" as="xs:integer"
                select="djb:countHyphens($ilgWords[current()])"/>
            <xsl:sequence
                select="count(distinct-values(($orthHyphens, $transHyphens, $orthHyphens))) eq 1"/>
        </xsl:for-each>
    </xsl:function>
    <xsl:function name="djb:countHyphens" as="xs:integer">
        <xsl:param name="word"/>
        <xsl:variable name="length" as="xs:integer" select="string-length($word)"/>
        <xsl:variable name="dehyphenatedLength" as="xs:integer"
            select="string-length(translate($word,'-',''))"/>
        <xsl:sequence select="$length - $dehyphenatedLength"/>
    </xsl:function>
    <pattern>
        <rule context="sentence">
            <let name="orthSpaces"
                value="string-length(orth) - string-length(translate(orth,' ',''))"/>
            <let name="translitSpaces"
                value="string-length(translit) - string-length(translate(translit,' ',''))"/>
            <let name="ilgSpaces" value="string-length(ilg) - string-length(translate(ilg,' ',''))"/>
            <let name="orthWords" value="tokenize(orth,'\s+')"/>
            <let name="transWords" value="tokenize(translit,'\s+')"/>
            <let name="ilgWords" value="tokenize(ilg,'\s+')"/>
            <let name="results" value="djb:hyphenation($orthWords,$transWords,$ilgWords)"/>
            <report
                test="($orthSpaces, $translitSpaces, $ilgSpaces) != 
                avg(($orthSpaces, $translitSpaces, $ilgSpaces))"
                >The spaces don’t match: orth (<value-of select="$orthSpaces"/>) ~ translit
                (<value-of select="$translitSpaces"/>) ~ ilg (<value-of select="$ilgSpaces"
                />)</report>
            <report test="$results != true()">Word # <value-of
                select="index-of($results,false())[1]"/> doesn't match: "<value-of
                    select="$orthWords[index-of($results,false())[1]]"/>" (orthographic, <value-of
                        select="string-length($orthWords[index-of($results,false())[1]]) - 
                        string-length(translate($orthWords[index-of($results,false())[1]],'-',''))"
                    />) ~ "<value-of select="$transWords[index-of($results,false())[1]]"/>"
                (transliterated, <value-of
                    select="string-length($transWords[index-of($results,false())[1]]) - 
                    string-length(translate($transWords[index-of($results,false())[1]],'-',''))"
                />) ~ "<value-of select="$ilgWords[index-of($results,false())[1]]"/>" (interlinear
                gloss, <value-of
                    select="string-length($ilgWords[index-of($results,false())[1]]) - 
                    string-length(translate($ilgWords[index-of($results,false())[1]],'-',''))"
                />)</report>
        </rule>
    </pattern>
</schema>