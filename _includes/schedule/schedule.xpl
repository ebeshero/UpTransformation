<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ex="extensions"
    xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:html="http://www.w3.org/1999/xhtml" version="3.0">
    <!-- ================================================================ -->
    <!-- Turn Schematron validation off or on                             -->
    <!-- When all times are correct, use:                                 -->
    <!--   valid="?true()" (XML Calabash)                                 -->
    <!--   -static:valid="true" (MorganaXProc-IIIse)                      -->
    <!-- Keep off with unbalanced times                                   -->
    <!-- ================================================================ -->
    <p:option name="valid" as="xs:boolean" static="true" select="false()"/>
    <!-- ================================================================ -->
    <!-- Read schedule.xml                                                -->
    <!-- No primary output                                                -->
    <!-- ================================================================ -->
    <p:input port="source" sequence="false" content-types="xml" href="schedule.xml"/>
    <p:output port="result" sequence="true">
        <p:empty/>
    </p:output>
    <!-- ================================================================ -->
    <!-- Ensure validity with Relax NG                                    -->
    <!-- ================================================================ -->
    <p:validate-with-relax-ng message="Validate with Relax NG">
        <p:with-input port="schema">
            <p:document href="schedule.rnc" content-type="text/plain"/>
        </p:with-input>
    </p:validate-with-relax-ng>
    <!-- ================================================================ -->
    <!-- Ensure validity with Schematron                                  -->
    <!-- Enable by setting static parameter $valid to true()              -->
    <!--   (off by default)                                               -->
    <!-- ================================================================ -->
    <p:validate-with-schematron use-when="$valid" message="Validate with Schematron">
        <p:with-input port="schema">
            <p:document href="schedule.sch"/>
        </p:with-input>
    </p:validate-with-schematron>
    <!-- ================================================================ -->
    <!-- Create schedule for GitHub Pages                                 -->
    <!--   Transform and save as schedule-full.html                       -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="schedule-full.xsl"/>
    </p:xslt>
    <p:identity name="create-html-full" message="Create and save full schedule"/>
    <p:store href="schedule-full.html" serialization="map {
        'method' : 'xml',
        'indent' : false(),
        'encoding' : 'utf-8',
        'omit-xml-declaration' : true()
        }"/>
    <!-- ================================================================ -->
    <!-- Create local schedule                                            -->
    <!--   Read wrapper.xml                                               -->
    <!--   Include schedule-full.html                                     -->
    <!--   Transform to schedule-local.html and save                      -->
    <!-- ================================================================ -->
    <p:load href="wrapper.xml"/>
    <p:insert match="/descendant::html:body" position="last-child">
        <p:with-input port="insertion" pipe="result@create-html-full"/>
    </p:insert>
    <p:xslt>
        <p:with-input port="stylesheet" href="identity.xsl"/>
    </p:xslt>
    <p:identity name="create-html-local" message="Create and save local schedule"/>
    <p:store href="schedule-local.html" serialization="map {
        'method' : 'xhtml',
        'html-version': 5,
        'omit-xml-declaration': false(),
        'include-content-type' : false(),
        'indent' : true()
        }"/>
</p:declare-step>
