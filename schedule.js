window.addEventListener('DOMContentLoaded', init, false);
function init() {
    document.getElementById('expand').addEventListener('click', expand, false);
    document.getElementById('collapse').addEventListener('click', collapse, false);
    var localExpands = document.querySelectorAll('li > button.localExpand');
    for (var i = 0, length = localExpands.length; localExpands[i]; i++) {
        localExpands[i].addEventListener('click', localExpand, false);
    }
    var localCollapses = document.querySelectorAll('li > button.localCollapse');
    for (var i = 0, length = localCollapses.length; localCollapses[i]; i++) {
        localCollapses[i].addEventListener('click', localCollapse, false);
    }
}
function expand() {
    var sections = document.querySelectorAll('section > ul > li > ol');
    for (var i = 0, length = sections.length; sections[i]; i++) {
        sections[i].style.display = 'block';
    }
}
function collapse() {
    var sections = document.querySelectorAll('section > ul > li > ol');
    for (var i = 0, length = sections.length; sections[i]; i++) {
        sections[i].style.display = 'none';
    }
}
function localExpand() {
    this.nextElementSibling.nextElementSibling.style.display = 'block';
}
function localCollapse() {
    this.nextElementSibling.style.display = 'none';
}