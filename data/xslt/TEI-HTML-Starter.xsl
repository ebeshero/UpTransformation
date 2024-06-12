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
    

</xsl:stylesheet>