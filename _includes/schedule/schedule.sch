<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:dhsi="http://www.obdurodon.org/dhsi"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.obdurodon.org/dhsi" prefix="dhsi"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
    <!-- ================================================================ -->
    <!-- Functions                                                        -->
    <!-- ================================================================ -->
    <!-- dhsi:format-duration                                             -->
    <!--   @param duration as xs:string                                   -->
    <!--   Returns: xs:string                                             -->
    <!-- Note: Reports all results as minutes, even if duration is longer -->
    <!--   than an hour.                                                  -->
    <!-- ================================================================ -->
    <xsl:function name="dhsi:format-duration" as="xs:string">
        <xsl:param name="duration" as="xs:dayTimeDuration"/>
        <xsl:sequence
            select="($duration div xs:dayTimeDuration('PT1M')) ! xs:integer(.) ! format-integer(., '0')"
        />
    </xsl:function>
    <!-- ================================================================ -->
    <!-- Scheumatron patterns                                             -->
    <!-- ================================================================ -->
    <!-- TODO: Repeated rule for break duration should be consolidated-->
    <sch:pattern>
        <sch:rule context="slot[1]/@time">
            <sch:p>First (morning) slot should start at 11:00 a.m. on Monday and 9:00 on other
                days</sch:p>
            <sch:assert test="
                    if (ancestor::day/@d eq 'Monday, May 26') then
                        . eq '11:00:00'
                    else
                        . eq '09:00:00'">Monday starts at 11:00 a.m., other days at 9:00</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2]/@time">
            <sch:p>Second (afternoon) slot should start at 1:30, except that there is no second slot
                on Friday</sch:p>
            <sch:assert test="
                    if (ancestor::day/@d ne 'Friday, May 30') then
                        . eq '13:30:00'
                    else
                        0">Afternoon sessions Monday through Thursday start at 1:30 p.m.</sch:assert>
            <sch:assert test="ancestor::day/@d ne 'Friday, May 30'">There is no afternoon session on Friday</sch:assert>
        </sch:rule>
        <sch:rule context="slot[1]">
            <sch:p>Duration of first (morning) slot is 1:00 hour Monday and 3:00 on other
                days</sch:p>
            <sch:let name="duration" value="sum(act/@time/xs:dayTimeDuration(.))"/>
            <sch:assert test="
                    if (../@d eq 'Monday, May 26') then
                        $duration eq xs:dayTimeDuration('PT1H00M')
                    else
                        $duration eq xs:dayTimeDuration('PT3H')">Total duration of <sch:value-of select="$duration => dhsi:format-duration()"/> minutes is incorrect; Monday should be 60 minutes and other days should be 180 minutes</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2]">
            <sch:p>Duration of second (afternoon) slot is 2:30.</sch:p>
            <sch:let name="duration" value="sum(act/@time/xs:dayTimeDuration(.))"/>
            <sch:assert test="$duration eq xs:dayTimeDuration('PT2H30M')">Total duration of <sch:value-of select="$duration => dhsi:format-duration()"/> minutes is incorrect; duration should be 150 minutes</sch:assert>
        </sch:rule>
        <sch:rule context="title">
            <sch:p>title element must have non-whitespace content</sch:p>
            <sch:assert test="string-length(normalize-space(.)) gt 0">&lt;title&gt; element must have content</sch:assert>
        </sch:rule>
        <sch:rule context="slot[1]/act[desc eq 'Break']">
            <sch:let name="duration_before_break"
                value="sum(preceding-sibling::act/@time ! xs:dayTimeDuration(.))"/>
            <sch:assert test="$duration_before_break eq xs:dayTimeDuration('PT1H15M')">Morning break falls after <sch:value-of select="$duration_before_break => dhsi:format-duration()"/> minutes; must fall after 75 minutes</sch:assert>
            <sch:assert test="@time eq 'PT15M'">Morning break duration of <sch:value-of select="@time"/> is incorrect; break duration must be PT15M</sch:assert>
        </sch:rule>
        <sch:rule context="slot[2]/act[desc eq 'Break']">
            <sch:let name="duration_before_break"
                value="sum(preceding-sibling::act/@time ! xs:dayTimeDuration(.))"/>
            <sch:assert test="$duration_before_break eq xs:dayTimeDuration('PT1H30M')">Afternoon break falls after <sch:value-of select="$duration_before_break => dhsi:format-duration()"/> minutes; must fall after 90 minutes</sch:assert>
            <sch:assert test="@time eq 'PT15M'">Afternoon break duration of <sch:value-of select="@time"/> is incorrect; break duration must be PT15M</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
