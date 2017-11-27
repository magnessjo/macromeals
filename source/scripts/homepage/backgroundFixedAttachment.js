
const element = document.querySelector('div[data-layout="background-attachment-fixed"]');

export default function() {

  const style = document.body.style;
  if (!("backgroundAttachment" in style)) return;

  const oldValue = style.backgroundAttachment;
  style.backgroundAttachment = "fixed";

  const isSupported = (style.backgroundAttachment === 'fixed');
  style.backgroundAttachment = oldValue;

  if (isSupported) {
    element.style.backgroundAttachment = 'fixed';
  }

}
