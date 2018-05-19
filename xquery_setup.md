# Introducing eXist-db and XQuery

Our course begins by exploring XPath and XQuery inside eXist-db, an open-source XML database with an XQuery engine that incorporates XPath processing. You can read about eXist-db at their [homepage](http://exist-db.org/exist/apps/homepage/index.html) and click on the “Download eXistdb” button to scroll to a link where you can download the most recent stable release.

eXist-db requires Java SE 1.8, so if you did not have it installed before you arrived, please do so now: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>. If you aren’t sure whether you have Java (or the right version of Java) installed, follow the instructions at <https://www.java.com/en/download/help/version_manual.xml> to check.

We will use eXide, the integrated development environment (IDE) bundled with eXist-db. 
After you install and launch eXist-db, access eXide by clicking on the eXide icon in your eXist dashboard. If you are running eXist on your own machine with default settings, you can open your dashboard (locally) in a web browser at the address <http://localhost:8080>, and you can launch eXide directly, bypassing the dashboard, with <http://localhost:8080/exist/apps/eXide/>.

When you install eXist-db on your own machine, you also install all documentation for both the XQuery function library (core XPath and XQuery functions) and eXist-db itself. The default location for the function library documentation on your local machine is <http://localhost:8080/exist/apps/fundocs/> (if you’re consulting local documentation for the first time, you’ll be prompted to generate it first). You can also find a copy on the eXist-db demo server on the internet at <http://demo.exist-db.org/exist/apps/fundocs/>. You can access eXide and use interactive tutorials online on the demo server any time you like; that instance of eXide is located at <http://demo.exist-db.org/exist/apps/eXide/index.html>. eXist-db is often installed on web servers as a “background service” to support XML-based projects online, and in our class we will be accessing Elisa’s web installation at [http://newtfire.org:8338](http://newtfire.org:8338). If you have access to a web server, you may wish to explore the [advanced eXist-db documentation](https://exist-db.org/exist/apps/doc/advanced-installation.xml#headless) to try installing eXist-db there and learn how to use it to support dynamic searches. For now, though, unless you have permissions to save files on the web installations of eXist-db, you can’t upload and save your own documents there. That is why we recommend installing your own local copy of eXist-db on your machine, so you can practice and experiment with saving and querying your own files.

## Quick notes

* eXide outputs messages between the query area and the result area, or along the bottom if you’ve shifted your result area to the right side of your screen. The important information is at the end of the message.
* Use keyboard shortcuts. For example, `Ctrl+Enter` (Windows) or `Cmd+Enter` (MacOS) will save you some time executing the queries. You’ll find a list of keyboard shortcuts inside eXide: click on “Help” → “Keyboard shortcuts”.
* In the result area you can page forward and backwards with the double arrows if your result set is larger than your page size.

## Namespace declaration and function call

When writing XQuery for TEI texts, or any text in a namespace, you must declare the namespace and bind it to a prefix. The syntax for doing that is:

```xquery
declare namespace tei="http://www.tei-c.org/ns/1.0";
```

In order to start writing XQuery to explore documents, we first have to locate those documents in the eXist-db database. eXist-db, and XQuery in general, uses the term _collection_ to refer to what we would call a directory or subdirectory on our local file system. The database is organized hierarchically, with a root collection called `/db`, and we can navigate from there to a file or subcollection with a path, as we would with a regular file system.

To address the specific document or collections you wish to work with from the database, we typically assign it to a variable using either the `doc()` (for  single document) or `collection()` (for multiple documents) function, with the full path as the argument. You can create two different kinds of variables:
1) a global variable, with `declare variable` (declarations must be at the beginning of your document, before any other XQuery code)
1) a variable in a FLOWR expression, usually introduced by `let`, which we discuss below). Here’s the `declare variable` syntax:

```xquery
declare variable $data := doc("/db/neh-2017/hamlet.xml");
```

The variable name is preceded by a dollar sign (`$`), the assignment operator is a colon followed by an equal sign (`:=`), and the statement must end with a semicolon (`;`). Don’t forget the semicolon!

The `let` syntax is similar, except that it must _not_ end in a semicolon:

```xquery
let $data := doc("/db/neh-2017/hamlet.xml")
```

We recommend using the `as` operator to specify the datatype of your variable. Since `$data` refers to a single document, the datatype is `document-node()`, so the declarations would be

```xquery
declare variable $data as document-node() := doc("/db/neh-2017/hamlet.xml");
```

and

```xquery
let $data as document-node() := doc("/db/neh-2017/hamlet.xml")
```

New coders sometimes ignore the `as` operator because 1) it isn’t required and 2) it can provoke annoying error messages. If you omit the `as` operator and make an error, you’ve still made an error, and it’s better to know about the error and correct it than to get the wrong results without being aware that they’re wrong.

In summary, each XQuery that you write will begin with something like the following:

```xquery
xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $data as document-node()+ := collection("/db/neh-2017");
```

* The XQuery declaration at the beginning is optional, but we recommend including it, and eXide will put it there for you.
* The namespace declaration is needed only if your document is in a namespace. In this example, we’ve declared the TEI namespace and bound it to the prefix `tei:`. 
* We assign the variable `$data` to a collection of all documents inside `/db/neh-2017`. Since the variable will represent one or more documents, we’ve set the datatype as `document-node()+`.

