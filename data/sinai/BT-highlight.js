/* 2021-06-10 ebb: JavaScript to respond on click of highlighted spans in one table cell 
 * to corresponding spans in cells in the same table. */
window.onload = init;

var seg;
var Asher = 'BTAsher20210429'
var Haddad = 'BTHaddad20210425'
var Adler = 'BTAdler20210419'

function init() {
//window.alert("hi!");
  var segSelect = document.querySelectorAll('span[title]');
  for (var i = 0; i < segSelect.length; i++) {
    segSelect[i].addEventListener('click', highlight, false);
    } 
   /* seg = document.getElementById('BTAsher20210429-GN1S1');*/
  }

function highlight() {
    undo();
    /* this.style.backgroundColor = '#ffd270';*/ /* light orange */
     var match = this.id.split("-")[1]
     
     /* ebb: Find the other matching seg elements by matching the end portion of their id attribute values with the matching portion. */
     matchingSegs = document.querySelectorAll('span[title]');
     for (var m = 0; m < matchingSegs.length; m++)
     if (matchingSegs[m].title==this.title) {
       console.log(this.title);
        matchingSegs[m].classList.toggle('highlight');
        /*style.backgroundColor = '#ffd270'*/
    }
    
}

function undo() {
var segLits = document.querySelectorAll('span[title]');
for (var e = 0; e < segLits.length; e++) 
{
segLits[e].classList.remove('highlight');
}
  
  }
  
