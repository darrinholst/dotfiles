if (!document.querySelector('button[data-testid="allow-access-button"]')) {
  chrome.runtime.sendMessage({ msg: "close_tab" })
}
