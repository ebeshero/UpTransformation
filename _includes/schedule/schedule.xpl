<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" exclude-inline-prefixes="#all"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ex="extensions"
    xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:html="http://www.w3.org/1999/xhtml" version="3.0">
    <!-- ================================================================ -->
    <!-- Read schedule.xml                                                -->
    <!-- No primary output                                                -->
    <!-- ================================================================ -->
    <p:input port="source" sequence="false" content-types="xml" href="schedule.xml"/>
    <p:output port="result" sequence="true">
        <p:empty/>
    </p:output>
    <!-- ================================================================ -->
    <!-- Create schedule for GitHub Pages                                 -->
    <!--   Transform and save as schedule-full.html                       -->
    <!-- ================================================================ -->
    <p:xslt>
        <p:with-input port="stylesheet" href="schedule-full.xsl"/>
    </p:xslt>
    <p:identity name="create-html-full"/>
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
    <p:store href="schedule-local.html" serialization="map {
        'method' : 'xhtml',
        'html-version': 5,
        'omit-xml-declaration': false(),
        'include-content-type' : false(),
        'indent' : true()
        }"/>
</p:declare-step>