If you aren’t sure what namespace your documents are in, or if they have more than one namespace, you can navigate them using a wildcard namespace, which is represented by an asterisk (`*`). The following example finds all elements with a local name of `<p>`, no matter what namespace they are in, and assigns them to the variable `$stuff`:  

```xquery
let $stuff := $data//*:p  
```

This method is okay for quick and dirty initial exploration, but it’s Bad Practice in Real Life. If you don’t know what namespace your elements are in, you should; you can’t work with structured documents without knowing how they’re structured. If there are multiple namespaces, it’s unlikely that you want to treat `<p>` elements in different namespaces the same way, and therefore unlikely that you’d want to assign them all to a single, common variable.

## Writing XPath in eXide

All XPath works in eXist, for the simple reason that every XPath expression is also an XQuery expression. For example, if you type:

```xquery
xquery version "3.1";
1 + 1
```

into a new eXide document and hit “Eval”, eXide will return the value “2”. That’s because the plus sign, with meaning of arithmetic addition, is an XPath operator, and since all XPath expressions are also XQuery expressions, that simple addition is a complete and valid XQuery script. Here is a complete XQuery script that consists of a single XPath path expressions:

```
xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/neh-2017/hamlet.xml')//tei:titleStmt/tei:title
```

This path returns all `<title>` elements in your document that are children of `<titleStmt>` elements, where both `<title>` and `<titleStmt>` are in the TEI namespace. In this case, there is only one such `<title>`. Note that because you asked for a `<title>` element, you get back the entire element, including its start and end tags, any associated attributes, and the TEI namespace binding., including the angle brackets and the namespace attribute. If we want just the text of the title, you can ask for that by appending the XPath `string()` function, which _stringifies_ its argument:

```
xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
doc('/db/neh-2017/hamlet.xml')//tei:titleStmt/tei:title/string()
```

## Using XQuery FLWOR expressions

### Definition

_FLWOR_ (pronounced like “flower”) expressions make up most of the XQuery you’ll write. The acronym stands for the clause type in a FLWOR expression:

* **for** loops over items in a sequence
* **let** declares a variable and assigns it a value
* **where** filters items based on parameters you defines
* **order by** sorts items before returning them
* **return** returns the items

### FLWOR rules

Not every XQuery script has to include a FLWOR (remember our `1 + 1` example, above), but if you have a FLWOR, it observes the following rules:

* A FLWOR must begin with at least one `for` or one `let` statment. It may have as many `for` and `let` statements as you want, but all `for` and `let` statements have to proceed all other types of statements. 
* The `where` statement is optional, but if it occurs, it must immediately follow the `for` and `let` statements.
* The `order by` statment is optional, but if it occurs, it must immediately follow either the `where` statement (if there is one) or the `for` and `let` statements (if there is no `where` statement).
* There must be a single `return` statement and it must come last. 

The smallest possible FLWOR, then, consists of one `for` or one `let`, plus one `return`.

### FLWOR example

As an example, we’ll write a FLWOR expression that does the same thing as our XPath above, separating each part of processing into an individual step.

```
xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $hamlet := doc('/db/neh-2017/hamlet.xml')
let $title := $hamlet//tei:titleStmt/tei:title
return $title
```

Writing expressions this way is useful because it lets you examine the intermediate variables on your way to a solution. That sort of incremental development can help you catch errors early in the process, which makes it easier to correct them. Suppose we want to create a variable to count the number of distinct speakers in the play. To do this in XPath, we could write a single path expression:

```xquery
xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
count(distinct-values(doc('/db/neh-2017/hamlet.xml')//tei:speaker))
```

Everything happens in one line here, but at the expense of making the code hard to write (it’s easy to lose count and wind up with unbalanced parentheses) and difficult to debug. For example, if you get the wrong result, you could have pointed to the wrong document, you could have used the wrong element name to find the speakers, you could have made an error in trying to get the `distinct-values()` of something, you could have made an error in trying to `count()` something, or you could have all of the pieces correct, but in the wrong order. For example, if you put `distinct-values()` outside `count()`, instead of the reverse, you’ll get one number, but it will be a different number, and the wrong one. (Why is that the case?)

With a FLWOR expression, it’s easier to segment, change, and build your results:

```
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $hamlet := doc('/db/neh-2017/hamlet.xml')
let $speakers := $hamlet//tei:speaker
let $distinct := distinct-values($speakers)
let $count := count($distinct)
return $count
```

This example shows you how you can create individual steps by declaring variables. During development, we might write each step separately and return the result to verify that we are asking for what we think we’re asking for. If we wanted to change the code to focus on a single scene, instead of the entire play, or to get us the distinct speakers for each act, or to count the speakers by act, we could do so by adding a few lines and editing the result.


For more examples and explanation of FLWOR expressions, see Michael Kay’s [Learn XQuery in 10 Minutes](http://www.stylusstudio.com/xquery-primer.html) (which we think will take more than 10 minutes, but it’s a great longer introduction and resource for reference. See also Kay’s [Blooming FLWOR—an introduction to the XQuery FLWOR expression](http://www.stylusstudio.com/xquery-flwor.html).

