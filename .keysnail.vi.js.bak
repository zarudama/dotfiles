// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
// ========================================================================= //
//{{%PRESERVE%
// ここにコードを入力して下さい
//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "undefined";
key.helpKey              = "undefined";
key.escapeKey            = "C-v";
key.macroStartKey        = "undefined";
key.macroEndKey          = "undefined";
key.suspendKey           = "C-z";
key.universalArgumentKey = "undefined";
key.negativeArgument1Key = "undefined";
key.negativeArgument2Key = "undefined";
key.negativeArgument3Key = "undefined";

// ================================= Hooks ================================= //

// ============================= Key bindings ============================== //

key.setViewKey('j', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
}, '一行スクロールダウン', false);

key.setViewKey('k', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_UP, true);
}, '一行スクロールアップ', false);

key.setViewKey('h', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_LEFT, true);
}, '左へスクロール', false);

key.setViewKey('l', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RIGHT, true);
}, '右へスクロール', false);

key.setViewKey('C-u', function (ev) {
    goDoCommand("cmd_scrollPageUp");
}, '一画面分スクロールアップ', false);

key.setViewKey('C-b', function (ev) {
    goDoCommand("cmd_scrollPageUp");
}, '一画面分スクロールアップ', false);

key.setViewKey('C-d', function (ev) {
    goDoCommand("cmd_scrollPageDown");
}, '一画面スクロールダウン', false);

key.setViewKey(["g", "g"], function (ev) {
    goDoCommand("cmd_scrollTop");
}, 'ページ先頭へ移動', true);

key.setViewKey('G', function (ev) {
    goDoCommand("cmd_scrollBottom");
}, 'ページ末尾へ移動', true);

key.setViewKey(':', function (ev, arg) {
    shell.input(null, arg);
}, 'コマンドの実行', true);

key.setViewKey('r', function (ev) {
    BrowserReload();
}, '更新', true);

key.setViewKey('H', function (ev) {
    BrowserBack();
}, '戻る', false);

key.setViewKey('L', function (ev) {
    BrowserForward();
}, '進む', false);

key.setViewKey('f', function (ev, arg) {
    ext.exec("hok-start-foreground-mode", arg);
}, 'Start foreground hint mode', true);

key.setViewKey('F', function (ev, arg) {
    ext.exec("hok-start-background-mode", arg);
}, 'Start background hint mode', true);

key.setViewKey(';', function (ev, arg) {
    ext.exec("hok-start-extended-mode", arg);
}, 'Start extended hint mode', true);

key.setViewKey([["g", "t"], ["C-n"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ', false);

key.setViewKey([["g", "T"], ["C-p"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(-1, true);
}, 'ひとつ左のタブへ', false);

key.setViewKey(["g", "u"], function (ev) {
    var uri = getBrowser().currentURI;
    if (uri.path == "/") {
        return;
    }
    var pathList = uri.path.split("/");
    if (!pathList.pop()) {
        pathList.pop();
    }
    loadURI(uri.prePath + pathList.join("/") + "/");
}, '一つ上のディレクトリへ移動', false);

key.setViewKey(["g", "U"], function (ev) {
    var uri = window._content.location.href;
    if (uri == null) {
        return;
    }
    var root = uri.match(/^[a-z]+:\/\/[^/]+\//);
    if (root) {
        loadURI(root, null, null);
    }
}, 'ルートディレクトリへ移動', false);

key.setViewKey('d', function (ev) {
    BrowserCloseTabOrWindow();
}, 'タブ / ウィンドウを閉じる', false);

key.setViewKey('u', function (ev) {
    undoCloseTab();
}, '閉じたタブを元に戻す', false);

key.setViewKey('i', function (ev, arg) {
    util.setBoolPref("accessibility.browsewithcaret", !util.getBoolPref("accessibility.browsewithcaret"));
}, 'Toggle caret mode', true);

key.setViewKey('t', function (ev, arg) {
    shell.input("tabopen ");
}, 'Tab open', true);

key.setViewKey('T', function (ev, arg) {
    shell.input("tabopen! ");
}, 'Tab open', true);

key.setViewKey('o', function (ev, arg) {
    shell.input("open ");
}, 'Open', true);

key.setViewKey('O', function (ev, arg) {
    shell.input("open! ");
}, 'Open', true);

key.setViewKey('y', function (ev, arg) {
    command.setClipboardText(content.document.location.href);
    display.echoStatusBar("Yanked " + content.document.location.href);
}, 'Yank current page address', true);

key.setViewKey('p', function (ev, arg) {
    var url = command.getClipboardText();
    if (url.match(/\s/) || url.indexOf("://") === -1) {
        url = "http://www.google.com/search?q=" + encodeURIComponent(url) + "&ie=utf-8&oe=utf-8&aq=t";
    }
    gBrowser.loadOneTab(url, null, null, null, false);
}, 'Open yanked address or google it', true);

key.setCaretKey('^', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectBeginLine") : goDoCommand("cmd_beginLine");
}, 'キャレットを行頭へ移動', false);

key.setCaretKey('$', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectEndLine") : goDoCommand("cmd_endLine");
}, 'キャレットを行末へ移動', false);

key.setCaretKey('j', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectLineNext") : goDoCommand("cmd_scrollLineDown");
}, 'キャレットを一行下へ', false);

key.setCaretKey('k', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectLinePrevious") : goDoCommand("cmd_scrollLineUp");
}, 'キャレットを一行上へ', false);

key.setCaretKey('l', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectCharNext") : goDoCommand("cmd_scrollRight");
}, 'キャレットを一文字右へ移動', false);

