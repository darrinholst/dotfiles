const closers = [
  `You've been signed out`,
  'You can close this window.'
];

console.log('SSO Auto Approve: Checking for close indicators on');

setInterval(() => {
  if (closers.some(text => document.body.textContent.includes(text))) {
    console.log('SSO Auto Approve: closing tab');
    chrome.runtime.sendMessage({ msg: "close_tab" });
  }
}, 500);
