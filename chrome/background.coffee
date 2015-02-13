chrome.browserAction.onClicked.addListener (tab) ->
  chrome.tabs.insertCSS {file: 'content.css'}
  chrome.tabs.executeScript {file: 'content.js'}
