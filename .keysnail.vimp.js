// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
// ========================================================================= //
//{{%PRESERVE%
// ここにコードを入力して下さい
//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "C-g";

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

///////////////////////////////////////////////////////////////////////////////
// global
///////////////////////////////////////////////////////////////////////////////

key.setGlobalKey('C-j', null);

key.setGlobalKey(['C-x', 'a', 'b'], function (ev, arg) {
    ext.exec("list-hateb-items", arg);
}, 'はてなブックマークのアイテムを一覧表示', true);


key.setGlobalKey('C-M-s', function (ev) {
    openUILinkIn('view-source:' + content.location.href, 'tab');
}, 'ソースを表示');

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

key.setGlobalKey('C-s', function (ev) {
    command.iSearchForwardKs(ev);
}, 'Emacs ライクなインクリメンタル検索', true);

key.setGlobalKey('C-r', function (ev) {
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

key.setGlobalKey([["C-c", "C-n"],["C-c", "n"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'ひとつ右のタブへ', false);

key.setGlobalKey([["C-c", "C-p"],["C-c", "p"]], function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(-1, true);
}, 'ひとつ左のタブへ', false);

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

///////////////////////////////////////////////////////////////////////////////
// edit
///////////////////////////////////////////////////////////////////////////////

key.setEditKey('C-M-h', function (ev) {
    command.deleteBackwardWord(ev);
}, '前の一単語を削除');

key.setEditKey(["C-x", "h"], function (ev) {
    command.selectAll(ev);
}, '全て選択', true);

key.setEditKey([["C-SPC"], ["C-@"]], function (ev) {
    command.setMark(ev);
}, 'マークをセット', true);

key.setEditKey('C-o', function (ev) {
    command.openLine(ev);
}, '行を開く (Open line)', false);

key.setEditKey([["C-x", "u"], ["C-_"], ["C-/"]], function (ev) {
    display.echoStatusBar("Undo!", 2000);
    goDoCommand("cmd_undo");
}, 'アンドゥ', false);

key.setEditKey('C-\\', function (ev) {
    display.echoStatusBar("Redo!", 2000);
    goDoCommand("cmd_redo");
}, 'リドゥ', false);

// key.setEditKey('C-a', function (ev) {
//     command.beginLine(ev);
// }, '行頭へ移動', false);

// key.setEditKey('C-e', function (ev) {
//     command.endLine(ev);
// }, '行末へ', false);

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

// key.setEditKey('C-d', function (ev) {
//     goDoCommand("cmd_deleteCharForward");
// }, '次の一文字削除', false);

// key.setEditKey('C-h', function (ev) {
//     goDoCommand("cmd_deleteCharBackward");
// }, '前の一文字を削除', false);

key.setEditKey('M-d', function (ev) {
    command.deleteForwardWord(ev);
}, '次の一単語を削除', false);

key.setEditKey([["C-<backspace>"], ["M-<delete>"]], function (ev) {
    command.deleteBackwardWord(ev);
}, '前の一単語を削除', false);

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

// key.setEditKey(["C-x", "r", "d"], function (ev, arg) {
//     command.replaceRectangle(ev.originalTarget, "", false, !arg);
// }, '矩形削除', true);

// key.setEditKey(["C-x", "r", "t"], function (ev) {
//     prompt.read("String rectangle: ", function (aStr, aInput) {command.replaceRectangle(aInput, aStr);}, ev.originalTarget);
// }, '矩形置換', true);

// key.setEditKey(["C-x", "r", "o"], function (ev) {
//     command.openRectangle(ev.originalTarget);
// }, '矩形行空け', true);

// key.setEditKey(["C-x", "r", "k"], function (ev, arg) {
//     command.kill.buffer = command.killRectangle(ev.originalTarget, !arg);
// }, '矩形キル', true);

// key.setEditKey(["C-x", "r", "y"], function (ev) {
//     command.yankRectangle(ev.originalTarget, command.kill.buffer);
// }, '矩形ヤンク', true);

// key.setEditKey('M-n', function (ev) {
//     command.walkInputElement(command.elementsRetrieverTextarea, true, true);
// }, '次のテキストエリアへフォーカス', false);

// key.setEditKey('M-p', function (ev) {
//     command.walkInputElement(command.elementsRetrieverTextarea, false, true);
// }, '前のテキストエリアへフォーカス', false);

