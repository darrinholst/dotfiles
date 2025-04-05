console.log('SSO Auto Approve: Checking for close indicators on');

const closers = [
  `You've been signed out`,
  'You can close this window.'
];

setInterval(() => {
  if (closers.some(text => document.body.textContent.includes(text))) {
    console.log('SSO Auto Approve: closing tab');
    chrome.runtime.sendMessage({ msg: "close_tab" });
  }
}, 500);
