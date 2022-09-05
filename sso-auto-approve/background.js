chrome.runtime.onMessage.addListener((request, sender) => {
  if (request.msg === 'close_tab') chrome.tabs.remove(sender.tab.id);
});
