window.addEventListener('DOMContentLoaded', init, false);
function init() {
    document.getElementById('expand').addEventListener('click', expand, false);
    document.getElementById('collapse').addEventListener('click', collapse, false);
    var localExpands = document.querySelectorAll('button.localExpand');
    for (var i = 0, length = localExpands.length; localExpands[i]; i++) {
        localExpands[i].addEventListener('click', localExpand, false);
    }
    var localCollapses = document.querySelectorAll('button.localCollapse');
    for (var i = 0, length = localCollapses.length; localCollapses[i]; i++) {
        localCollapses[i].addEventListener('click', localCollapse, false);
    }
    var answers = document.querySelectorAll('button.answer');
    for (var i = 0, length = answers.length; answers[i]; i++) {
        answers[i].addEventListener('click', showAnswer, false);
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
    this.parentElement.nextElementSibling.style.display = 'block';
}
function localCollapse() {
    this.parentElement.nextElementSibling.style.display = 'none';
}
function showAnswer() {
    var target = this.nextElementSibling;
    if (target.tagName == 'DIV') {
        target.style.display = 'block';
        target.style.whiteSpace = 'pre';
        target.style.backgroundColor = 'lightcyan';
    } else {
        target.style.display = 'inline';
    }
}