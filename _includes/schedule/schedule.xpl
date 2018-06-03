<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step name="process" xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    <p:documentation> Reads schedule.xml Transforms to schedule-full.html and saves Reads
        wrapper.xml, includes schedule-full.html Transforms to schedule-local.html and saves TODO:
        suppress final output </p:documentation>
    <p:input port="source" sequence="true">
        <p:empty/>
    </p:input>
    <p:output port="result" sequence="true">
        <p:pipe port="result" step="finish"/>
    </p:output>
    <p:serialization port="result" indent="false" method="xml" encoding="utf-8"
        omit-xml-declaration="true"/>
    <p:xslt>
        <p:input port="source">
            <p:document href="schedule.xml"/>
        </p:input>
        <p:input port="stylesheet">
            <p:document href="schedule-full.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    <p:store href="schedule-full.html"/>
    <p:load href="wrapper.xml"/>
    <p:xinclude/>
    <p:xslt>
        <p:input port="stylesheet">
            <p:document href="identity.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    <p:store name="save" href="schedule-local.html"/>
    <!-- is there a better way to suppress final output? -->
    <p:identity name="finish">
        <p:input port="source">
            <p:empty/>
        </p:input>
    </p:identity>
</p:declare-step>