key.setCaretKey([["C-h"], ["h"]], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectCharPrevious") : goDoCommand("cmd_scrollLeft");
}, 'キャレットを一文字左へ移動', false);

key.setCaretKey('w', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectWordNext") : goDoCommand("cmd_wordNext");
}, 'キャレットを一単語右へ移動', false);

key.setCaretKey('W', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectWordPrevious") : goDoCommand("cmd_wordPrevious");
}, 'キャレットを一単語左へ移動', false);

key.setCaretKey('SPC', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectPageNext") : goDoCommand("cmd_movePageDown");
}, 'キャレットを一画面分下へ', false);

key.setCaretKey('b', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectPagePrevious") : goDoCommand("cmd_movePageUp");
}, 'キャレットを一画面分上へ', false);

key.setCaretKey(["g", "g"], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectTop") : goDoCommand("cmd_scrollTop");
}, 'キャレットをページ先頭へ移動', false);

key.setCaretKey('G', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectEndLine") : goDoCommand("cmd_endLine");
}, 'キャレットを行末へ移動', false);

key.setCaretKey('C-d', function (ev) {
    util.getSelectionController().scrollLine(true);
}, '画面を一行分下へスクロール', false);

key.setCaretKey('C-u', function (ev) {
    util.getSelectionController().scrollLine(false);
}, '画面を一行分上へスクロール', false);

key.setCaretKey(',', function (ev) {
    util.getSelectionController().scrollHorizontal(true);
    goDoCommand("cmd_scrollLeft");
}, '左へスクロール', false);

key.setCaretKey('.', function (ev) {
    goDoCommand("cmd_scrollRight");
    util.getSelectionController().scrollHorizontal(false);
}, '右へスクロール', false);

key.setCaretKey(':', function (ev, arg) {
    shell.input(null, arg);
}, 'コマンドの実行', true);

key.setCaretKey('r', function (ev) {
    BrowserReload();
}, '更新', true);

key.setCaretKey('H', function (ev) {
    BrowserBack();
}, '戻る', false);

key.setCaretKey('L', function (ev) {
    BrowserForward();
}, '進む', false);

key.setCaretKey('f', function (ev, arg) {
    ext.exec("hok-start-foreground-mode", arg);
}, 'Start foreground hint mode', true);

key.setCaretKey('F', function (ev, arg) {
    ext.exec("hok-start-background-mode", arg);
}, 'Start background hint mode', true);

key.setCaretKey(';', function (ev, arg) {
    ext.exec("hok-start-extended-mode", arg);
}, 'Start extended hint mode', true);

key.setCaretKey([["g", "t"], ["C-n"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ', false);

key.setCaretKey([["g", "T"], ["C-p"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(-1, true);
}, 'ひとつ左のタブへ', false);

key.setCaretKey(["g", "u"], function (ev) {
    var uri = getBrowser().currentURI;
    if (uri.path == "/") {
        return;
    }
    var pathList = uri.path.split("/");
    if (!pathList.pop()) {
        pathList.pop();
    }
    loadURI(uri.prePath + pathList.join("/") + "/");
}, '一つ上のディレクトリへ移動', false);

key.setCaretKey(["g", "U"], function (ev) {
    var uri = window._content.location.href;
    if (uri == null) {
        return;
    }
    var root = uri.match(/^[a-z]+:\/\/[^/]+\//);
    if (root) {
        loadURI(root, null, null);
    }
}, 'ルートディレクトリへ移動', false);

key.setCaretKey('d', function (ev) {
    BrowserCloseTabOrWindow();
}, 'タブ / ウィンドウを閉じる', false);

key.setCaretKey('u', function (ev) {
    undoCloseTab();
}, '閉じたタブを元に戻す', false);

key.setCaretKey('i', function (ev, arg) {
    util.setBoolPref("accessibility.browsewithcaret", !util.getBoolPref("accessibility.browsewithcaret"));
}, 'Toggle caret mode', true);

key.setCaretKey('t', function (ev, arg) {
    shell.input("tabopen ");
}, 'Tab open', true);

key.setCaretKey('T', function (ev, arg) {
    shell.input("tabopen! ");
}, 'Tab open', true);

key.setCaretKey('o', function (ev, arg) {
    shell.input("open ");
}, 'Open', true);

key.setCaretKey('O', function (ev, arg) {
    shell.input("open! ");
}, 'Open', true);

key.setCaretKey('y', function (ev, arg) {
    command.setClipboardText(content.document.location.href);
    display.echoStatusBar("Yanked " + content.document.location.href);
}, 'Yank current page address', true);

key.setCaretKey('p', function (ev, arg) {
    var url = command.getClipboardText();
    if (url.match(/\s/) || url.indexOf("://") === -1) {
        url = "http://www.google.com/search?q=" + encodeURIComponent(url) + "&ie=utf-8&oe=utf-8&aq=t";
    }
    gBrowser.loadOneTab(url, null, null, null, false);
}, 'Open yanked address or google it', true);

key.setEditKey('C-h', function (ev) {
    goDoCommand("cmd_deleteCharBackward");
}, '前の一文字を削除', false);

