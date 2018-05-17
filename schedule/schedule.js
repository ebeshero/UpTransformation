window.addEventListener('DOMContentLoaded', init, false);
function init() {
    document.getElementById('expand').addEventListener('click', expand, false);
    document.getElementById('collapse').addEventListener('click', collapse, false);
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