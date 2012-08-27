// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
// ========================================================================= //
//{{%PRESERVE%
// ここにコードを入力して下さい
plugins.options["tanything_opt.keymap"] = {
    "C-z"   : "prompt-toggle-edit-mode",
    "SPC"   : "prompt-next-page",
    "b"     : "prompt-previous-page",
    "j"     : "prompt-next-completion",
    "k"     : "prompt-previous-completion",
    "g"     : "prompt-beginning-of-candidates",
    "G"     : "prompt-end-of-candidates",
    "D"     : "prompt-cancel",
    // Tanything specific actions
    "O"     : "localOpen",
    "q"     : "localClose",
    "p"     : "localLeftclose",
    "n"     : "localRightclose",
    "a"     : "localAllclose",
    "d"     : "localDomainclose",
    "c"     : "localClipUT",
    "C"     : "localClipU",
    "e"     : "localMovetoend",
    "p"     : "localTogglePin"
};

//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "C-g";
key.helpKey              = "<f1>";
key.escapeKey            = "C-q";
key.macroStartKey        = "<f3>";
key.macroEndKey          = "<f4>";
key.suspendKey           = "<f2>";
key.universalArgumentKey = "C-u";
key.negativeArgument1Key = "C--";
key.negativeArgument2Key = "C-M--";
key.negativeArgument3Key = "M--";

// ================================= Hooks ================================= //

hook.addToHook('KeyBoardQuit', function (aEvent) {
    if (key.currentKeySequence.length) {
        return;
    }
    command.closeFindBar();
    var marked = command.marked(aEvent);
    if (util.isCaretEnabled()) {
        if (marked) {
            command.resetMark(aEvent);
        } else {
            if ("blur" in aEvent.target) {
                aEvent.target.blur();
            }
            gBrowser.focus();
            _content.focus();
        }
    } else {
        goDoCommand("cmd_selectNone");
    }
    if (KeySnail.windowType === "navigator:browser" && !marked) {
        key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_ESCAPE, true);
    }
});

// ============================= Key bindings ============================== //


key.setGlobalKey('C-M-r', function (ev) {
    userscript.reload();
}, '設定ファイルを再読み込み', true);

key.setGlobalKey('M-x', function (ev, arg) {
    ext.select(arg, ev);
}, 'エクステ一覧表示', true);

key.setGlobalKey('M-:', function (ev) {
    command.interpreter();
}, 'JavaScript のコードを評価', true);

key.setGlobalKey(["<f1>", "b"], function (ev) {
    key.listKeyBindings();
}, 'キーバインド一覧を表示', false);

key.setGlobalKey('C-m', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RETURN, true);
}, 'リターンコードを生成', false);

key.setGlobalKey(["<f1>", "F"], function (ev) {
    openHelpLink("firefox-help");
}, 'Firefox のヘルプを表示', false);

key.setGlobalKey(["C-x", "l"], function (ev) {
    command.focusToById("urlbar");
}, 'ロケーションバーへフォーカス', true);

key.setGlobalKey(["C-x", "g"], function (ev) {
    command.focusToById("searchbar");
}, '検索バーへフォーカス', true);

key.setGlobalKey(["C-x", "t"], function (ev) {
    command.focusElement(command.elementsRetrieverTextarea, 0);
}, '最初のインプットエリアへフォーカス', true);

key.setGlobalKey(["C-x", "s"], function (ev) {
    command.focusElement(command.elementsRetrieverButton, 0);
}, '最初のボタンへフォーカス', true);

key.setGlobalKey('M-w', function (ev) {
    command.copyRegion(ev);
}, '選択中のテキストをコピー', true);

key.setGlobalKey(['C-s'], function (ev) {
    command.iSearchForwardKs(ev);
}, 'Emacs ライクなインクリメンタル検索', true);

key.setGlobalKey(['C-r'], function (ev) {
    command.iSearchBackwardKs(ev);
}, 'Emacs ライクな逆方向インクリメンタル検索', true);

key.setGlobalKey(["C-x", "k"], function (ev) {
    BrowserCloseTabOrWindow();
}, 'タブ / ウィンドウを閉じる', false);

key.setGlobalKey(["C-x", "K"], function (ev) {
    closeWindow(true);
}, 'ウィンドウを閉じる', false);

key.setGlobalKey(["C-c", "u"], function (ev) {
    undoCloseTab();
}, '閉じたタブを元に戻す', false);

key.setGlobalKey(["C-x", "n"], function (ev) {
    OpenBrowserWindow();
}, 'ウィンドウを開く', false);

// key.setGlobalKey('C-M-l', function (ev) {
//     getBrowser().mTabContainer.advanceSelectedTab(1, true);
// }, 'ひとつ右のタブへ', false);

// key.setGlobalKey('C-M-h', function (ev) {
//     getBrowser().mTabContainer.advanceSelectedTab(-1, true);
// }, 'ひとつ左のタブへ', false);

