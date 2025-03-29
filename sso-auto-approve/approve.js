console.log('SSO Auto Approve: Running on', window.location.href);

setInterval(() => clickButton('Confirm and continue', 'Allow') , 500);

function clickButton(...buttonsToClick) {
  const buttons = Array.from(document.querySelectorAll('button'));
  const element = buttons.find(btn => buttonsToClick.includes(btn.textContent))

  if (element) {
    console.log('SSO Auto Approve: Clicking button with text', element.textContent);
    element.click();
    return true;
  }

  return false;
}
