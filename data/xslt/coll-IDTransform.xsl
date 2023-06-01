<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
   
   <xsl:variable name="dickinsonColl" select="collection('../Dickinson')"/>
    
    <xsl:template match="/">
        <teiCorpus>
            <teiHeader>
                <fileDesc>
                    <titleStmt><title>Fascicle 16</title>
                    <author>Emily Dickinson</author>
                    <editor>Nicole Lottig</editor>
                    <editor>Brooke Stewart</editor>
                    <editor>Brooke Lawrence</editor>
                    <editor>Alex Mielnicki</editor>
                    </titleStmt>   
                    <publicationStmt><p>Pitt-Greensburg Digital Humanities project on Newtfire.org</p></publicationStmt>
                
                <sourceDesc><p>Adapted from original project by Michele Ierardi at <ref target="http://www.cs.virginia.edu/~ajf2j/emily/"/></p>
        
                </sourceDesc>
                </fileDesc>
            </teiHeader>
            <xsl:copy-of select="$dickinsonColl/TEI">
               
            </xsl:copy-of>
            
        </teiCorpus>  
    </xsl:template>

</xsl:stylesheet>