key.setGlobalKey(["C-x", "C-c"], function (ev) {
    goQuitApplication();
}, 'Firefox を終了', true);

key.setGlobalKey(["C-x", "o"], function (ev, arg) {
    command.focusOtherFrame(arg);
}, '次のフレームを選択', false);

key.setGlobalKey(["C-x", "1"], function (ev) {
    window.loadURI(ev.target.ownerDocument.location.href);
}, '現在のフレームだけを表示', true);

key.setGlobalKey(["C-x", "C-f"], function (ev) {
    BrowserOpenFileWindow();
}, 'ファイルを開く', true);

key.setGlobalKey(["C-x", "C-s"], function (ev) {
    saveDocument(window.content.document);
}, 'ファイルを保存', true);

key.setGlobalKey(["C-c", "C-c", "C-v"], function (ev) {
    toJavaScriptConsole();
}, 'Javascript コンソールを表示', true);

key.setGlobalKey(["C-c", "C-c", "C-c"], function (ev) {
    command.clearConsole();
}, 'Javascript コンソールの表示をクリア', true);

//////////////////////////////////////////
// edit-mode
//////////////////////////////////////////

key.setEditKey(["C-x", "h"], function (ev) {
    command.selectAll(ev);
}, '全て選択', true);

key.setEditKey([["C-SPC"], ["C-@"]], function (ev) {
    command.setMark(ev);
}, 'マークをセット', true);

key.setEditKey('C-o', function (ev) {
    command.openLine(ev);
}, '行を開く (Open line)', false);

key.setEditKey([["C-x", "u"], ["C-_"]], function (ev) {
    display.echoStatusBar("Undo!", 2000);
    goDoCommand("cmd_undo");
}, 'アンドゥ', false);

key.setEditKey('C-\\', function (ev) {
    display.echoStatusBar("Redo!", 2000);
    goDoCommand("cmd_redo");
}, 'リドゥ', false);

key.setEditKey('C-a', function (ev) {
    command.beginLine(ev);
}, '行頭へ移動', false);

key.setEditKey('C-e', function (ev) {
    command.endLine(ev);
}, '行末へ', false);

key.setEditKey('C-f', function (ev) {
    command.nextChar(ev);
}, '一文字右へ移動', false);

key.setEditKey('C-b', function (ev) {
    command.previousChar(ev);
}, '一文字左へ移動', false);

key.setEditKey('M-f', function (ev) {
    command.forwardWord(ev);
}, '一単語右へ移動', false);

key.setEditKey('M-b', function (ev) {
    command.backwardWord(ev);
}, '一単語左へ移動', false);

key.setEditKey('C-n', function (ev) {
    command.nextLine(ev);
}, '一行下へ', false);

key.setEditKey('C-p', function (ev) {
    command.previousLine(ev);
}, '一行上へ', false);

