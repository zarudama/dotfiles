// ==UserScript==
// @name           Twitter AutoFocus off
// @namespace      http://d.hatena.ne.jp/javascripter/
// @include        http://twitter.com/home
// ==/UserScript==
window.addEventListener('load',
function() {
  document.activeElement.blur();
  this.removeEventListener('load', arguments.callee, false);
},
false);

