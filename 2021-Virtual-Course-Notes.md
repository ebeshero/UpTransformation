# Process XML and TEI into What?
## A workshop on XPath and its applications in XQuery and XSLT!
## Virtual DHSI 2021 Course 12
### taught by Elisa Beshero-Bondar, assisted by Mia Borgia 
### When: Monday June 7 - Friday June 11, 2021
#### Three hours each day. Timezones:
* 12 - 3pm Pacific Time
* 3 - 6pm Eastern Time
* 7-10pm UTC
* 9pm - 12am Central European Time 
* 10pm - 1am Israel Daylight Time

### Workshop resources

[Workshop Lessons + Exercises](https://ebeshero.github.io/UpTransformation/schedule.html)

### Zoom Recording links 

* [Monday June 7](https://psu.mediaspace.kaltura.com/media/DHSI+Course+12A+Processing+XML+and+TEI+into+WhatF/1_cu4w290z) 
* [Tuesday, June 8](https://psu.mediaspace.kaltura.com/media/DHSI+Course+12A+Processing+XML+and+TEI+into+WhatF/1_zqv74hg9)
* [Wednesday, June 9](https://psu.mediaspace.kaltura.com/media/DHSI+Course+12A+Processing+XML+and+TEI+into+WhatF/1_yzyi7rkl)
* [Thursday, June 10](https://psu.mediaspace.kaltura.com/media/DHSI+Course+12A+Processing+XML+and+TEI+into+WhatF/1_f6bgc6ro)
* [Friday, June 11](https://psu.mediaspace.kaltura.com/media/DHSI+Course+12A+Processing+XML+and+TEI+into+WhatF/1_x15aqkw2)


## Monday June 7, 2021
### Intros and housekeeping
How we'll conduct our class:
* Are we okay with cams on?
* Introducing us instructors! 
     * I'm Elisa! I'm going to attempt to teach a streamlined Zoom version of our DHSI course!
     * Here's Mia! She'll be monitoring chats, Q&A, keeping us from getting lost, and taking care of (almost) everything that breaks! :-D
* Use the chat--Introduce yourself in the Zoom chat! 
* Go around the gallery, say your name and what time zone you're in!  
* How to navigate our Google Doc / what we can do with it. 
* REMINDING Mia/Elisa to hit the RECORD button! 
* Posting Zoom recordings: here in the Google Doc

### Syllabus Monday: Introduction to XPath in eXist-db 
A. Getting started with XPath and eXide
B. Simple XPath expressions 
C. XPath in &lt;oXygen/&gt;
D. XPath path expressions
E. XPath path steps

### Exploring document structures and data with XPath
A. XPath functions for strings 

_______________________________________________________


## Tuesday June 8, 2021

### Starting point: 

Launch  editor, hit Ctrl+u (Windows) or Cmd+u (MacOS), copy and paste the string http://newtfire.org:8338/exist/apps/shakespeare/data/ham.xml , and hit OK. (Backup copy at https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/ham.xml .) This is a copy of Hamlet with TEI markup

### Syllabus Monday continued: Exploring document structures and data with XPath

B. XPath functions for numbers 

C. XPath functions for sequences 

D. Looking Stuff Up: XPath function signatures and cardinality 

F.  XPath predicates 

G. Comparison 

H. Odds and ends 

I. Read and evaluate XML projects with XPath 
___________________________________________________________

## Wednesday June 9, 2021

### From Syllabus Tuesday: XPath and XQuery in eXist-db

A. Housekeeping: documents, collections, and namespaces 

  * Some alternative ways to work with and around namespaces (besides those shown in our course materials):
     1. doc('/db/mitford/literary/Charles1.xml')//*[local-name()="stage"]
     2.  declare default element namespace "http://www.tei-c.org/ns/1.0"; 

B. The seven types of nodes 

C. Neglected XPath axes 

D. Scavenger hunt 1 [Skip for now; Do this on your own later!]

F. Regex in XPath 

   * Handy/fun regex resources;

      1. Regex solver:  https://regex101.com/
      2. Regex crosswords! https://regexcrossword.com/ 

G. Introducing variables 

H. Introducing FLWOR 

### XQuery flow control 

A. Writing XQuery in stages 

B. Review XPath for loops; sequence and range variables (in ) [Skip for now; Do this on your own later!] 

C. FLWOR statements in XQuery: how for works: Part 1 

E. FLWOR statements in XQuery: how for works: Part 2 

F. Putting it all together: writing FLWORs to make new files 


#### On the newtfire.org eXist-dB: text output in the return window:

```
xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
(:  :declare default element namespace "http://www.tei-c.org/ns/1.0";
 : That is how we declare the namespace WITHOUT having to use a prefix later. :)
declare variable $Chas as document-node() := doc('https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/Charles1.xml');
declare variable $ChasPlay as element() := $Chas/*;
declare variable $ChasActs as element(tei:div)+ := doc('/db/mitford/literary/Charles1.xml')//tei:body/tei:div;
declare variable $MitfordSI as document-node() := doc('https://digitalmitford.org/si.xml');

let $places := $MitfordSI//tei:placeName
let $Chasplaces := $Chas//tei:placeName
let $ChasPlaceRefs := $Chasplaces/@ref ! normalize-space()
let $ChasDPRs := $ChasPlaceRefs => distinct-values()
for $c at $pos in $ChasDPRs
	let $cMatch := substring-after($c, '#')
	let $SImatch := $MitfordSI//*[@xml:id = $cMatch]
	let $geo := ($SImatch//tei:geo ! string())[1]
   return ($pos || ': ' || $cMatch || ': ' || $geo)
 (: same as  return concat($pos, '. ', $cMatch, ': ', $geo)  :)
```


___________________________________________________________

#### On the newtfire.org eXist-dB: HTML output in the return window:

```xml
xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
(:  :declare default element namespace "http://www.tei-c.org/ns/1.0";
 : That is how we declare the namespace WITHOUT having to use a prefix later. :)
declare variable $Chas as document-node() := doc('https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/Charles1.xml');
declare variable $ChasPlay as element() := $Chas/*;
declare variable $ChasActs as element(tei:div)+ := doc('/db/mitford/literary/Charles1.xml')//tei:body/tei:div;
declare variable $MitfordSI as document-node() := doc('https://digitalmitford.org/si.xml');

<html>
	<head><title>Mitford Charles I Place Geo Table </title></head>
    
	<body>
   	 
    	<h1>Places in Charles I</h1>
    	<table>
        	<tr><th>Number</th> <th>Place Reference</th>  <th>Geo Coordinates</th>  </tr>

{
let $places := $MitfordSI//tei:placeName
let $Chasplaces := $Chas//tei:placeName
let $ChasPlaceRefs := $Chasplaces/@ref ! normalize-space()
let $ChasDPRs := $ChasPlaceRefs => distinct-values()
for $c at $pos in $ChasDPRs
	let $cMatch := substring-after($c, '#')
	let $SImatch := $MitfordSI//*[@xml:id = $cMatch]
	let $geo := ($SImatch//tei:geo ! string())[1]
   return
    	(:($pos || ': ' || $cMatch || ': ' || $geo) :)
  (: return concat($pos, '. ', $cMatch, ': ', $geo) :)

<tr>
	<td>{$pos}</td>   <td>{$cMatch}</td>   <td>{$geo}</td>
    
</tr>


}

</table>
</body>
</html>
```


___________________________________________________________
## Thursday June 10

### Finish XQuery flow control 
E. FLWOR statements in XQuery: how for works: Part 2 
[Write XQuery in oXygen this time, and experiment with sorting outputs.]

#### Working with XQuery in the oXygen XML Editor:

This involves some initial configuration. It will be easiest to save the files we are working with locally, for reasons of configuring the input and output of our XQuery process. 
 
1. Let's relocate our files to work in oXygen. First, open the XML files we want to work with, and save them to a directory on our local computer. Go to File >> Open URL
     *  Open the Digital Mitford site index at its external location (as we did yesterday with File > Open URL):  https://digitalmitford.org/si.xml  .
     * Open the Charles I play at its GitHub location: https://raw.githubusercontent.com/ebeshero/UpTransformation/master/data/Charles1.xml 
     *  Create a local directory somewhere convenient on your computer (like your Desktop, or a directory in your Documents folder that you're using for our workshop. (We're calling ours "dhsi-xpath-workshop"). Save the si.xml and Charles1.xml files into that directory.
     * Close those files and re-open them so you're working on your local computer. We'll be saving an XQuery file and your output files to the same directory you created.
2.   Now, let's configure oXygen to work with XQuery. 
      *  Look for four tiny buttons in the top right-hand corner of the interface. The second one from the right, marked XQ, is the XQuery debugger. Click on it to change the interface for XQuery writing. 


      *  Then, go to File > New (or click on the paper icon on the top left), and go to open a New File: Type XQ in the search window to open a new XQuery document. We can begin writing XQuery here. This is known as the "XQuery debugger view" in oXygen.
     * In this "XQuery debugger view," we need to choose a dummy file to transform, and the name of an XQuery file to run. We can also set up a file name and destination for our output.
File extensions in XQuery may be:
      * .xquery
      * .xql
      * .xq

     * Finally, we must choose a parsing engine: choose Saxon-PE XQuery.  
We will adapt the XQuery code we wrote in eXist-dB yesterday to work in this new configuration in oXygen. You'll be ready to go for opening files on your computer and writing XQuery over them to pull data that you can save locally. 

We'll also be ready to move to the XSLT debugger view for the next portion of the workshop! 
* We have saved some XQuery and XSLT code we've been writing on project XML files you've sent us [in our Google Drive file share](http://bit.ly/2021-DHSI-12-Drive) 


#### XQuery Script as written in oXygen, filtered and sorted
```xml
xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare default element namespace "http://www.w3.org/1999/xhtml";

(:  :declare default element namespace "http://www.tei-c.org/ns/1.0";
 : That is how we declare the namespace WITHOUT having to use a prefix later. :)
declare variable $Chas as document-node() := doc('Charles1.xml');
declare variable $ChasPlay as element() := $Chas/*;
declare variable $ChasActs as element(tei:div)+ := doc('/db/mitford/literary/Charles1.xml')//tei:body/tei:div;
declare variable $MitfordSI as document-node() := doc('si.xml');
  
let $places := $MitfordSI//tei:placeName
let $Chasplaces := $Chas//tei:placeName
let $ChasPlaceRefs := $Chasplaces/@ref ! normalize-space()
let $ChasDPRs := $ChasPlaceRefs => distinct-values() => sort()
let $onlyCs := 
      for $r in $ChasDPRs
      let $Cval := $r[starts-with(., '#C')]
      return $Cval
      
for $c at $pos in $onlyCs
    let $cMatch := substring-after($c, '#')
    let $SImatch := $MitfordSI//*[@xml:id = $cMatch]
    let $geo := ($SImatch//tei:geo ! string())[1]
    (: ebb: we commented out the next two lines because we found a better way to sort and filter before the big for loop begins. :)
    (: where $cMatch ! starts-with(., 'C') :)
    (:order by $cMatch :) 
   return
        (:($pos || ': ' || $cMatch || ': ' || $geo) :)
  (: return concat($pos, '. ', $cMatch, ': ', $geo) :)

}

Number	Place Reference	Geo Coordinates
{$pos}	{$cMatch}	{$geo}

```

______________________________

### (Continuing with Syllabus Wednesday): XPath and XSLT

Introduction to XPath in XSLT 
Preparation for writing XSLT in  
XSLT overview in `oXygen` 

UPDATE on B. 4.: 
Let's use this new and better version of the xsl:output line:

```xml
<xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" indent="yes"/>
```

Group walk-through activity in &lt;oXygen/&gt;

#### XSLT: Ozymandias non-namespaced XML  to HTML

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
         exclude-result-prefixes="xs"
         version="3.0">
 <!--OLD xs:output line. We're updating this:
<xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>-->
	<xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" indent="yes"/>

<!--ebb: We will write templates rules here. -->
<xsl:template match="/">
	<html>
    	    <head>
        	      <title><xsl:apply-templates select="descendant::meta/title"/></title>
    	    </head>
    	<body>
        	    <h1><xsl:apply-templates select="descendant::meta/title"/></h1>
        	     <h2><xsl:apply-templates select="descendant::author"/></h2>
        	     <ul><xsl:apply-templates select=".//publication"/></ul>     	 
      	            <xsl:apply-templates select="descendant::poem"/>
    	</body>
	</html>
</xsl:template>
    
<xsl:template match="publication/*">
    	<li><xsl:apply-templates/></li>
</xsl:template>
    
<xsl:template match="poem">
  	<section class="poem">
    	      <xsl:apply-templates/>
  	  </section>
</xsl:template>    
	<xsl:template match="line">
    	         <div id="L-{count(preceding-sibling::line) + 1}">
           	            <span class="ln">
               	           <xsl:value-of select="count(preceding-sibling::line) + 1"/>
              	             <xsl:text>. </xsl:text>
           	                </span>
                        <xsl:apply-templates/>
       	             </div>
	</xsl:template>
</xsl:stylesheet>
```


___________________________________________________________
## Friday June 11, 2021

### Last Day: More XSLT 
We are working with your project code, today! 

Mia and I have been experimenting with transformations of code you've submitted to us for the workshop. We'd like to show you some transformation code we've made and hand these to you as files for your own experiments.

#### Files we're working with
* GitHub for our class materials: https://github.com/ebeshero/UpTransformation/tree/master/data 


1. Silvia: push processing and declaring things in XSLT
2.  Identity transforms (XML to XML), working with collections, creating collections of documents. (from the schedule)
3. Sinai:  aligned reading view of three languages. xsl:for-each and xsl:choose
4. Katia: Pull processing, and which is better for the task? XQuery vs. XSLT to make the same output (a data table of dialogue types). 

### (Related course materials from our syllabus site): 
### Syllabus Wednesday: XPath and XSLT:
E. From identity transformation to revision 
F. Comparing XSLT and XQuery 
G. Preparing XSLT to output HTML from TEI XML 

## Questions and Answers

### Monday June 7 Class Questions

* Q: Presumably that [```current-dateTime()```] wouldn't work in oXygen? 
  A: It works differently in oXygen: it'll give the current-dateTime() according to your local computer system!

* Q:  - current-dateTime() error in exist XQuery in certain browsers? Note: Brave browser works, Mozilla fails - just a curiosity for now.
  A: Thanks! We'll try testing and maybe take this to the XQuery/eXist Slack.

*  Q: sometimes changing path expressions in exide changes the output, sometimes we need to press eval. What is the rule?
   A: There is a live output toggle at the bottom which would give you an immediate response to a query. But if you have it set to one of the other outputs 
like adaptive or text, etc., you'll press Eval to view the output. 

* Q: best practice for debugging when there is no error?
  A: [Rubber duck debugging](https://en.wikipedia.org/wiki/Rubber_duck_debugging) and zen / Stack Overflow. Also, share your code and ask coding friends (like us) for help!

* Q: Another way to open the XPath/XQuery Builder in Oxygen?
  A: by pressing the Switch to XPath Builder View button that is located on the XPath toolbar (gear icon)

* Q: When I did Question e, I did //div/stage/.. rather than //stage/parent::div and it seemed to return similar results. Is this an equivalent or no?
  A: yes! Using the double periods (```..```)  is the same as using the parent axes (```parent::```) in many cases.

* Q: And // can be used to find parents, not just descendants?
  A: Yes, as long as you tell XPath to look up the tree to the parent:: axes of the node you’re on in your sequence of // (using parent:: or ..*)

* Q: Could I use \n as a separator in XPath function ```concat()``` ? Are regex allowed?
  A: Unfortunately, no! Putting \n will result in the literal characters \n to be used as separators, not newlines.


### Tuesday June 8 Class Questions

* Q: Are there some helpful resources to quickly look up XPath functions and what they do, besides what we have here?
  A: Here's a useful resource I want to make sure we link to!: http://www.xqueryfunctions.com/ 

* Q: Can we start an XPath with the dot - .//speaker, as in: (string-length(.//speaker) )
  A: This won't return us what we want (gives us "0"), because the dot needs to refer to something to give it context.

* Q: Why does `count()` accept only one argument?
  A: We need to understand that an argument is distinct from the cardinality of the function. A function like `count()` or `sum()` or `max()` or `min()`  only takes one argument, but that argument is expected to be a set of multiple things. That's why we need to wrap a second set of parentheses around the sequence of text strings here: count(("Curly", "Larry", "Moe")). 
In a nutshell, e pluribus unum! (from the many, one!) 

* Q: Would a ‘condition’ also be a good description for predicates?
  A: You can use a condition to filter your results INSIDE a predicate!

* Q: Would “==” work as absolute equality?
  A: No: The "==" we may know from JavaScript and Python doesn't have a role in XPath. 
Think about why: In Python and JS, the single `=` is used to assign a value to variables. So Python and JS need the double `==` to use for testing for an equal comparison.

 In XQuery we'll use this `:=` to assign values to variables, which means that in XPath (and XQuery and XSLT) the `=` is just fine for indicating equality. 

* Q: So should we think of simple map as implicit ‘for’?  Is there no difference?
  A: yeah! Both of them take our context nodes one by one and put them into a function

* Q: How can we avoid picking up results in ? (in response to Part I, question 5: Building on your answer to the last question, who are the speakers of those speeches?)
  A: Be careful to step down just into the child:: axis, not the descendant::axis. `//sp//l` (includes the children of `//sp/lg`). `//sp/l` returns only the child `` elements inside ``


### Wednesday June 9 Class Questions

* Q: Have you seen? XQuery for Humanists by Clifford Anderson and Joseph C. Wicentowski? http://www.worldcat.org/oclc/1179052067 (Shout out to http://www.worldcat.org, libraries around the world contribute to this listing of published works. Directs you to local libraries, etc.)
  A: Yes! This is a wonderful book for a super clear introduction to XQuery in eXist-dB. (Note to self: We should make sure we link to it from our course materials! I think this was just going to press when we started teaching this class at DHSI.) 

* Q: Does exide has a ‘memory’ like oxygen Xpath windows?
  A: Yes! There are two ways to think of this memory: 
    * One way is that your web browser will locally store or "cache" the code you write for a while, until you empty your browser cache. So if you re-open the link to my exist-db, you'll probably still see some of your queries that you wrote in this workshop. 
    * You can also save your XQuery files in the database itself if you have write permission to the database. See details on installing your own eXist-dB in our coursepack materials.) 

* Q2: then I shouldn’t replace but comment out what I want to ‘remember’
  A2: yes. Or you could create a new XQuery file if it's too much XPath to comment out

* Q: Does it break it up if there is a tag in between whatever is the text? (in the results window)
  A: We think this question might be about the use of curly braces to split up markup documents (like an HTML you're constructing) from the XQuery code that will populate a list or table. And yes, you need curly braces sort of to "code-switch" between HTML and XQuery, back and forth. Take a look at this basic example to see how the curly braces work to separate the code:

```xml
declare variable $collection as document-node()+ := collection('filepath/to/collection/');

   
        ....
        ....
         
            {
               let $things := $collection//some/xpath/that/leads/to/your/data
               for $t at $pos in $things
               return
                  
           }
      
Number	Thing
{$pos}	{$t}
   
```
                  

* Q: What is the difference between declaring a namespace or simply using the prefix?
  A: Sometimes it is worth keeping the prefix for certain types of projects, for the purpose of mindfulness or even philosophical reasons - but for simplicity, declaring a namespace is usually preferred if you aren’t working with multiple namespaces and syntax rules TLDR: depends on the complexity of your project!

* Q: working with the 2nd one (declare default namespace) means you don’t need to do the tei::div thing each time, right?
or invoke tei in each expression?
  A: yes! (We like using this when we can, but if we have to read TEI and output HTML, it's probably best to resign ourselves to making the output HTML be the default namespace, and just remember to use that pesky `tei:` prefix.)

* Q: [the $c for loop variables] is not like a universal variable, it was declared as part of the for expression, I mean?
  A: Using a single letter that starts the list-variable (for $c in $ChasDPRs) is just a convention. You can call it whatever you want. (answer creds to William Campbell)

* Q: Can you say a little more about using a site-index? Why you would want to create one for a collection of documents? and how would you decide what to put in it?
  A: (discussion during the recordings!)

* Q: Is TEI-publisher an alternative to these methods? Or can you combine the two?
  A: We think you can combine the two, but we're not sure: learn more with the TEI Publisher group!
   TEI Publisher is especially good for connecting the semantics of your TEI code with your customized CSS styling: so it's designed to support reading views of coded documents.
   (discussion during the recordings.) 


### Thursday June 10 Class Questions

* Q: So, Oxygen has the latest EE Saxon?
  A: if you keep your oXygen XML Editor up to date, it comes bundled with the latest stable Saxon, yes. 

* Q: How do we choose a destination for our output? ‘ [XQ Oxygen]
  A: click the little File folder icon next to the blank output name bar in the top left, then choose a wise and mindful place to store your XQuery output and name it accordingly!

* Q: Why does declare namespace tei include an = before the “http: and declare default element namespace does not?
  A: The purpose of the equals sign is to associate your tei prefixes to the namespace, while the namespace which does not have an = (the default namespace) the document will assume that all of your elements without a prefix are under that namespace

* Q: Is the html namespace line required when NOT using TEI document input?
  A: In order for it to be legitimately valid in oXygen, yes

* Q: So "where" is not spatial, but rather something more like "if"?
  A: yes!

* Q: Is the presence of that [non-template matched element] text the result of this being push processing?
  A: Yup!



### Friday June 11 Class Questions

* Observation (thanks, Patrick Durusau!): Declarative vs. Imperative Programming - One difference is that once a variable is declared, no matter who or how many times it is called, it always returns the same value. With imperative programming, a variable may be changed by another operation, with no notice to you (well, your program). Eliminates what are called “race conditions” where we are all racing to change the variable in question and who gets there first makes a huge difference.

* Q: Is there an XSLT “best practices” reference that you would recommend?
  A: Michael Kay's book (XSLT 2.0 and XPath 2.0) and see also references in the course pack. . . and much as yet to be written. :-)