key.setEditKey([["g", "t"], ["C-M-n"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ', false);

key.setEditKey([["g", "T"], ["C-M-p"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(-1, true);
}, 'ひとつ左のタブへ', false);

key.setEditKey('C-v', function (ev) {
    command.pageDown(ev);
}, '一画面分下へ', false);

key.setEditKey('M-v', function (ev) {
    command.pageUp(ev);
}, '一画面分上へ', false);

key.setEditKey('M-<', function (ev) {
    command.moveTop(ev);
}, 'テキストエリア先頭へ', false);

key.setEditKey('M->', function (ev) {
    command.moveBottom(ev);
}, 'テキストエリア末尾へ', false);

key.setEditKey('C-d', function (ev) {
    goDoCommand("cmd_deleteCharForward");
}, '次の一文字削除', false);

key.setEditKey('C-h', function (ev) {
    goDoCommand("cmd_deleteCharBackward");
}, '前の一文字を削除', false);

key.setEditKey('M-d', function (ev) {
    command.deleteForwardWord(ev);
}, '次の一単語を削除', false);

// mikio
// key.setEditKey([["C-<backspace>"], ["M-<delete>"]], function (ev) {
//     command.deleteBackwardWord(ev);
// }, '前の一単語を削除', false);

key.setEditKey('M-u', function (ev, arg) {
    command.wordCommand(ev, arg, command.upcaseForwardWord, command.upcaseBackwardWord);
}, '次の一単語を全て大文字に (Upper case)', false);

key.setEditKey('M-l', function (ev, arg) {
    command.wordCommand(ev, arg, command.downcaseForwardWord, command.downcaseBackwardWord);
}, '次の一単語を全て小文字に (Lower case)', false);

key.setEditKey('M-c', function (ev, arg) {
    command.wordCommand(ev, arg, command.capitalizeForwardWord, command.capitalizeBackwardWord);
}, '次の一単語をキャピタライズ', false);

key.setEditKey('C-k', function (ev) {
    command.killLine(ev);
}, 'カーソルから先を一行カット (Kill line)', false);

key.setEditKey('C-y', command.yank, '貼り付け (Yank)', false);

key.setEditKey('M-y', command.yankPop, '古いクリップボードの中身を順に貼り付け (Yank pop)', true);

key.setEditKey('C-M-y', function (ev) {
    if (!command.kill.ring.length) {
        return;
    }
    let (ct = command.getClipboardText()) (!command.kill.ring.length || ct != command.kill.ring[0]) &&
        command.pushKillRing(ct);
    prompt.selector({message: "Paste:", collection: command.kill.ring, callback: function (i) {if (i >= 0) {key.insertText(command.kill.ring[i]);}}});
}, '以前にコピーしたテキスト一覧から選択して貼り付け', true);

key.setEditKey('C-w', function (ev) {
    goDoCommand("cmd_copy");
    goDoCommand("cmd_delete");
    command.resetMark(ev);
}, '選択中のテキストを切り取り (Kill region)', true);

key.setEditKey(["C-x", "r", "d"], function (ev, arg) {
    command.replaceRectangle(ev.originalTarget, "", false, !arg);
}, '矩形削除', true);

key.setEditKey(["C-x", "r", "t"], function (ev) {
    prompt.read("String rectangle: ", function (aStr, aInput) {command.replaceRectangle(aInput, aStr);}, ev.originalTarget);
}, '矩形置換', true);

key.setEditKey(["C-x", "r", "o"], function (ev) {
    command.openRectangle(ev.originalTarget);
}, '矩形行空け', true);

key.setEditKey(["C-x", "r", "k"], function (ev, arg) {
    command.kill.buffer = command.killRectangle(ev.originalTarget, !arg);
}, '矩形キル', true);

key.setEditKey(["C-x", "r", "y"], function (ev) {
    command.yankRectangle(ev.originalTarget, command.kill.buffer);
}, '矩形ヤンク', true);

key.setEditKey('M-n', function (ev) {
    command.walkInputElement(command.elementsRetrieverTextarea, true, true);
}, '次のテキストエリアへフォーカス', false);

key.setEditKey('M-p', function (ev) {
    command.walkInputElement(command.elementsRetrieverTextarea, false, true);
}, '前のテキストエリアへフォーカス', false);

//////////////////////////////////////////
// view-mode
//////////////////////////////////////////
key.setViewKey('j', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
}, '一行スクロールダウン', false);

key.setViewKey('k', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_UP, true);
}, '一行スクロールアップ', false);

key.setViewKey([['h'],['C-h']], function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_LEFT, true);
}, '左へスクロール', false);

key.setViewKey('l', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RIGHT, true);
}, '右へスクロール', false);

key.setViewKey('C-b', function (ev) {
    goDoCommand("cmd_scrollPageUp");
}, '一画面分スクロールアップ', false);

key.setViewKey('C-f', function (ev) {
    goDoCommand("cmd_scrollPageDown");
}, '一画面スクロールダウン', false);

key.setViewKey(["g", "g"], function (ev) {
    goDoCommand("cmd_scrollTop");
}, 'ページ先頭へ移動', true);

key.setViewKey('G', function (ev) {
    goDoCommand("cmd_scrollBottom");
}, 'ページ末尾へ移動', true);

// key.setViewKey(':', function (ev, arg) {
//     shell.input(null, arg);
// }, 'コマンドの実行', true);

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

key.setViewKey([["g", "t"], ["C-M-n"],["C-n"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ', false);

key.setViewKey([["g", "T"], ["C-M-p"],["C-p"]], function (ev) {
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

//////////////////////////////////////////
// Caret-mode
//////////////////////////////////////////
key.setCaretKey([['^'],['0']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectBeginLine") : goDoCommand("cmd_beginLine");
}, 'キャレットを行頭へ移動', false);

key.setCaretKey('$', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectEndLine") : goDoCommand("cmd_endLine");
}, 'キャレットを行末へ移動', false);

key.setCaretKey('j', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectLineNext") : command.nextLine(ev);;
}, 'キャレットを一行下へ', false);

key.setCaretKey('k', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectLinePrevious") : command.previousLine(ev);
}, 'キャレットを一行上へ', false);

key.setCaretKey('l', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectCharNext") : command.nextChar(ev);
}, 'キャレットを一文字右へ移動', false);

key.setCaretKey([['h'],['C-h']], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectCharPrevious") : command.previousChar(ev);
}, 'キャレットを一文字左へ移動', false);

key.setCaretKey('w', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectWordNext") : goDoCommand("cmd_wordNext");
}, 'キャレットを一単語右へ移動', false);

key.setCaretKey('b', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectWordPrevious") : goDoCommand("cmd_wordPrevious");
}, 'キャレットを一単語左へ移動', false);

key.setCaretKey('C-f', function (ev) {
     ev.target.ksMarked ? goDoCommand("cmd_selectPageNext") : goDoCommand("cmd_movePageDown");
}, 'キャレットを一画面分下へ', false);

key.setCaretKey('C-b', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectPagePrevious") : goDoCommand("cmd_movePageUp");
}, 'キャレットを一画面分上へ', false);

key.setCaretKey(["g", "g"], function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectTop") : goDoCommand("cmd_scrollTop");
}, 'キャレットをページ先頭へ移動', false);

key.setCaretKey('G', function (ev) {
    goDoCommand("cmd_scrollBottom");
}, 'ページ末尾へ移動', true);

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

key.setCaretKey([["g", "t"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ', false);

key.setCaretKey([["g", "T"]], function (ev) {
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
    command.setMark(ev);
}, 'マークをセット', true);

key.setCaretKey('p', function (ev, arg) {
    var url = command.getClipboardText();
    if (url.match(/\s/) || url.indexOf("://") === -1) {
        url = "http://www.google.com/search?q=" + encodeURIComponent(url) + "&ie=utf-8&oe=utf-8&aq=t";
    }
    gBrowser.loadOneTab(url, null, null, null, false);
}, 'Open yanked address or google it', true);

//////////////////////////////////////////
// mikio
//////////////////////////////////////////
// Caret Hint
// key.setCaretKey('s', function (ev, arg) {
//     ext.exec("swap-caret", arg, ev);
// }, 'キャレットを交換', true);

// key.setViewKey('c', function (ev, arg) {
//     nsPreferences.setBoolPref("accessibility.browsewithcaret", true);
// }, 'キャレットモード', true);

key.setCaretKey('ESC', function (ev, arg) {
    nsPreferences.setBoolPref("accessibility.browsewithcaret", false);
}, 'キャレットモードを抜ける', true);

// Hatebnail
key.setGlobalKey(["C-x", "a", "b"], function (ev, arg) {
    ext.exec("list-hateb-items", arg);
}, "はてなブックマークのアイテムを一覧表示", true);

// key.setViewKey("c", function (ev, arg) {
//     ext.exec("list-hateb-comments", arg);
// }, "はてなブックマークのコメントを一覧表示", true);

// key.setViewKey('a', function (ev, arg) {
//     ext.exec("hateb-bookmark-this-page");
// }, 'このページをはてなブックマークに追加', true);


// // ----------------------------------
// // site local keymap
// // ----------------------------------
// key.setGlobalKey("C-;", function (ev, arg) {
//     ext.exec("site-local-keymap-toggle-status", arg, ev);
// }, 'Site local keymap', true);

// ----------------------------------
// tanything
// ----------------------------------
key.setViewKey("a", function (ev, arg) {
                   ext.exec("tanything", arg);
               }, "タブを一覧表示", true);


// // ----------------------------------
// // Hok
// // ----------------------------------
// key.setViewKey('f', function (aEvent, aArg) {
//     ext.exec("hok-start-foreground-mode", aArg);
// }, 'Hit a Hint を開始', true);

// key.setViewKey('F', function (aEvent, aArg) {
//     ext.exec("hok-start-background-mode", aArg);
// }, 'リンクをバックグラウンドで開く Hit a Hint を開始', true);

// key.setViewKey(';', function (aEvent, aArg) {
//     ext.exec("hok-start-extended-mode", aArg);
// }, 'HoK - 拡張ヒントモード', true);

key.setViewKey(['C-c', 'C-e'], function (aEvent, aArg) {
     ext.exec("hok-start-continuous-mode", aArg);
}, 'リンクを連続して開く Hit a Hint を開始', true);

// // ----------------------------------
// // tab
// // ----------------------------------
// key.setViewKey('C-k', function (ev) {
//     BrowserCloseTabOrWindow();
// }, 'タブ / ウィンドウを閉じる');

// key.setViewKey('C-l', function (ev) {
//     getBrowser().mTabContainer.advanceSelectedTab(1, true);
// }, 'ひとつ右のタブへ', false);

// key.setViewKey('C-h', function (ev) {
//     getBrowser().mTabContainer.advanceSelectedTab(-1, true);
// }, 'ひとつ左のタブへ', false);

// ----------------------------------
// my edit key
// ----------------------------------
key.setEditKey('C-/', function (ev) {
    display.echoStatusBar("Undo!", 2000);
    goDoCommand("cmd_undo");
}, 'アンドゥ');

key.setEditKey('C-M-/', function (ev) {
    display.echoStatusBar("Redo!", 2000);
    goDoCommand("cmd_redo");
}, 'リドゥ');

key.setEditKey('C-M-h', function (ev) {
    command.deleteBackwardWord(ev);
}, '前の一単語を削除', false);

